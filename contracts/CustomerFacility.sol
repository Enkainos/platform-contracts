// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ICustomerFacility} from "./interfaces/ICustomerFacility.sol";

contract CustomerFacility is ICustomerFacility, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private names;
  uint256[] private customers;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(string memory _name, uint256 _customerId)
  public onlyRole(OWNER)
  returns (uint256 customerFacilityId) {
    uint256 id = names.length;
    names.push(_name);
    customers.push(_customerId);
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, uint256 customerId) {
    return (names[id], customers[id]);
  }
}
