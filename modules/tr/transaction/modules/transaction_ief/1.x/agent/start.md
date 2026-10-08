<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# transaction_ief (Transaction Inline Entity Form) — agent index

Submodule of **transaction** — an **Inline Entity Form** widget to create a transaction from the
**target entity's own form**, not a separate screen. Version **dev-1.x**. Core `^9 || ^10 || ^11`.
Depends on `transaction` and `inline_entity_form`.

Ergonomic layer only: access model, logging and transactors are the parent's; this changes *where*
a transaction is created (inline, no navigation away). See [[transaction]].