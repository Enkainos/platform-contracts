// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ISupplierInvoice} from "./interfaces/ISupplierInvoice.sol";

contract SupplierInvoice is ISupplierInvoice, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private suppliers;
  uint256[] private operations;
  uint256[][] private materialLists;
  uint256[][] private quantityLists;
  uint256[] private timestamps;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(
    uint256 _supplierId,
    uint256 _operationId,
    uint256[] memory _materials,
    uint256[] memory _quantities,
    uint256 _timestamp
  )
  public onlyRole(OWNER)
  returns (uint256 supplierInvoiceId){
    uint256 id = suppliers.length;
    suppliers.push(_supplierId);
    operations.push(_operationId);
    materialLists.push(_materials);
    quantityLists.push(_quantities);
    timestamps.push(_timestamp);
    return id;
  }

  function get(uint256 id)
  public view
  returns (
    uint256 supplierId,
    uint256 operationId,
    uint256[] memory materials,
    uint256[] memory quantities,
    uint256 timestamp
  ) {
    return (suppliers[id], operations[id], materialLists[id], quantityLists[id], timestamps[id]);
  }
}
