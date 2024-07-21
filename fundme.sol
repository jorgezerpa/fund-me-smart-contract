// get fund from users 
// withdreaw funds
// set a minimum funding value

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minumumUsd = 5;


    function fund() public payable{
      
        msg.value; // number of wei send with the message
        require(msg.value >= 1e18, "did not sent enough money.");
    }

    function getPrice() public view returns (uint256){
        address EthToUSDFromChainLink = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(EthToUSDFromChainLink);
        (,int256 price,,, ) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // ading the missing 10 decimal prices (price has only 8)
    }

    function getConvertionRate() public{}


    // function withdraw() public {}

}