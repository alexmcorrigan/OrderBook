class OrderDoesNotExistError < RuntimeError
  def initialize(cancel_request)
    @cancel_request = cancel_request
    super 'Order with order id %s does not exist' % [cancel_request.original_order_id]
  end
end