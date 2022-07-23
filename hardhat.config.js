require("@nomicfoundation/hardhat-toolbox");
//require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

const POLYGON_URl = process.env.POLYGON_URl;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks:{
    mumbai:{
      url: "https://polygon-mumbai.g.alchemy.com/v2/4Oq7X-8NScNIpLJIFP8Q0-bAaoRXPc_h ", 
      accounts:[PRIVATE_KEY]
    }
  },
  etherscan:{
    apiKey: process.env.POLYGON_APIKEY
  }
};
