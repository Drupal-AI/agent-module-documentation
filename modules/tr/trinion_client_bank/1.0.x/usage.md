<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imports 1C "Client-Bank" (Клиент-банк) text exports and turns each bank document into a payment node in a Trinion accounting/ERP site.

---
The module solves the bookkeeping task of getting bank-statement transactions into Drupal without retyping them. An operator with the *Payment client-bank* permission uploads a Windows-1251 encoded `.txt` file at `/client-bank-import-payments`; the form (`ClientBankImportPaymentsForm`) transcodes it to UTF-8, splits it on `СекцияДокумент … КонецДокумента` blocks, maps the 1C fields (payer/recipient name, INN, KPP, account, BIK, sum, purpose) onto `trinion_payment_client_bank` node fields, auto-creates missing counterparty (`kompanii`) nodes and bank-account taxonomy terms, and skips documents that already exist. From a client-bank payment node an operator can then follow `/sozdaniye-platezha/{node}` (`SozdaniePlatezhaController`, AJAX) to spin up the corresponding sent/received payment document, wiring the two together.

Operationally it is a staff-only tool: both routes are permission-gated, entity view of `trinion_payment_client_bank` nodes is additionally restricted by `hook_entity_access`, and all writes run under the current user's uid. It performs no outbound HTTP, holds no secrets, and exposes no callback — the only input is the manually uploaded export file. Setup is limited to granting the two permissions and having the `trinion_tp` field structure in place.
---
- Import a 1C Client-Bank `.txt` export into Drupal payment documents.
- Upload a Windows-1251 bank export and have it transcoded automatically.
- Bulk-create `trinion_payment_client_bank` nodes from statement lines.
- Auto-create counterparty `kompanii` nodes for unknown INNs.
- Auto-create bank-account taxonomy terms from account/BIK data.
- Skip already-imported documents on re-upload (dedup by number/date/org).
- Record incoming vs outgoing payment direction from payer/recipient INN.
- Store payment purpose text on the created document.
- Capture unmapped 1C fields into a free-text "other" field.
- Grant the *Payment client-bank* permission to import operators.
- Grant the *convert to Payment* permission for document conversion.
- Convert a client-bank document into a sent payment (vendor).
- Convert a client-bank document into a received payment (customer).
- Prevent duplicate payment creation (existing payment is reused).
- Restrict viewing of client-bank payment nodes to permitted staff.
- Attach a related-documents view to each payment node.
- Review counterparty bank accounts linked to a company.
- Reconcile bank statement lines against ERP organizations.
- Use as the ingest step of a Trinion accounting workflow.
