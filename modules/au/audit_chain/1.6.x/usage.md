Audit Chain provides a tamper-evident, hash-chained audit log that any Drupal module can write to, with optional HMAC signing, at-rest metadata encryption, independent verification, and off-system evidence export.

---

Audit Chain is a shared audit primitive, not an end-user feature: it exposes one service (`audit_chain.logger`, implementing `AuditChainLoggerInterface`) and a request-scoped collector (`audit_chain.collector`) that other modules call to record what happened. Each entry is stored in one append-only table (`audit_chain_log`) whose per-row hash covers the row's own content and the previous row's hash, so inserting, deleting or editing a row later breaks the chain and is caught by `verify()`. When a Key-module signing key is configured the hash is HMAC-SHA256, so repairing a tampered chain also requires the key; without a key it is plain SHA-256 (detects accidental/careless edits, but recomputable by anyone with database access — the module reports which mode is in effect rather than conflating them). Metadata beyond the promoted entity columns can be encrypted at rest with an Encrypt profile. Operators verify the chain with `drush audit-chain:verify` (exit code is the monitoring contract), seal an unverifiable historical prefix so it is frozen rather than re-chained, re-encrypt metadata across profiles, and export data-minimized NDJSON evidence to an off-system destination. Cron can run scheduled verification (recording health on the status report and dispatching a failure event) and a verification-gated evidence export. It depends on core `user`, `key`, and `encrypt`.

---

- Give a custom module a tamper-evident audit trail by injecting `AuditChainLoggerInterface` and calling `log($channel, $operation, $metadata)`.
- Record entity create/update/delete events with `entity_type`, `bundle`, `id`, and `label` promoted to indexed columns for filtering.
- Audit sensitive field reads (e.g. salary, PII) from an access hook without flooding the chain, using the request-scoped collector `audit_chain.collector`.
- Log privileged administrative actions (config changes, user role grants, exports) to a durable, verifiable record separate from `dblog`.
- Track AI-agent or MCP tool traffic as an evidentiary trail (the module's original use case in MCP Sentinel).
- Require that certain evidence-critical events are only recorded when they will be HMAC-signed, using `logKeyed()` (throws rather than writing an unsigned row).
- Prove a log has not been altered since it was written by running `drush audit-chain:verify` and checking the exit code in CI or a deploy gate.
- Wire chain integrity into monitoring by keying an alert on the non-zero exit of `audit-chain:verify`.
- Distinguish genuine tampering from a chain that merely ran unsigned (missing/unresolvable Key entity) via the separate `written_unkeyed` verdict.
- Encrypt audit metadata at rest by selecting an Encrypt profile, so PII in the metadata column is not stored in plaintext.
- Rotate the HMAC signing key without invalidating history by moving the old key into "Retired signing keys".
- Rotate the encryption profile safely by re-encrypting existing rows in place with `drush audit-chain:reencrypt --from=old --to=new` (hashes untouched).
- Freeze a pre-key or otherwise unverifiable historical segment with `drush audit-chain:seal --through=<id> --reason="…"` so post-seal verification exits cleanly without re-chaining the past.
- Stream each entry to the `audit_chain` logger channel for SIEM forwarding via syslog/Monolog, without polling the table.
- Run scheduled full-chain verification on cron at a configured interval and surface the verdict on the site status report.
- Alert external systems (webhook, email, dashboard) on integrity failure by subscribing to the `audit_chain.verification_failed` event.
- Move a durable copy of the evidence outside the audited system's trust boundary with cron-driven or `drush audit-chain:export` NDJSON export.
- Replay full history to a new evidence collector or file with `drush audit-chain:export --from-id=1` (the delivery checkpoint never moves backwards).
- Export only one channel's partition of the chain by setting an export channel filter or `--channel`.
- Prune an old channel's entries past a retention period with `AuditChainLoggerInterface::prune()` (the resulting boundary is reported by verify()).
- Enforce an "assurance profile" that refuses to treat unkeyed history as passing, via the *Require keyed verification* setting for high-assurance sites.
- Detect that a database was refreshed across environments with separate keys (a "foreign seal" verdict) without misreading it as tampering.
