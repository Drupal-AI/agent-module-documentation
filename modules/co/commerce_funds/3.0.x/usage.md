<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Funds adds per-user wallet balances to Drupal Commerce so users can deposit, transfer, hold in escrow, convert, pay with, and request withdrawals of funds.

---

Install it with `composer require drupal/commerce_funds` and enable it (`drush en commerce_funds`); it pulls in Commerce's order, checkout, payment, product and store modules and needs a configured store and at least one currency. Configuration lives at **Commerce → Funds** (`/admin/commerce/funds`, permission **Administer Funds**), split into **Global**, **Fees**, **Withdrawal methods**, **Exchange rates** and **Mails** tabs: set fixed and/or percentage **fees** per operation, choose which **withdrawal methods** (bank account, check, PayPal, Skrill) users may use, pick a **commerce_exchanger** provider to enable currency **conversion**, and edit the notification **emails**. Grant users the operation permissions they need (`deposit funds`, `transfer funds`, `create escrow payment`, `withdraw funds`, `convert currencies`, `view own transactions`) and keep the admin permissions (`administer funds`, `administer transactions`, `administer withdrawal requests`) restricted. Users then work from the pages under **`/user/funds/*`** (deposit, transfer, escrow, converter, withdraw) and see their balance and operations through the **User balance** and **Funds operations** blocks; deposits go through a normal Commerce checkout, and **withdrawal requests are approved or declined by an administrator**. To skip the standalone pages you can disable those routes in Global settings and instead attach the **Transaction** field (`commerce_funds_transaction`, with a per-operation widget) to any entity, or let users pay for products with the **Funds balance** payment gateway. Install **Encrypt** to store payout details encrypted, and **Rules** to perform transactions from reactions.

---

- Give each user a per-currency wallet balance.
- Let users deposit money via Commerce checkout.
- Let users transfer funds to other users.
- Create escrow payments and release them later.
- Cancel a pending escrow to refund the issuer.
- Convert one currency into another (needs Commerce Exchanger).
- Pay for site products with a funds balance.
- Let users submit withdrawal requests.
- Approve or decline withdrawal requests as an admin.
- Configure fixed, percentage, or percentage-with-minimum fees per operation.
- Accrue fees to a site balance.
- Show real-time fee calculation under the amount field.
- Enable only the withdrawal methods you support.
- Collect bank / check / PayPal / Skrill payout details per user.
- Encrypt stored payout details with the Encrypt module.
- Send configurable email notifications on each transaction.
- View and search all transactions in admin views.
- Show balance and operations blocks to users.
- Embed operation forms on any entity with the Transaction field.
- Disable the default /user/funds routes when using fields.
- Perform transactions from Rules reactions.
- Run a multi-currency marketplace balance.
- Restrict the administration permissions tightly.
- Anonymize a user's transactions when the account is deleted.
