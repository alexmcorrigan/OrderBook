Feature: Order Cancellations
  As a trader
  I want to cancel an order I have submitted

  Scenario: Cancel a buy order
    Given an order book that looks like:
      |Bids           |Offers     |
      |(1) 100 @ 95.5 |           |
    When I submit the following cancel request:
      |Order ID |Original Order ID |Side  |Quantity |
      |2        |1                 |B     |100      |
    Then the order book looks like:
      |Bids           |Offers     |
      |               |           |

  Scenario: Cancel a sell order
    Given an order book that looks like:
      |Bids           |Offers         |
      |               |(1) 100 @ 95.5 |
    When I submit the following cancel request:
      |Order ID |Original Order ID |Side  |Quantity |
      |2        |1                 |S     |100      |
    Then the order book looks like:
      |Bids           |Offers     |
      |               |           |

  Scenario: A cancelled order can not be cancelled again
    Given an order book that looks like:
      |Bids           |Offers         |
      |               |(1) 100 @ 95.5 |
    When I submit the following cancel request:
      |Order ID |Original Order ID |Side  |Quantity |
      |2        |1                 |S     |100      |
    Then the order book looks like:
      |Bids           |Offers     |
      |               |           |
    When I submit the following cancel request:
      |Order ID |Original Order ID |Side  |Quantity |
      |2        |1                 |S     |100      |
    Then the request is rejected with message "Order with order id 1 does not exist"
