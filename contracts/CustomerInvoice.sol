// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ICustomerInvoice} from "./interfaces/ICustomerInvoice.sol";

contract CustomerInvoice is ICustomerInvoice, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private customers;
  uint256[] private operations;
  uint256[] private facilities;
  uint256[][] private materialLists;
  uint256[][] private quantityLists;
  uint256[] private timestamps;

  event Created(uint256 indexed _id);

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(
    uint256 _customerId,
    uint256 _operationId,
    uint256 _facilityId,
    uint256[] memory _materials,
    uint256[] memory _quantities,
    uint256 _timestamp
  )
  public onlyRole(OWNER)
  returns (uint256 customerInvoiceId){
    uint256 id = customers.length;
    customers.push(_customerId);
    operations.push(_operationId);
    facilities.push(_facilityId);
    materialLists.push(_materials);
    quantityLists.push(_quantities);
    timestamps.push(_timestamp);
    emit Created(id);
    return id;
  }

  function get(uint256 id)
  public view
  returns (
    uint256 customerId,
    uint256 operationId,
    uint256 facilityId,
    uint256[] memory materials,
    uint256[] memory quantities,
    uint256 timestamp
  ) {
    return (customers[id], operations[id], facilities[id], materialLists[id], quantityLists[id], timestamps[id]);
  }
}
