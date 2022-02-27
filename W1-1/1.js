var  ethers = require('ethers');
var wallet = ethers.Wallet.createRandom();
var mnemonic = wallet.mnemonic;
console.log(mnemonic);
var path = wallet.path;
console.log("钱包path：",path)
var privateKey = wallet.privateKey;
console.log("钱包私钥：",privateKey)
var address = wallet.address;
console.log("钱包地址：",address)