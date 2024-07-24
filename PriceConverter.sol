// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

  function getPrice() public view returns (uint256) {
    address EthToUSDFromChainLink = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    AggregatorV3Interface priceFeed = AggregatorV3Interface(EthToUSDFromChainLink);
    (, int256 price, , , ) = priceFeed.latestRoundData();
    return uint256(price * 1e10); // adding the missing 10 decimal places (price has only 8)
  }

  function getConvertionRate(uint256 ethAmount) public view returns (uint256) {
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUsd;
  }
}