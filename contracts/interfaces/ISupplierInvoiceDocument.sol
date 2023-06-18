// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/IAccessControl.sol";

interface ISupplierInvoiceDocument is IAccessControl {

  function create(
    uint256 _invoiceId,
    string memory _documentUrl
  ) external
  returns (uint256 supplierInvoiceDocumentId);

  function get(uint256 id) external view
  returns (uint256 invoiceId, string memory documentUrl);
}
