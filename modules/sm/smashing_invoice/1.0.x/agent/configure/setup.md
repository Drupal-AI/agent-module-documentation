<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Smashing Invoice

Prerequisite: install TCPDF — `composer require tecnickcom/tcpdf` — then enable the module and grant `administer smashing_invoice`.

Workflow (all pages linked from `invoice/links`):
1. **Organization info** — `organization/info` (`OrganizationInfo`): add your org name, address, bank account, IFSC, PAN, GSTIN and logo. View at `organization_info/display`, edit at `organization_info/update`. Only the row with `id = 1` is used by the invoice/display controllers.
2. **Clients** — `add/client` / `edit/client`, list at `see/clients`.
3. **Employees** — `add/employee` / `edit/employee`, list at `see/employees`.
4. **Allocate** — `allocate/client_emp` (or `allocate/client-employee`) ties an employee to a client with a per-hour or per-month price; per-client allocations are shown at `employees/display?sr_id=<client id>`.
5. **Generate invoice** — `generate/invoice` (`GenerateInvoice`), choosing hour- or month-based.
6. **Invoices** — list at `company_invoice-list`; download the PDF via `company_invoice_controller?invoice_number=<n>`.

Notes for agents:
- The org table stores sensitive financial data (bank account number, IFSC, PAN, GSTIN); keep the `administer smashing_invoice` permission tightly scoped.
- Phone fields are validated to 10 digits; website is validated as a URL.
