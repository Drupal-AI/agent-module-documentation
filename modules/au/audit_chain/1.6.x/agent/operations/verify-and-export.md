<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operating the chain — Drush, cron, verification, evidence export

## Drush commands (`Drush\Commands\AuditChainCommands`)

- **`drush audit-chain:verify`** (alias `acv`) — walks and verifies the whole chain. **The exit code
  is the contract**: `0` = verifies, non-zero = does not, so it drops straight into monitoring or a
  deploy gate without parsing output. Distinct messages per `reason`: OK (notes sealed/verified-from
  when a seal is active), **SEAL FOREIGN** and **written-unkeyed** are non-zero but explicitly *not*
  "someone edited the log"; **SEAL BROKEN** and generic **BROKEN at row N** are tampering.
- **`drush audit-chain:seal --through=<id> --reason="…"`** (alias `acs`) — freeze an unverifiable
  historical prefix so post-seal verification exits cleanly without re-chaining the past. Confirms
  unless `--yes`. Only rows that do **not** verify under configured keys may be sealed (calls
  `sealPrefix()`); refuses otherwise.
- **`drush audit-chain:reencrypt --from=<profile> --to=<profile> [--limit=N]`** (alias `acre`) —
  rewrite metadata ciphertext across Encrypt profiles without touching hashes. Re-runnable; run until
  `remaining` is 0 when batching with `--limit`.
- **`drush audit-chain:export [--destination=…] [--from-id=N] [--channel=…] [--limit=N]`** (alias
  `ace`) — one-off / replay evidence export (see below). Defaults `--destination` to
  `export_destination`.

## Cron (`audit_chain_cron()` in `audit_chain.module`)

Runs `ScheduledVerifier::runIfDue()` first, then — if `export_enabled` and a destination is set — the
evidence export. Ordering is deliberate: export is gated on the last recorded verification verdict, so
a failure discovered on this very run already blocks the push.

## Scheduled verification (`ScheduledVerifier`)

`runIfDue()` runs when `verify_interval > 0` and the interval has elapsed since the last run;
`runNow()` verifies and stores the verdict in state (`audit_chain.scheduled_verification`). Health is
rendered on the **status report** by `_audit_chain_requirements_scheduled_verification()`
(passing / overdue / no-run-yet / FAILED / FOREIGN SEAL / assurance-without-schedule). A real failure
logs an error to the `audit_chain` channel and dispatches
**`AuditChainVerificationFailedEvent`** (event name `audit_chain.verification_failed`) — subscribe to
bind webhooks/email/dashboards. A foreign seal is logged as an advisory and does **not** dispatch the
tampering event. With `verify_require_keyed`, an unkeyed chain (or unkeyed rows) fails with reason
`keyed_verification_unavailable` / `written_unkeyed` instead of passing under plain SHA-256.

## Evidence export (`EvidenceExporter::exportTo()`)

Moves a durable copy of the chain outside the audited system's trust boundary as versioned
**NDJSON** (one JSON object per row, each carrying `contract_version`). Properties grounded in source:

- **Data-minimized**: exported columns are identifiers + hash-chain columns only
  (`id, channel, operation, timestamp, uid, entity_type, bundle, entity_id, prev_hash, row_hash,
  key_id`). **`metadata`, `ip_address`, `user_agent`, `entity_label` never leave the host** — so the
  off-system copy cannot re-derive `row_hash`, keeping verification an on-system duty.
- **Verification-gated**: refuses (reason `verification_failing`) while the last scheduled run is
  failing.
- **Transport**: plain `http://` to a non-loopback host is refused (reason `insecure_destination`);
  loopback collectors are allowed. `https://` batches are POSTed as `application/x-ndjson` with bounded
  connect/timeout (10s/30s). A file/`file://` destination is appended under `LOCK_EX`. Destination
  labels are redacted (scheme/host/port/path only) in logs and state, since ingest URLs can embed
  credentials.
- **At-least-once delivery**: a per-destination checkpoint (state key
  `audit_chain.export_checkpoint.<sha1>`) advances only after a successful delivery and **never moves
  backwards**; consumers must deduplicate on row `id`. `--from-id` replays history without regressing
  the checkpoint.

## Status report requirements (`audit_chain_requirements()`)

Reports, at runtime: an unresolvable configured signing key (**ERROR**), an active prefix seal
(WARNING), rows encrypted under a retired profile (WARNING), and scheduled-verification health.
