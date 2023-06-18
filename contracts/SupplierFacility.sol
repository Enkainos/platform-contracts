// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ISupplierFacility} from "./interfaces/ISupplierFacility.sol";

contract SupplierFacility is ISupplierFacility, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private names;
  uint256[] private suppliers;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){}

  function create(string memory _name, uint256 _supplierId)
  public onlyRole(OWNER)
  returns (uint256 facilityId) {
    uint256 id = names.length;
    names[id] = _name;
    suppliers[id] = _supplierId;
    return id;
  }

  function get(uint256 id)
  public view
  returns (string memory name, uint256 supplierId) {
    return (names[id], suppliers[id]);
  }
}
