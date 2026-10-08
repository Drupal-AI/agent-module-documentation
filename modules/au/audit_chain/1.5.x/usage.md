<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audit Chain provides tamper-evident, hash-chained audit logging for any Drupal module, with scheduled keyed verification and data-minimized off-system evidence export.

---

Audit Chain **provides tamper-evident, hash-chained audit logging** — a reusable audit-log primitive where each
entry is chained to the previous by hash (so any alteration/deletion breaks the chain and is detectable), with
optional HMAC signing, at-rest encryption, a "prefix seal" for historical segments, and independent verification.
Other modules (e.g. MCP Sentinel) build their audit trails on it. It depends on core User and the Key and Encrypt
modules; entries are buffered per request (deduplicated) and written after the response is sent (off the user's
critical path). **1.4.0** added scheduled keyed verification: cron runs a full chain verification on a configurable
interval, records the verdict on the status report and in state, logs a failure to the `audit_chain` channel, and
dispatches `AuditChainVerificationFailedEvent` so consumers can bind their own alerting — the chain itself is never
rewritten. An "assurance profile" (`verify_require_keyed`) refuses to accept an unkeyed pass. **1.5.0** added
off-system evidence export: chain rows can leave the writer's trust boundary as versioned, data-minimized NDJSON
(identifiers and hash-chain columns only — metadata, IPs, user agents and labels never leave), delivered
at-least-once to an `https://` ingest URL or a local file, resumable via a per-destination checkpoint, and refused
while the last scheduled verification is failing.

Use it to get an integrity-protected audit trail with an operational lifecycle. This is a **security-positive**
logging primitive built on the right pieces: **hash-chaining** makes the log tamper-evident, **HMAC signing** (with
a secret from the Key module) lets you verify authenticity, and **Encrypt** protects entries at rest. Its guarantees
depend on protecting the signing/encryption keys: store the **HMAC/encryption keys securely** (Key module — a leaked
signing key lets an attacker forge a consistent chain), verify the chain periodically (schedule it or run
`drush audit-chain:verify`), and keep off-system copies of the evidence and backups of the seal points. It has no
access-control role beyond the admin settings form (`administer site configuration`). Configure the keys and
encryption profile, then optionally enable scheduled verification and evidence export.

---

- Provide hash-chained, tamper-evident audit logging for any module.
- Make any alteration/deletion of the log detectable via a broken hash chain.
- Support HMAC signing + at-rest metadata encryption.
- Underpin other modules' audit trails (identified by a per-consumer `channel`).
- Buffer per-request writes through the collector and flush once at `kernel.terminate` (avoid per-access-check flooding).
- Configure signing key, retired signing keys, and encryption profile via the settings form.
- Run scheduled keyed chain verification on cron at a configurable interval.
- Surface verification health on the status report (pass / overdue / never-run / FAILED).
- Enforce an assurance profile that refuses unkeyed operation (`verify_require_keyed`).
- Alert on integrity failure via the `audit_chain` logger channel and `AuditChainVerificationFailedEvent`.
- Verify the chain on demand and gate deploys/monitoring on the exit code (`drush audit-chain:verify`).
- Seal an unverifiable historical prefix without re-chaining (`drush audit-chain:seal`).
- Re-encrypt stored metadata from one encryption profile to another (`drush audit-chain:reencrypt`).
- Export chain rows off-system as data-minimized NDJSON (`drush audit-chain:export` or the cron leg).
- Deliver evidence at-least-once with resumable per-destination checkpoints and history replay.
- Refuse evidence export while a scheduled verification is failing (never present unverified rows as evidence).
- Refuse plain-HTTP off-host export destinations (loopback collectors excepted); redact credentials from logs.
- Stream each entry to the `audit_chain` logger channel for SIEM forwarding (`stream_enabled`).
- Prune a channel's old entries by retention period (accepting the resulting chain seam).
- Detect and warn when rows were encrypted under a now-retired encryption profile.
- Store the HMAC/encryption keys securely (a leaked signing key allows forging the chain).
- Keep backups of seal points and off-system evidence copies.
