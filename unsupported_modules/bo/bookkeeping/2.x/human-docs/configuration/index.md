# Configuration

Financial data is sensitive, so the most important configuration step is getting
the permissions right. Setup then means creating your accounts and recording
transactions.

## Permissions

The module provides three separate permissions, which you assign at
**People → Permissions** (`/admin/people/permissions`):

| Permission | What it allows |
|------------|----------------|
| `view bookkeeping` | See the accounts, transactions, and reports — read‑only access to the books. |
| `manage bookkeeping` | Create and manage accounts and transactions (the day‑to‑day bookkeeping work). |
| `administer bookkeeping` | Administer the module. |

Because this is real financial data, **restrict `manage bookkeeping` and
`administer bookkeeping` to trusted finance staff**, and hand out
`view bookkeeping` to anyone who only needs to read the books.

## Accounts and transactions

Bookkeeping stores its data as entities:

- **Accounts** — the ledger accounts your books are organized around. Create the
  set of accounts you need before recording activity.
- **Transactions** — balanced entries of debits and credits recorded against
  those accounts. As a double‑entry system, each transaction is meant to balance
  (total debits equal total credits).

Manage these from their entity collections in the admin UI (available to users
with the `manage bookkeeping` permission).

## Reporting and export

Reporting is built on **Views**, so financial reports are Views you can view
and, if you have the rights, adjust like any other Drupal View. The
**Views Data Export** integration lets you export figures to **CSV** for use in
spreadsheets or other accounting tools.
