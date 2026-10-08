<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operations: Drush, routes, permissions

## Permissions (`audit_trail.permissions.yml`, all `restrict access: true`)
- `view audit trail reports` — browse entries + detail pages (read-only; does NOT include triggering verification).
- `run audit trail verification` — trigger on-demand chain (and TSA) verification (gated separately because a full walk can be minutes–hours of CPU).
- `administer audit trail` — manage secrets, chains, segments, acknowledgments, settings, TSA providers. Fully-trusted operators only.

## Drush commands (`src/Drush/Commands/AuditTrailCommands.php`)
- `audit_trail:rotate-secret` — mint a new HMAC secret and make it current (retires the previous atomically); existing rows keep verifying.
- `audit_trail:retire-secret [--id=N]` — retire without a replacement (emergency isolation; chained writes then fail-loud until a new secret is active).
- `audit_trail:verify [--chain=X] [--full]` — verify one/all chains, incremental or from genesis. Exit 0 clean, 1 broken, 2 error.
- `audit_trail:acknowledge-reset --chain --from --to --reason` — record a signed acknowledgment for an unverifiable range.
- `audit_trail:archive --chain --from --to [--directory]` — export a range to signed NDJSON, mint the segment record. Move the file to WORM storage yourself.
- `audit_trail:archive-verify --id [--path]` — verify a segment's HMAC + file SHA-256 + line replay.
- `audit_trail:purge --id [--dry-run]` — live-purge (DELETE) an archived segment's rows; segment stays as verifier skip-marker (confirm-guarded).
- `audit_trail:archive-restore --id [--path] [--allow-missing-secret]` — restore purged rows from NDJSON at their original ids.
- `audit_trail:archive-import --path [--restore] [--allow-missing-secret]` — rebuild a lost segment row from a recovered file.
- `audit_trail:auto-archive [--chain=X]` — run the full retention lifecycle on demand (bypasses the cron throttle).
- `audit_trail:compact --chain [--before]` — fold contiguous file-purged segments into one bridging row.

`--allow-missing-secret` is a high-risk disaster-recovery escape hatch (skips HMAC checks; sha256-only integrity) and logs a `critical` audit_trail watchdog entry. (The `audit_trail_tsa` submodule adds `audit_trail:timestamp` and `audit_trail:verify-timestamp`.)

## Routes (`audit_trail.routing.yml`)
- Listing/detail: `audit_trail.entries` `/admin/reports/audit-trail/entries`, `audit_trail.entry_detail` `/…/entries/{id}` — `view audit trail reports`.
- Verify: `audit_trail.chain_verify` `/…/{chain}/verify`, `chains_verify_all`, `chains_verify_all_full` — `run audit trail verification` + `_csrf_token: TRUE`.
- Chain ops: `chain_clear` (`{chain}/clear`, confirm form), `chain_delete`, `chain_auto_archive` (`_csrf_token: TRUE`) — `administer audit trail`.
- Settings/segments/acknowledgments/secrets CRUD under `/admin/config/system/audit-trail/*` — `administer audit trail`; secret `retire`/`activate` are custom entity forms.

State-changing GET routes carry `_csrf_token: TRUE`; destructive operations are confirm forms.

## Cron
`hook_cron` runs the retention lifecycle (when `cron_archive.enabled`) and auto-verification (when `auto_verify_enabled`), each throttled per chain. Hooks: `AuditTrailCronArchiveHooks`, `AuditTrailCronVerifyHooks`, `AuditTrailCronOutboxHooks` (flushes the outbox). Status report probes: `AuditTrailRequirementsHooks` + `SecretKeyChecker` (secret/Key wiring, outbox depth, last-verify age).
