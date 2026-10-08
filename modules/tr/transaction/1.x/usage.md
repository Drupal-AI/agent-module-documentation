<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Transaction is a framework for recording and executing "transactions" against entities — a configurable, logged operation that changes a target entity and keeps a history of having done so, like a ledger of actions applied to content.

---

Some domains are naturally transactional: an asset that is checked out and returned, a subscription that is credited and debited, a membership that is renewed, a device whose status is changed with a record of each change. Modelling that ad hoc means bespoke forms, bespoke logging and bespoke access rules every time. Transaction generalises it: you define **transaction types** bound to a target entity type and a **transactor** (the plugin that performs the operation), and each execution records a transaction entity — a durable log of what was done, when and by whom.

It leans on **Dynamic Entity Reference** so a transaction can point at different target entity types, and it ships a full admin surface — types, operations, and the execution routes — plus a permission model. Crucially, the execute route is gated by `_entity_access: 'transaction.execute'`, deferring to the module's own `TransactionAccessControlHandler` rather than a blanket permission, so who may run a transaction is a real per-entity access decision. There are dedicated `administer transaction types` and `administer transactions` permissions and dynamic per-type permissions.

It is a builder's framework, not a finished feature: on its own it provides the machinery, and what a site does with it — an inventory ledger, a points system, an approval trail — is defined by the types and transactors you configure. A submodule, `transaction_ief`, adds Inline Entity Form integration. For genuinely transactional domains it replaces a pile of custom code with a modelled, logged, access-controlled operation.

---

- Record an operation against an entity.
- Keep a ledger of actions on content.
- Model asset check-out and return.
- Credit and debit a balance.
- Track membership renewals.
- Log a status change with history.
- Define a transaction type.
- Bind a transaction to a target entity type.
- Execute a transaction with access control.
- Gate execution per entity.
- Grant transaction administration separately.
- Build an inventory ledger.
- Build a points system.
- Keep an approval trail.
- Reference multiple entity types via DER.
- Add Inline Entity Form with transaction_ief.
- Audit who executed which transaction.
- Replace bespoke operation code.
- Configure operations per type.
- Model a transactional domain.