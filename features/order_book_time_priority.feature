Feature: Order Book Time Priority
  As a trader
  If I submit an order
  I expect it to rest in the order book below other orders at the same price, submitted before mine

  Scenario: Buy Order Time Priority
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |B    |100      |90.00  |
      |2        |B    |100      |90.00  |
    Then the order book looks like:
      |Bids             |Offers |
      |(1) 100 @ 90.00  |       |
      |(2) 100 @ 90.00  |       |
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |3        |B    |100      |90.00  |
    Then the order book looks like:
      |Bids             |Offers |
      |(1) 100 @ 90.00  |       |
      |(2) 100 @ 90.00  |       |
      |(3) 100 @ 90.00  |       |

  Scenario: Sell Order Time Priority
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |S    |100      |90.00  |
      |2        |S    |100      |90.00  |
    Then the order book looks like:
      |Bids |Offers         |
      |     |(1) 100 @ 90.00|
      |     |(2) 100 @ 90.00|
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |3        |S    |100      |90.00  |
    Then the order book looks like:
      |Bids |Offers         |
      |     |(1) 100 @ 90.00|
      |     |(2) 100 @ 90.00|
      |     |(3) 100 @ 90.00|

  Scenario: Price / Time Priority
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |B    |100      |92.00  |
      |2        |B    |100      |91.00  |
      |3        |B    |100      |92.00  |
      |4        |B    |100      |91.00  |
      |5        |B    |100      |93.00  |
      |6        |B    |100      |93.00  |
    Then the order book looks like:
      |Bids             |Offers         |
      |(5) 100 @ 93.00  |               |
      |(6) 100 @ 93.00  |               |
      |(1) 100 @ 92.00  |               |
      |(3) 100 @ 92.00  |               |
      |(2) 100 @ 91.00  |               |
      |(4) 100 @ 91.00  |               |