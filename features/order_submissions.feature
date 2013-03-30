Feature: Order Submissions
  As a trader
  In order to execute trades in an order book
  I want submit orders to the order book

  Scenario: Submit a buy order
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |B    |100      |95.5   |
    Then the order book looks like:
      |Bids           |Offers     |
      |(1) 100 @ 95.5 |           |

  Scenario: Submit a sell order
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |S    |100      |96.5   |
    Then the order book looks like:
      |Bids       |Offers        |
      |           |(1) 100 @ 96.5|

  Scenario: Submit a buy and sell order
    Given an empty order book
    When I submit the following orders:
      |Order ID |Side |Quantity |Price  |
      |1        |B    |100      |95.5   |
      |2        |S    |100      |96.5   |
    Then the order book looks like:
      |Bids           |Offers         |
      |(1) 100 @ 95.5 |(2) 100 @ 96.5 |
