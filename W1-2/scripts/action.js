const {ethers, network} = require("hardhat");
const Addr = require("/..")

async function main() {
    let {owner}  = await ethers.getSigners();
    let counter = await ethers.getContractAt("Counter",
    Addr.address,
    owner);
    await counter.add(3);
    let newValue = await counter.counter();
    console.log("新的值"+newValue);
}