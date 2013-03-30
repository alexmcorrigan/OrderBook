Feature: Order Book Price Priority
  As a trader
  If I submit an order at a better price to other existing orders
  I expect it to rest in the order book above orders with a worse price, and below orders with a better price

  Scenario: Buy Order Price Priority
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |B    |100      |90.00  |
      |2        |B    |100      |91.00  |
    Then the order book looks like:
      |Bids            |Offers |
      |(2) 100 @ 91.00 |       |
      |(1) 100 @ 90.00 |       |
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |3        |B    |100      |91.50  |
    Then the order book looks like:
      |Bids            |Offers |
      |(3) 100 @ 91.50 |       |
      |(2) 100 @ 91.00 |       |
      |(1) 100 @ 90.00 |       |

  Scenario: Sell Order Price Priority
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |S    |100      |93.00  |
      |2        |S    |100      |92.00  |
    Then the order book looks like:
      |Bids         |Offers         |
      |             |(2) 100 @ 92.00|
      |             |(1) 100 @ 93.00|
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |3        |S    |100      |91.50  |
    Then the order book looks like:
      |Bids         |Offers         |
      |             |(3) 100 @ 91.50|
      |             |(2) 100 @ 92.00|
      |             |(1) 100 @ 93.00|
