// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {IOperation} from "./interfaces/IOperation.sol";

contract Operation is IOperation, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private names;
  uint256[] private companies;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(string memory _name, uint256 _companyId)
  public onlyRole(OWNER)
  returns (uint256 operationId) {
    uint256 id = names.length;
    names.push(_name);
    companies.push(_companyId);
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, uint256 companyId) {
    return (names[id], companies[id]);
  }
}
