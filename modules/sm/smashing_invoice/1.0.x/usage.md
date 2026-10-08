<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smashing Invoice is an admin tool for generating hour- or month-based tax invoices: it manages employees, clients, client/employee allocations and organization details in custom database tables and renders a downloadable PDF invoice via the TCPDF library.
---
An index page (`invoice/links`) links all the operations. Forms add/edit employees, clients, allocations, organization info, and generate invoices (hour-based or month-based). Controllers list employees, clients, allocations and invoices, delete records, and build the invoice PDF. Data lives in five custom tables (`invoice_table`, `employee_table`, `client_table`, `allocation_table`, `organization_info_table`) — the organization table holds bank account number, IFSC, PAN and GSTIN. The invoice PDF (`company_invoice_controller`, route `company_invoice.pdf`) reads an `invoice_number` from the request, joins the invoice and client tables, and outputs an inline `Invoice.pdf` through TCPDF. Requires the `tecnickcom/tcpdf` Composer library.

Every route requires the single `administer smashing_invoice` permission, so there are no anonymous endpoints and the invoice PDFs and financial/PII data are not exposed to the public; there is no per-record ownership model (it is one admin realm). The three delete controllers (`delete/employee`, `delete/client`, `delete/allocation`) and several list/PDF handlers read identifiers directly from `$_GET`/`$_REQUEST`. All database access uses the query builder with parameterised conditions, and invoice HTML is emitted only into the TCPDF document. Setup: install TCPDF, enable the module, add your organization info, then add clients/employees, allocate them, and generate invoices.
---
- Add and edit employees for invoicing
- Add and edit clients with PAN/TIN, GSTIN, address and contact details
- Allocate employees to clients with a per-hour or per-month price
- Store your organization's billing and bank details
- Generate a month-based tax invoice
- Generate an hour-based tax invoice
- Download an invoice as a TCPDF-rendered PDF
- List all generated invoices with client names
- List all employees and clients
- Edit an existing client/employee allocation
- Apply 18% IGST when GST status is enabled
- Show organization logo and bank details on the invoice
- Delete an employee, client or allocation record
- Reach every operation from the `invoice/links` index page
- Compute invoice amounts from days/hours worked and price
- Include the organization's account and IFSC on the PDF
- Present a "Bill to"/"Bill from" tax-invoice layout
- Restrict all invoice operations to the `administer smashing_invoice` permission
- Keep client financial records inside Drupal tables
- Update organization information after initial setup
- Produce receipts of payment for client billing
- Track working days vs days/hours worked per employee
