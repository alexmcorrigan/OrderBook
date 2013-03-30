Given(/^an empty order book$/) { @order_book = OrderBook.new }

Given /^an order book that looks like:$/ do |order_book_representation|
  @order_book = OrderBook.new
  orders = Array.new
  orders.concat extract_from_book_representation('Bids', 'B', order_book_representation)
  orders.concat extract_from_book_representation('Offers', 'S', order_book_representation)
  send_to_order_book(orders)
end

When /^I submit the following orders:$/ do |order_definitions|
  orders = build_order_array order_definitions
  send_to_order_book(orders)
end

When /^I submit the following cancel request:$/ do |cancel_definition|
  begin
    build_cancellation_request(cancel_definition).each do |cancel_request|
      @order_book.action_cancel_request(cancel_request)
    end
  rescue OrderDoesNotExistError
    @cancel_request_error = $!
  end
end

Then /^the order book looks like:$/ do |order_book_representation|
  expected_bids = extract_from_book_representation('Bids', 'B', order_book_representation)
  expected_offers = extract_from_book_representation('Offers', 'S', order_book_representation)
  @order_book.bids.prioritise_orders.should == expected_bids
  @order_book.asks.prioritise_orders.should == expected_offers
end

Then /^the request is rejected with message "(.*)"$/ do |error_message|
  @cancel_request_error.message.should match error_message
end

def extract_from_book_representation(book_side, order_side, order_book_representation)
  orders = Array.new
  order_book_representation.hashes.each do |order_book_level|
    unless order_book_level[book_side].empty?
      orders << order_from_shorthand(order_side, order_book_level[book_side])
    end
  end
  orders
end

def send_to_order_book(orders)
  orders.each { |order| order.add_to_order_book @order_book }
end

def build_order_array(order_definitions)
  orders = Array.new
  order_definitions.hashes.each do |order_definition|
    orders << OrderFactory.new_order(
        order_definition['Order ID'],
        order_definition['Side'],
        DUMMY_SYMBOL,
        order_definition['Quantity'],
        order_definition['Price'])
  end
  orders
end

def build_cancellation_request(cancel_definitions)
  cancel_requests = Array.new
  cancel_definitions.hashes.each do |cancel_definition|
    cancel_requests << CancellationRequest.new(
        cancel_definition['Order ID'],
        cancel_definition['Original Order ID'],
        DUMMY_SYMBOL,
        cancel_definition['Side'],
        cancel_definition['Quantity'],
        cancel_definition['Price'])
  end
  cancel_requests
end

def order_from_shorthand(side, shorthand_order)
  shorthand_elements = shorthand_order.split(' ')
  order_id = shorthand_elements[0].scan(/\((\w+)\)/)[0][0]
  quantity = shorthand_elements[1]
  price = shorthand_elements[3]
  OrderFactory.new_order(order_id, side, DUMMY_SYMBOL, quantity, price)
end