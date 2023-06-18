// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ICustomerInvoice} from "./interfaces/ICustomerInvoice.sol";

contract CustomerInvoice is ICustomerInvoice, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private customers;
  uint256[] private operations;
  uint256[][] private materialLists;
  uint256[][] private quantityLists;
  uint256[] private timestamps;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){}

  function create(
    uint256 _customerId,
    uint256 _operationId,
    uint256[] memory _materials,
    uint256[] memory _quantities,
    uint256 _timestamp
  )
  public onlyRole(OWNER)
  returns (uint256 customerInvoiceId){
    uint256 id = customers.length;
    customers[id] = _customerId;
    operations[id] = _operationId;
    materialLists[id] = _materials;
    quantityLists[id] = _quantities;
    timestamps[id] = _timestamp;
    return id;
  }

  function get(uint256 id)
  public view
  returns (
    uint256 customerId,
    uint256 operationId,
    uint256[] memory materials,
    uint256[] memory quantities,
    uint256 timestamp
  ) {
    return (customers[id], operations[id], materialLists[id], quantityLists[id], timestamps[id]);
  }
}
