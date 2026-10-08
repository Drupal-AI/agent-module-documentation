<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operating the chain — Drush, cron, scheduled verification, export

Commands live in `Drupal\audit_chain\Drush\Commands\AuditChainCommands`. **The exit code is the
contract**: a non-zero status from `audit-chain:verify` means the chain does not verify, so it wires
straight into monitoring or a deploy gate without parsing output.

## Drush commands (`AuditChainCommands`)

- **`audit-chain:verify`** (`acv`) — walks every entry (`AuditChainLogger::verify()`), prints a
  verdict, returns 0 only when `ok`. Distinct non-zero messages for `seal_foreign` (warning),
  `seal_broken`, `written_unkeyed` (names the unsigned count/through-id and suggests sealing), and a
  plain tamper break (names `broken_at`).
- **`audit-chain:seal`** (`acs`) — `--through=<id> --reason="…"` (both required). Confirms first
  (unless `-y`), then `sealPrefix()`. Seals only rows that do **not** verify under a configured key.
- **`audit-chain:reencrypt`** (`acre`) — `--from=<profile> --to=<profile> [--limit=N]`. Rewrites
  ciphertext across Encryption Profiles without touching hashes; re-runnable until `remaining` is 0.
- **`audit-chain:export`** (`ace`) — `[--destination=…] [--from-id=N] [--channel=…] [--limit=N]`.
  Delivers NDJSON via `EvidenceExporter::exportTo()`. Defaults `--destination` to config
  `export_destination`. **At-least-once**: the per-destination checkpoint advances only on success,
  so a re-run retries the same rows; consumers deduplicate on row `id`. Refuses while the last
  scheduled verification is failing.

## Cron (`audit_chain_cron()`)

Runs `ScheduledVerifier::runIfDue()` **first**, then — if `export_enabled` and a destination is set —
`EvidenceExporter::exportTo()`. The order is deliberate: a failure discovered on this cron run already
blocks the export, which is gated on the last recorded verification verdict.

## Scheduled verification (`ScheduledVerifier`, service `audit_chain.scheduled_verifier`)

- `runIfDue()` no-ops when `verify_interval <= 0` or the interval has not elapsed since the last run
  (state key `audit_chain.scheduled_verification`). `runNow()` runs immediately.
- With **`verify_require_keyed`** on and no resolvable key, the run fails with reason
  `keyed_verification_unavailable` **without** falling back to unkeyed verification; an otherwise-ok
  verdict with `unkeyed_rows > 0` is also downgraded to a fail (`written_unkeyed`).
- A failure logs to the `audit_chain` channel and dispatches
  `AuditChainVerificationFailedEvent` (`event: audit_chain.verification_failed`) for alerting
  consumers; a `seal_foreign` run is logged as an advisory and does **not** dispatch the event.
  Verification is strictly read-only — a failing chain is never rewritten.
- `ScheduledVerificationIntegrity::classify($run, $interval, $now)` maps a run onto
  `ok`/`warn`/`crit` + a stable reason (`disabled`, `pending`, `seal_foreign`, `failed`, `overdue`,
  `passing`); the status report and the dashboard both use it so a state cannot appear on one surface
  and be missed on the other. `overdue` = no successful run within twice the interval.

## Evidence export (`EvidenceExporter`, service `audit_chain.evidence_exporter`)

- **Data-minimized**: each NDJSON row carries `contract_version` (`CONTRACT_VERSION` = 1), `id`,
  `channel`, `operation`, `timestamp`, `uid`, `entity_type`, `bundle`, `entity_id`, `prev_hash`,
  `row_hash`, `key_id` — **never** `metadata`, `ip_address`, `user_agent`, or `entity_label`. The
  off-system copy therefore cannot re-derive `row_hash`, so verification stays an on-system duty.
- **Transport**: `http(s)://` destinations are POSTed as one `application/x-ndjson` body (10s connect
  / 30s timeouts); `file://` or a plain path is appended under `LOCK_EX`. **Plain `http://` to a
  non-loopback host is refused** (`insecure_destination`) before any row is read.
- **Gating**: refuses (`verification_failing`) when the last scheduled run failed or a recovery
  record exists. **Checkpoint** is a state entry keyed on `sha1(destination)`, advance-only, so
  replays (`--from-id`) never regress it. `checkpointStatus()` reports `last_id`/`time`/`remaining`.
  `redactDestination()` strips userinfo and query string from logged/persisted URLs.
