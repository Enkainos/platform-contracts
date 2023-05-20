// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract Material is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private name;
  string[] private units;
  uint8[] private precision;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(string memory _name, string memory _unit, uint8 _precision)
  public onlyOwner
  returns (uint256 memory materialId) {
    uint256 id = name.length;
    name[id] = _name;
    units = _unit;
    precision = _precision;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (string memory name, string memory units, string memory precision) {
    return (name[id], units[id], precision[id]);
  }
}
