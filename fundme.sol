// get fund from users 
// withdreaw funds
// set a minimum funding value

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

  uint256 public constant minimumUsd = 5e18;

  address[] public funders;
  mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

  function fund() public payable {
    require(msg.value.getConvertionRate() >= minimumUsd, "did not sent enough ETh");
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value;
  }

    address public immutable owner;

    // executed only when contract is deployed
  constructor() {
    owner = msg.sender;
  }


  function withdraw() public onlyOwner {
    for(uint256 funderIndex = 0; funderIndex<funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }
    funders = new address[](0);

    // Withdraw the funds
    // // 1. transfer --> max 2300 gas --> throw an error
    // payable(msg.sender).transfer(address(this).balance);
    // // 2. send --> max 2300 gas --> returns a boolean
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);
    // require(sendSuccess, "Send Failed");
    // 3. call -> forward all gas or set gas --> returns a boolean
    (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call Failed");
  }

  // Modifier ---> keyword to put on function decoration to add some functionality very quickly
  modifier onlyOwner() {
    require(msg.sender == owner, "Must be the owner!");
    // whatever before _; executes before the function starts.
    _; 
    // whatever after _; executes after the function finish. 
  }

}