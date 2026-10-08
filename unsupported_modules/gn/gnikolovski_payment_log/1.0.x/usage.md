<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Payment Log logs payment-related activities (gateway requests and responses).

---

Payment Log records **payment-gateway requests and responses** — a `logRequest()` service writes a row
(customer **email**, order ID, gateway name, request time, and an `additional_data` **JSON payload** of the
gateway request/response) into its own table, exposed for review via Views and gated by a `view payment logs`
permission. It is used by Commerce payment-gateway modules (e.g. Banca Intesa) for payment auditing/debugging,
in the Commerce (contrib) package.

Use it to audit/debug payment-gateway traffic. It is an e-commerce/logging feature and it is
**security-sensitive because of what it stores**: the log holds **customer email** (PII) and the **full
gateway request/response JSON** for each payment (transaction IDs, auth/response codes, and whatever the
gateway passes in). So: gate `view payment logs` to **trusted finance/admin staff** only; ensure the gateway
integrations feeding it do **not** put raw card data (PAN/CVV) into `additional_data` (PCI concern); and prune
the log per your data-retention policy. It has no access-control role beyond its permission. Grant the view
permission carefully.

---

- Log payment-gateway requests/responses.
- Record email, order, gateway, JSON payload.
- Expose the log via Views.
- Gate viewing by view payment logs.
- Serve Commerce payment gateways.
- Provide payment auditing/debugging.
- STORE customer email (PII).
- STORE the full gateway request/response JSON.
- Gate view payment logs to trusted staff.
- Keep raw card data (PAN/CVV) out of additional_data.
- Prune per retention policy.
- Have no access-control role beyond permission.
- Handle payment logging.
- Audit payments.
- Configure the log.
- Debug gateway traffic.
- Handle the log.
- Log transactions.
- Restrict log viewing.
- Provide payment logs.
