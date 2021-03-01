pragma solidity ^0.5.0;

contract TieredProfitSplitter {
    address payable employee_one; 
    address payable employee_two; 
    address payable employee_three; 
    // address payable owner = msg.sender;
    
    //the constructor will require us to input three addresses
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

     /*the balance function will show us the profit pool, post the distribution.
    it should be zero. */
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
    /*This is the crux of the code.   Within this function, the variable "points" is used to 
    denote percent.  It will convert the message value (i.e. the profit pool) into various percentage values. Each 
    employee will receive one of three percentage values of msg.value.  The variable "amount" will be used to 
    distribute three different percentage values of the pool to the corresponding employee.  Technically, because 
    we have defined amount as an unsigned integer, there should be a remainder after distributing the profit pool. 
    The variable "total" is supposed to compute the remainder post the three distributions.  Total should then be 
    sent back to employee #1, the CEO.However, as of now the code utilizes floats and fully distributes the profits */
    function deposit() public payable {
        // require(msg.sender == owner, "You do not have permsission to deposit");
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        // Step 2: Add the `amount` to `total` to keep a running total
        // Step 3: Transfer the `amount` to the employee
        amount = points*60;
        total += amount;
        employee_one.transfer(amount);
        amount = points*25;
        total += amount;
        employee_two.transfer(amount);
        amount = points*15;
        total += amount;
        employee_three.transfer(amount);
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}