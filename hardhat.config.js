require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const API_KEY_URL = process.env.API_KEY_URL;

const MUMBAI_PRIVATE_KEY = process.env.MUMBAI_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.10",
  networks: {
    mumbai: {
      url: API_KEY_URL,
      accounts: [MUMBAI_PRIVATE_KEY],
    }
  }
};