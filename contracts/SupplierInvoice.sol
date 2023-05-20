// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract SupplierInvoice is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private supplier;
  uint256[] private operation;
  uint256[][] private materials;
  uint256[][] private quantities;
  uint256[] private timestamp;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(
    string memory _supplierId,
    uint256 memory _operationId,
    uint256[] memory _materials,
    uint256[] memory _quantities
  )
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory){
    uint256 id = supplier.length;
    supplier[id] = _supplierId;
    operation[id] = _operationId;
    materials[id] = _materials;
    quantities[id] = _quantities;
    timestamp[id] = _timestamp;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (
    uint256 memory supplierId,
    uint256 memory operationId,
    uint256[] memory materials,
    uint256[] memory quantities,
    uint256 memory timestamp
  ) {
    return (supplier[id], operation[id], materials[id], quantities[id], timestamp[id]);
  }
}
