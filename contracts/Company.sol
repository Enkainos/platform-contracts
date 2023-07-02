// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ICompany} from "./interfaces/ICompany.sol";

contract Company is ICompany, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private names;

  event Created(uint256 indexed _id);

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(string memory _name)
  public onlyRole(OWNER)
  returns (uint256 companyId){
    uint256 id = names.length;
    names.push(_name);
    emit Created(id);
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name) {
    return names[id];
  }
}
