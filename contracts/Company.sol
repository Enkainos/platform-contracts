// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract Company is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private name;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(string memory _name)
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory companyId){
    uint256 id = name.length;
    name[id] = _name;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (string memory name) {
    return name[id];
  }
}
