<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recovery segments — the successor protocol

When history is unrecoverably broken, Audit Chain never repairs it. Instead an operator starts an
explicitly-approved **successor segment** while the historical failure is retained verbatim. Service
`audit_chain.recovery` (`Drupal\audit_chain\RecoverySegments`); commands in
`Drupal\audit_chain\Drush\Commands\RecoveryCommands`. Records live in the append-only
`audit_chain_recovery` table (`segment_id`, `manifest`, `key_id`, `mac`).

Whole-history verification is deliberately **not** changed by any of this: `verify()` keeps returning
the historical failed verdict, and the presence of a recovery record makes `sealPrefix()`,
`reencrypt()` and evidence export refuse (they must not paper over the retained failure).

## Commands (`RecoveryCommands`)

- **`audit-chain:recovery-prepare`** — `RecoverySegments::prepare()`. Under the append lock, captures a
  read-only snapshot (row contents, hashes, ordering, seals, branch tips, and the current
  `verify()` verdict) and prints its `snapshot_digest`. No state is changed.
- **`audit-chain:recovery-activate`** — `--segment=<uuid> --snapshot=<digest> --incident=… --reason=…
  --approved-by=… --backup-digest=<sha256>`. Confirms first (unless `-y`). Requires a valid UUID, a
  fresh matching snapshot digest, a **non-empty failed** history, and all context fields as bounded
  non-empty strings. Signs the manifest with the active key (`signRecoveryManifest()`), inserts the
  record, writes a keyed `recovery_started` audit receipt, and resets the scheduled-verification
  state so no pre-incident cached "ok" survives.
- **`audit-chain:recovery-verify <segment>`** — verifies the anchor is unchanged and every successor
  row chains and authenticates (`verifyLocked()`); exit 0 only when `segment_ok`.
- **`audit-chain:recovery-export <segment>`** — emits the signed record (contract
  `audit_chain.recovery.v1`) with `whole_history_verified: false`; the record is included only when
  the successor verifies.

## Requirements & guards

- **`audit_chain_instance_id`** must be set in `settings.php` (`Settings::get()`), unique per
  deployment and kept out of exported config; recovery refuses without it. It binds a manifest to its
  instance so a copied record cannot be replayed elsewhere.
- Manifests are authenticated with `hash_equals` over a domain-separated HMAC
  (`audit_chain.recovery.v1|…`) before being interpreted (`authenticatedManifest()`); a second
  recovery requires an explicit multi-segment protocol and is otherwise refused.
- `ScheduledVerifier` reports successor health separately (`RecoverySegments::currentStatus()`), never
  substituting it for the whole-history verdict; a failing successor logs an error each run.
