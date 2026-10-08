<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transaction (transaction) — agent index

Framework for **logged, access-controlled operations over entities** — transaction *types* +
*transactors* (operation plugins), each execution recording a transaction entity (a ledger).
Version **dev-1.x**. Core `^9 || ^10 || ^11`. Depends on **`dynamic_entity_reference`** (targets can
be different entity types). Admin at `/admin/config/workflow/transaction`. Submodule `transaction_ief`
(Inline Entity Form).

**Access done right:** execute route uses `_entity_access: 'transaction.execute'` →
`TransactionAccessControlHandler` (per-entity decision, not a blanket permission). Perms:
`administer transaction types`, `administer transactions`, + dynamic per-type.

Builder's framework — provides the machinery; the ledger/points/approval-trail is what your types
and transactors define.