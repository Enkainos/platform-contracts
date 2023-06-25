// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ISupplier} from "./interfaces/ISupplier.sol";

contract Supplier is ISupplier, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private names;
  uint256[][] private operationLists;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(string memory _name)
  public onlyRole(OWNER)
  returns (uint256 supplierId) {
    uint256 id = names.length;
    names.push(_name);
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, uint256[] memory operations) {
    return (names[id], operationLists[id]);
  }

  function addOperation(uint256 id, uint256 operationId)
  public onlyRole(OWNER) {
    operationLists[id].push(operationId);
  }

  function removeOperation(uint256 id, uint256 index)
  public onlyRole(OWNER) {
    operationLists[id][index] = 0; //free up data better?
  }
}
