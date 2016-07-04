Feature: We can place and move the robot around

  Scenario: Simple place, move and report
    Given a file named "instructions_2.txt" with:
      """
        PLACE 0,0,NORTH
        MOVE
        REPORT
      """
    When I successfully run `toy_robot_simulator.rb instructions_2.txt`
    Then the stdout should contain "0,1,NORTH"

  Scenario: Simple place, turn and report
    Given a file named "instructions_1.txt" with:
      """
        PLACE 0,0,NORTH
        LEFT
        REPORT
      """
    When I successfully run `toy_robot_simulator.rb instructions_1.txt`
    Then the stdout should contain "0,0,WEST"

  Scenario: Longer turn and move, then report
    Given a file named "instructions_3.txt" with:
      """
        PLACE 1,2,EAST
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
      """
    When I successfully run `toy_robot_simulator.rb instructions_3.txt`
    Then the stdout should contain "3,3,NORTH"

  Scenario: Unplaced robots do nothing
    Given a file named "instructions_test.txt" with:
      """
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
      """
    When I successfully run `toy_robot_simulator.rb instructions_test.txt`
    Then the stdout should not contain anything

  Scenario: Robots do not walk off the table (5x5)
    Given a file named "instructions_4.txt" with:
    """
      PLACE 2,4,NORTH
      MOVE
      REPORT
    """
    When I successfully run `toy_robot_simulator.rb instructions_4.txt`
    Then the stdout should contain "2,4,NORTH"

  Scenario: Robots can be placed multiple times
    Given a file named "multiple_instructions.txt" with:
    """
      PLACE 2,2,NORTH
      MOVE
      PLACE 1,1,EAST
      REPORT
    """
    When I successfully run `toy_robot_simulator.rb multiple_instructions.txt`
    Then the stdout should contain "1,1,EAST"

  Scenario: Illegal place commands are ignored
    Given a file named "illegal_instructions.txt" with:
    """
      PLACE 7,7,NORTH
      REPORT
    """
    When I successfully run `toy_robot_simulator.rb illegal_instructions.txt`
    Then the stdout should not contain anything

  Scenario: Illegal input is ignored
    Given a file named "illegal_instructions_1.txt" with:
    """
      PLACE 1,2,NORTH
      move
      no such command
      REPORT
    """
    When I successfully run `toy_robot_simulator.rb illegal_instructions_1.txt`
    Then the stdout should contain "1,2,NORTH"
    And the stdout should contain "Unknown instruction: move"
    And the stdout should contain "Unknown instruction: no such command"