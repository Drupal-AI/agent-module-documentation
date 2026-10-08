# Smashing Invoice — manual setup guide

**Smashing Invoice** (`smashing_invoice`) is an admin-only invoicing tool. It lets
an organization manage its clients, its employees, and the allocations that tie an
employee to a client at a per-hour or per-month price, then generate hour-based or
month-based tax invoices and download each as a PDF. Everything is reachable from a
single index page (`invoice/links`), which appears as an **Invoice service** item in
the Drupal admin toolbar once the module is enabled and the cache is cleared.

The problem it targets is straightforward billing for a services organization: keep
your clients, staff, and rates in one place, and turn "who worked how many
hours/days for which client" into a formatted tax invoice — complete with your
organization's logo, bank details, and GST/tax lines — that you can send out as a
PDF. Invoice amounts are computed from the days or hours worked and the allocated
price, with 18% IGST applied when GST is enabled.

Data lives in five custom database tables (for invoices, employees, clients,
allocations, and organization info). The organization table holds sensitive
financial details — bank account number, IFSC, PAN, and GSTIN — so it is important
to keep access tight. Every route in the module is gated behind the single
**administer smashing_invoice** permission, so there are no anonymous endpoints and
the invoices and financial data are not exposed to the public; but there is no
per-record ownership, meaning anyone holding that permission can read and download
every client's invoices and financial data. Grant it only to trusted staff.

The module renders its PDFs with the **TCPDF** library (`tecnickcom/tcpdf`), which
you must install with Composer. It runs on Drupal 8.8, 9, and 10.

> **A caution before you rely on this.** The project is marked **unsupported** and
> **obsolete** by its maintainer, it is **not covered** by Drupal's security advisory
> policy, and it does not declare Drupal 11 support. Weigh that before using it on a
> production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the TCPDF library and the module
   with Composer and enable it.
2. [Configuration](configuration/index.md) — the setup workflow: organization info,
   clients, employees, allocations, and generating invoices.

## Where it lives in the admin menu

After enabling the module and clearing the cache, an **Invoice service** item
appears in the admin toolbar. Hover it for the dropdown, or open the index page at
`invoice/links`, from which every operation (adding clients and employees,
allocating them, generating invoices, and downloading PDFs) is linked.
