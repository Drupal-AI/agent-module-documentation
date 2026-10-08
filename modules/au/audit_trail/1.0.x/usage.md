<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audit Trail is a tamper-evident (HMAC-chained) audit-logging primitive: a canonical `event()` write API plus a chained PSR-3 logger, audit-shaped indexed storage, an admin viewer with before/after diff, a chain-integrity verifier, key rotation, and a cron retention lifecycle with NDJSON archiving.

---

Audit Trail records selected log entries into a dedicated `audit_trail` table where every row carries a public SHA-256 hash of its payload chained to the previous row's hash, plus an operator HMAC over that hash (key material held by `drupal/key`). Any post-hoc insert, edit or delete breaks the chain and the `AuditTrailVerifier` service reports every broken range in one walk — the log becomes tamper-*evident* (detectable), the property auditors and regulators care about. Modules opt entries into a chain either per call (`'chain' => TRUE` in the PSR-3 context) or by claiming a channel on an `audit_trail_chain` config entity whose `mode` is `auto`; the structured `AuditTrail::event($channel, $action, $subject, $context)` API records `action`/`resource` first-class columns and routes context into two retention tiers (a permanent, operator-attested, PII-free bucket signed raw, and a transient bucket signed by hash so its bytes can be NULLed at a short GDPR window without breaking verification). Contributor plugins decide what each row carries and filter plugins can drop events before they become rows. A cron-driven five-stage lifecycle (transient-purge → archive to NDJSON → live-purge → file-purge → compaction) with per-chain overrides ages rows out while keeping purged ranges verifiable via signed segment attestations, and secret rotation lets one chain span any number of key changes. It ships submodules for entity CRUD, paragraph ancestry, managed-file activity, user-authentication events, and RFC-3161 TSA timestamping. Requires Drupal 11.3+ / 12, PHP 8.2+, `drupal/file` and `drupal/key`.

---

- Add a defensible, tamper-evident audit log to a regulated application (notarial acts, financial transactions, medical records, eIDAS traceability of operations).
- Route an existing module's log calls into a cryptographic chain with no code change, using `\Drupal::logger($channel)->info($msg, ['chain' => TRUE])`.
- Record structured audit events from custom code via the `audit_trail` service: `$auditTrail->event('finance', 'approved', new AuditTrailSubject(resource: 'invoice:42', live: $invoice), $ctx)`.
- Group several PSR-3 channels into one auditable chain (e.g. a `notarial` chain claiming `webdav` and `finance`) so their chronology links into a single verifiable sequence.
- Auto-chain every entry on a claimed channel by setting the chain's `mode` to `auto` (no per-call flag needed).
- Browse chained entries at Reports → Audit Trail with filters (chain, channel, action, resource, correlation id, severity, user, date range, message substring) and a shareable, bookmarkable filtered URL.
- Inspect a single entry's full payload, its recomputed public-hash and HMAC verdict, its chain neighbours, and a field-by-field before/after diff.
- Verify chain integrity on demand from the UI, from `drush audit_trail:verify`, or automatically on cron, with incremental (checkpoint-resumed) or full (from-genesis) walks.
- Rotate the HMAC signing secret without invalidating history (`drush audit_trail:rotate-secret`); every row records the secret id it was signed under.
- Store the HMAC secret in the `drupal/key` provider of your choice (file, environment, cloud secret manager, HSM) so it never lands in a config export or database dump.
- Age rows out with a cron retention lifecycle: archive closed buckets to signed NDJSON files, then live-purge rows, then unlink files, keeping the chain verifiable across every purged range.
- Purge raw operational payload (before/after diffs, IP addresses, request URIs) early at a short transient-retention window for GDPR while keeping the chain intact ("purge the bytes, keep the hash").
- Archive a chain segment to WORM-bound NDJSON and verify a relocated copy offline (`drush audit_trail:archive`, `audit_trail:archive-verify`).
- Restore or import previously-archived rows from an NDJSON file after a disaster (`drush audit_trail:archive-restore`, `audit_trail:archive-import`).
- Record an operator acknowledgment for a known-unverifiable range (a lost secret, a partial restore) so verification reports the reason instead of a permanent red verdict (`drush audit_trail:acknowledge-reset`).
- Drop noisy events before they hit the chain with filter plugins (bundled: request-method filter, severity-threshold filter).
- Enrich rows with custom context via a contributor plugin (e.g. snapshot selected fields, tag structural metadata) using the `#[ContextContributor]` attribute.
- Audit generic entity create/update/delete with per-bundle, per-operation opt-in and field-level selection (submodule `audit_trail_entity`).
- Audit managed-file lifecycle — create, update, made-permanent, delete, private-stream downloads (submodule `audit_trail_file`).
- Audit user-authentication events — login, logout, failed login, password reset requested/probed/used, block/unblock, account create/delete, password/role change (submodule `audit_trail_user_auth`).
- Trace a paragraph mutation back to its host entity even after the paragraph is deleted (submodule `audit_trail_entity_paragraphs`).
- Anchor chain heads to a qualified RFC-3161 Time-Stamping Authority so forging history later would also require forging every historical timestamp (submodule `audit_trail_tsa`).
- Distinguish an operator-authorized deletion from an attacker blanking a column: purges are attested by signed segment rows the verifier checks.
