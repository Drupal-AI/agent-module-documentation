<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `audit_chain.settings`

Route `audit_chain.settings` at **`/admin/config/system/audit-chain`**, form
`Drupal\audit_chain\Form\AuditChainSettingsForm` (id `audit_chain_settings`), gated by core
**`administer site configuration`**. Config object `audit_chain.settings`; schema in
`config/schema/audit_chain.schema.yml`; install defaults in `config/install/audit_chain.settings.yml`.

![Audit Chain settings form](../../../../../../../screenshots/audit_chain/1.9.x/settings-form.png)

## Keys (config object `audit_chain.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `hash_key` | string | `''` | Key entity ID of the HMAC signing key. `''` = unkeyed SHA-256. |
| `previous_hash_keys` | sequence of string | `{}` | Retired Key entity IDs still accepted when verifying older rows (rotation). |
| `encryption_profile` | string | `''` | Encryption Profile entity ID for metadata at rest. `''` = plaintext. |
| `stream_enabled` | boolean | `false` | Emit each entry to the `audit_chain` logger channel (SIEM streaming). |
| `verify_interval` | integer | `0` | Scheduled-verification interval in seconds on cron. `0` = disabled. |
| `verify_require_keyed` | boolean | `false` | Assurance profile: refuse unkeyed verification and unkeyed history. |
| `export_enabled` | boolean | `false` | Push new chain rows to the export destination on cron. |
| `export_destination` | string | `''` | Evidence export target — `https://` ingest URL or file path. |
| `export_channel` | string | `''` | Restrict the cron export to one channel (empty = all). |

## Form fields (`AuditChainSettingsForm::buildForm()`)

- **Signing key** — a `select` populated from `key.repository`; the first option is *None (unkeyed
  SHA-256)*. Store the key material outside the DB (File or Environment key provider) — with it,
  forging a repaired chain also needs the key.
- **Retired signing keys** — a multi-`select` (only shown when at least one non-empty key exists).
  Verification accepts a row signed by any listed key, so rotating `hash_key` does not make earlier
  rows look tampered. Removing a key here makes the rows it signed unverifiable.
- **Encrypt metadata at rest** — a `select` from `encrypt.encryption_profile.manager`. The description
  warns that rotating it orphans existing rows (metadata under the old profile can no longer be
  decrypted, and the chain is over the plaintext) — export or `audit-chain:reencrypt` first.
- **Stream entries to the logger channel** (`stream_enabled`).
- **Scheduled verification interval (seconds)** (`verify_interval`, `#min 0`).
- **Require keyed (HMAC) verification** (`verify_require_keyed`) — the enterprise assurance profile.
- **Export evidence off-system on cron** (`export_enabled`); when checked, **Export destination** and
  **Export channel filter** appear (`#states` visible). Destination values are trimmed on save.

`submitForm()` casts each value (arrays filtered/reindexed for `previous_hash_keys`, strings trimmed
for the export fields) and writes them back to `audit_chain.settings`.

## Related status-report checks (`audit_chain_requirements()` in `.install`)

At runtime the module reports, without extra config: a configured **signing key that will not
resolve** (ERROR — the chain silently ran unkeyed), a **retired encryption profile** still on stored
rows (WARNING — run `audit-chain:reencrypt`), an active **prefix seal** (WARNING, informational),
**scheduled-verification health** (pending/passing/overdue/failed/foreign-seal, and an assurance-
profile-without-schedule warning), and **refused retention** (WARNING when `prune()` was asked to
delete but could not without breaking the shared chain).
