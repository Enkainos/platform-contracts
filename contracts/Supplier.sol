// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract Supplier is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private name;
  uint256[][] private operations;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(string memory _name)
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory supplierId) {
    uint256 id = name.length;
    name[id] = _name;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (string memory name, uint256[] memory operations) {
    return (name[id], operations[id]);
  }

  function addOperation(uint256 calldata id, uint256 memory operationId)
  public require(hasRole(OWNER, msg.sender)) {
    operations[id].push(operationId);
  }

  function removeOperation(uint256 calldata id, uint256 calldata index)
  public require(hasRole(OWNER, msg.sender)) {
    operations[id][index] = 0; //free up data better?
  }
}
