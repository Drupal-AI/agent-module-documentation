<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Audit Chain

Config object: **`audit_chain.settings`**. UI: **`/admin/config/system/audit-chain`** (route
`audit_chain.settings`, form `AuditChainSettingsForm`, permission `administer site configuration`). No custom
permissions. Set from Drush with `drush config:set audit_chain.settings <key> <value>`.

## Settings keys (with install defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `hash_key` | string | `''` | Key entity ID of the HMAC signing key. Empty = unkeyed SHA-256 (detects accidental/careless edits only; anyone with DB access can recompute after a change). Use a File or Environment key provider so the key lives outside the DB. |
| `previous_hash_keys` | sequence(string) | `[]` | Retired signing-key entity IDs still accepted when verifying older rows, so rotating `hash_key` does not make earlier rows look tampered. Removing a key here makes rows it signed unverifiable. |
| `encryption_profile` | string | `''` | Encrypt module EncryptionProfile ID for metadata at rest. Empty = plaintext metadata. **Changing it orphans existing rows** (old ciphertext can't decrypt, and the chain covers plaintext, so those rows stop verifying) — export or `reencrypt` first. |
| `stream_enabled` | boolean | `false` | Emit each entry to the `audit_chain` logger channel as a structured record for SIEM forwarding (syslog/Monolog) without polling the table. |
| `verify_interval` | integer | `0` | Scheduled full-chain verification interval in **seconds**, run on cron. `0` disables. A failed run → status-report ERROR + `audit_chain` channel error + `AuditChainVerificationFailedEvent`; a schedule quiet for >2× interval, or never-run, → WARNING. The chain is never modified by the check. |
| `verify_require_keyed` | boolean | `false` | Assurance profile: scheduled verification **fails** (reason `keyed_verification_unavailable`) instead of falling back to unkeyed SHA-256 when no signing key resolves, and fails when any rows were written unkeyed. Pair with a `hash_key` and a `verify_interval`. |
| `export_enabled` | boolean | `false` | Push new chain rows off-system on each cron run (see the export doc). Requires `export_destination`. |
| `export_destination` | string | `''` | `https://` ingest URL (one `application/x-ndjson` POST per batch) or a server file path (appended under `LOCK_EX`). Plain `http://` is refused except to loopback. Max 512 chars. |
| `export_channel` | string | `''` | Restrict the **cron** export to one channel partition. Empty = all channels. (Does not affect on-demand `drush audit-chain:export`, which takes its own `--channel`.) |

## Status report (`hook_requirements`, runtime)

Surfaces conditions with no other signal:
- **Signing key unresolvable** (ERROR): `hash_key` is set but resolves to nothing — rows go in unkeyed SHA-256.
- **Historical prefix sealed** (WARNING): a seal is active; pre-seal content is frozen, only stored hashes are re-checked.
- **Entries under a retired encryption profile** (WARNING): rows encrypted under a profile ≠ the configured one; run `reencrypt`.
- **Scheduled verification** (OK / WARNING overdue-or-never-run / ERROR failed; also WARNING if `verify_require_keyed` on but `verify_interval` = 0).
