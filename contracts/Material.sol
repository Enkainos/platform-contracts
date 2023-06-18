// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {IMaterial} from "./interfaces/IMaterial.sol";

contract Material is IMaterial, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private names;
  string[] private units;
  uint8[] private precisions;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){}

  function create(string memory _name, string memory _unit, uint8 _precision)
  public onlyRole(OWNER)
  returns (uint256 materialId) {
    uint256 id = names.length;
    names[id] = _name;
    units[id] = _unit;
    precisions[id] = _precision;
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, string memory unit, uint8 precision) {
    return (names[id], units[id], precisions[id]);
  }
}
