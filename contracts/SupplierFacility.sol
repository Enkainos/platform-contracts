// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract SupplierFacility is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  string[] private name;
  uint256[] private supplier;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(string memory _name, uint256 memory _supplierId)
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory facilityId) {
    uint256 id = name.length;
    name[id] = _name;
    supplier[id] = _supplierId;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (string memory name, uint256 memory supplierId) {
    return (name[id], supplier[id]);
  }
}
