// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ISupplierInvoice is IAccessControl {

  function create(
    uint256 _supplierId,
    uint256 _operationId,
    uint256[] memory _materials,
    uint256[] memory _quantities,
    uint256 _timestamp
  ) external
  returns (uint256 supplierInvoiceId);

  function get(uint256 id) external view
  returns (
    uint256 supplierId,
    uint256 operationId,
    uint256[] memory materialLists,
    uint256[] memory quantityLists,
    uint256 timestamp
  );
}
