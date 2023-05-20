// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract CustomerFacility is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private name;
  uint256[] private customer;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(string memory _name, uint256 memory _customerId)
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory) {
    uint256 id = name.length;
    name[id] = _name;
    customer[id] = _customerId;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (string memory name, uint256 memory customerId) {
    return (name[id], customer[id]);
  }
}
