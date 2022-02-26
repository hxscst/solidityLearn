pragma solidity >=0.4.22 <0.9.0;

contract Counter {
    uint8 public counter;

    constructor() {
        counter = 0;
        }

    function count() public {
        counter = counter + 1;
        }


    function set(uint x) public {
        counter = counter + x;
        }
}