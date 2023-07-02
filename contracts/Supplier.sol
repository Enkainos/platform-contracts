// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ISupplier} from "./interfaces/ISupplier.sol";

contract Supplier is ISupplier, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  struct SupplierData {
    string name;
    uint256[] operations;
  }

  mapping(uint256 => SupplierData) private suppliers;
  uint256[] private supplierIds;

  event Created(uint256 indexed _id);

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(string memory _name)
  public onlyRole(OWNER)
  returns (uint256 supplierId) {
    uint256 id = supplierIds.length;
    uint256[] memory operations = new uint256[](0);
    suppliers[id] = SupplierData(_name, operations);
    supplierIds.push(id);
    emit Created(id);
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, uint256[] memory operations) {
    return (suppliers[id].name, suppliers[id].operations);
  }

  function addOperation(uint256 id, uint256 operationId)
  public onlyRole(OWNER) {
    uint256[] storage operations = suppliers[id].operations;
    operations.push(operationId);
  }

  function removeOperation(uint256 id, uint256 operationId)
  public onlyRole(OWNER) {
    uint256[] storage operations = suppliers[id].operations;
    // Find index of operation ID
    uint256 index = 0;
    bool isFound = false;
    for(uint256 i = 0; i < operations.length; i++){
      if(operationId == operations[i]){
        index = i;
        isFound = true;
        break;
      }
    }
    require(isFound, "Operation not found");
    // Swap last operation ID and ID to be removed (if needed)
    if(index != operations.length){
      uint256 lastOperation = operations[operations.length - 1];
      operations[index] = lastOperation;
    }
    // Remove last element of operations list
    operations.pop();
  }
}
