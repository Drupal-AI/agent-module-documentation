<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smashing Invoice routes & data model

All routes require permission `administer smashing_invoice` and set `no_cache: TRUE`.

Forms:
- `add_employee_form` `add/employee` — AddEmp
- `add_client_form` `add/client` — AddClient
- `allocate_emp_to_client` `allocate/client_emp` and `allocation_form` `allocate/client-employee` — Allocate
- `editAllocation_form` `edit/allocation` — EditAllocation
- `edit_employee_form` `edit/employee`, `edit_client_form` `edit/client` — EditEmployee / EditClient
- `generateInvoice_form` `generate/invoice` — GenerateInvoice (hour/month via HourBasedForm / MonthBasedForm / SelectForm)
- `organiztion_info_form` `organization/info`, `organiztion_info_edit` `organization_info/update` — OrganizationInfo / EditOrganizationInfo

Controllers:
- `invoice.index` `invoice/links` — link index
- `show_employee` `see/employees`, `show_client` `see/clients` — listings
- `employees_table_display` `employees/display` & `invoice_select` `select_method` — DisplayEmployees::showdata (reads `$_REQUEST['sr_id']`)
- `companies_invoice.table` `company_invoice-list` — invoice list with Download links
- `company_invoice.pdf` `company_invoice_controller` — CompanyInvoiceController::index; reads `$_REQUEST['invoice_number']`, joins invoice_table+client_table, outputs `Invoice.pdf` via TCPDF
- `organiztion_info_display` `organization_info/display` — DisplayOrganizationInfo::orgData
- `delete_employee` `delete/employee`, `delete_client` `delete/client`, `delete_allocation` `delete/allocation` — Delete* controllers

Tables: `invoice_table`, `employee_table`, `client_table`, `allocation_table`, `organization_info_table`.

Notes:
- **Access:** a single coarse permission gates everything; there is no per-record ownership, so any holder can read/download every client's invoice and financial data (expected for this design, but note for least-privilege).
- **Queries:** all queries use the DB API with parameterised `condition()`; invoice HTML is written only into the TCPDF document, not returned as a browser HTML response.
