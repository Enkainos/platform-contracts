// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract CustomerInvoice is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private customer;
  uint256[] private operation;
  uint256[][] private materials;
  uint256[][] private quantities;
  uint256[] private timestamp;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(
    string memory _customerId,
    uint256 memory _operationId,
    uint256[] memory _materials,
    uint256[] memory _quantities,
    uint256 memory _timestamp
  )
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory){
    uint256 id = customer.length;
    customer[id] = _customerId;
    operation[id] = _operationId;
    materials[id] = _materials;
    quantities[id] = _quantities;
    timestamp[id] = _timestamp;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (
    uint256 memory customerId,
    uint256 memory operationId,
    uint256[] memory materials,
    uint256[] memory quantities,
    uint256 memory timestamp
  ) {
    return (customer[id], operation[id], materials[id], quantities[id], timestamp[id]);
  }
}
