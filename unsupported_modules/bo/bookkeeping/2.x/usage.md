<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bookkeeping provides double-entry accounting (accounts, transactions) inside Drupal.

---

Bookkeeping is a double-entry bookkeeping system for Drupal — modeling accounts and balanced transactions (debits/credits) as entities, with Views-based reporting and CSV export, so organizations can keep basic financial books inside Drupal (often alongside Commerce).

Financial data is sensitive: permissions separate viewing (`view bookkeeping`), managing (`manage bookkeeping`), and administration (`administer bookkeeping`) — restrict manage/admin to trusted finance staff. Depends on Commerce `commerce_price`, core `views`, `dynamic_entity_reference`, and `views_data_export`; supports Drupal 10 and 11.

---

- Provide double-entry bookkeeping.
- Model accounts and transactions.
- Enforce balanced debits/credits.
- Report via Views.
- Export to CSV.
- Keep books inside Drupal.
- Gate viewing with `view bookkeeping`.
- Gate managing with `manage bookkeeping`.
- Gate admin with `administer bookkeeping`.
- Restrict manage/admin to finance staff.
- Treat financial data as sensitive.
- Depend on Commerce `commerce_price`, core `views`.
- Depend on `dynamic_entity_reference`, `views_data_export`.
- Support Drupal 10 and 11.
- Handle accounting
- Track finances
- Report balances
- Support finance teams
