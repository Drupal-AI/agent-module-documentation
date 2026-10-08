# Configuration

Commerce Funds is money-handling software, so the goal of configuration is not
just to switch features on but to decide *who* can move money and *how* it is
authorized. Work through the administration settings, then the permissions, then
place the user-facing blocks.

> **Security first.** Balance changes, transfers and withdrawals are financial
> operations. Restrict the funds permissions tightly, require administrator
> approval for withdrawals, keep the transaction log enabled, and reconcile it.
> Do not grant funds permissions broadly, and test deposit / withdraw / transfer
> / escrow against adversarial cases before going live with real value.

## Fees

You can charge a fee on transactions, chosen per transaction type:

- a **fixed** amount,
- a **percentage** of the transaction amount, or
- a **percentage with a minimum** applied.

The configured fee can be shown in real time under the amount field's description
so users see the cost before they confirm.

## Withdrawal methods and requests

- **Enable and disable the allowed withdrawal methods** (for example bank
  account, cheque, PayPal). If you use Encrypt, the users' stored withdrawal
  details are encrypted.
- Withdrawals are not automatic: users **send withdrawal requests**, and an
  administrator **approves or declines** them. Keep this approval step in place —
  it is your control point before money leaves the system.

## Notification emails

The module sends email notifications when transactions occur. You can edit the
message text for these notifications so they match your store's voice and include
the details customers expect.

## Currency conversion

For multi-currency stores, users can convert one currency into another. Use
**Commerce Exchanger** to manage the exchange rates that drive the conversion.

## Forms vs. transaction fields

You can either use the module's default operation forms (deposit, transfer,
escrow, withdraw) or disable those routes and instead attach the provided
**transaction field** to any fieldable entity to build your own flows.

## User-facing blocks and views

Place the blocks the module provides where your users need them:

- a **user balance** block,
- an **operations** block listing everything a user can do (deposit, transfer,
  escrow payment, and so on),
- an **admin site-balance** block, and
- a per-user balance block shown on user profile pages.

Three **views** are provided to manage the different transaction lists for both
administrators and users (transactions, withdrawal requests, incoming/outgoing
escrow).

## Permissions

At **People → Permissions**, grant the funds permissions carefully. Give ordinary
users only the operations you intend them to have, and reserve administrative
capabilities (approving withdrawals, viewing all transactions, managing fees and
methods) to trusted roles. Broad permissions on a wallet system are the most
common way money leaks — err on the side of restriction.

## Before you go live

Run the full deposit → transfer → escrow → withdraw cycle with test accounts,
including deliberately adversarial attempts (spending more than the balance,
transferring to oneself, replaying a withdrawal), and confirm the transaction log
records every balance change. Reconcile the log against balances before opening
the feature to real customers.
