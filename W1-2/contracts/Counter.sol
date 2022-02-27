pragma solidity >=0.4.22 <0.9.0;

import "hardhat/console.sol";

contract Counter {
    uint8 public counter;

    constructor(uint8 x) {
        counter = x;
        }

    function count() public {
        counter = counter + 1;
        console.log("调用count后的值:", _greeting);
        }


    function set(uint8 x) public {
        counter = counter + x;
        }
}