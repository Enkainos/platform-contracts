// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ICustomer} from "./interfaces/ICustomer.sol";

contract Customer is ICustomer, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  struct CustomerData {
    string name;
    uint256[] operations;
  }

  mapping(uint256 => CustomerData) private customers;
  uint256[] private customerIds;

  event Created(uint256 indexed _id);

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(string memory _name)
  public onlyRole(OWNER)
  returns (uint256 customerId) {
    uint256 id = customerIds.length;
    uint256[] memory operations = new uint256[](0);
    customers[id] = CustomerData(_name, operations);
    customerIds.push(id);
    emit Created(id);
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, uint256[] memory operations) {
    return (customers[id].name, customers[id].operations);
  }

  function addOperation(uint256 id, uint256 operationId)
  public onlyRole(OWNER) {
    uint256[] storage operations = customers[id].operations;
    operations.push(operationId);
  }

  function removeOperation(uint256 id, uint256 operationId)
  public onlyRole(OWNER) {
    uint256[] storage operations = customers[id].operations;
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
