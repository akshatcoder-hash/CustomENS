// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// Don't forget to add this import
import { StringUtils } from "./libraries/StringUtils.sol";
import "hardhat/console.sol";

contract Domains {
  // Here's our domain fosscu!
  string public fosscu;

  mapping(string => address) public domains;
  mapping(string => string) public records;
		
  // We make the contract "payable" by adding this to the constructor
  constructor(string memory _fosscu) payable {
    fosscu = _fosscu;
    console.log("%s name service deployed", _fosscu);
  }
		
  // This function will give us the price of a domain based on length
  function price(string calldata name) public pure returns(uint) {
    uint len = StringUtils.strlen(name);
    require(len > 0);
    if (len == 3) {
      return 5 * 10**17; 
    } else if (len == 4) {
      return 3 * 10**17; 
       // This is 0.3
    } else {
      return 1 * 10**17;
    }
  }
  // Added "payable" modifier to register function
  function register(string calldata name) public payable{
    require(domains[name] == address(0));
    
    uint _price = price(name);

    // Check if enough Matic was paid in the transaction
    require(msg.value >= _price, "Not enough Matic paid");

    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }

  function getAddress(string calldata name) public view returns (address) {
      return domains[name];
  }

  function setRecord(string calldata name, string calldata record) public {
      // Check that the owner is the transaction sender
      require(domains[name] == msg.sender);
      records[name] = record;
  }

  function getRecord(string calldata name) public view returns(string memory) {
      return records[name];
  }
}
