pragma solidity ^0.5.0;

contract AssociateProfitSplitter {
//    address payable owner = msg.sender;
    address payable employee_one; 
    address payable employee_two; 
    address payable employee_three;
    
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

    /*this is the crux of the code.   Within this function, the variable "amount" is 
    1/3 of the message value (i.e. the profit pool).  Each employee receives this "amount".
    Technically, because we have defined amount as an unsigned integer, there will
    often times be a remainder when distributing the pool.   This function is written to 
    re-distribute the remainder back to the owner (HR).  However, as of now the code utilizes 
    floats and fully distributes the profits */
    function deposit() public payable {
       
       // require(msg.sender == owner, "You do not have permsission to deposit");
        uint amount = msg.value/3; 
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);
        msg.sender.transfer(msg.value - amount*3);
    }
    // the fallback function calls upon the deposit function to ensure zero balance.
    function() external payable {
        deposit();
    }
}