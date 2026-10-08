<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `audit_chain.settings`

Route `audit_chain.settings` at **`/admin/config/system/audit-chain`**, form
`Drupal\audit_chain\Form\AuditChainSettingsForm` (id `audit_chain_settings`), gated by core
**`administer site configuration`**. Config object `audit_chain.settings`; schema in
`config/schema/audit_chain.schema.yml`; install defaults in `config/install/audit_chain.settings.yml`.

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
| `witness_backend` | string | `''` | Witness backend service identifier for checkpoint anchoring. `''` = the fail-closed NoOp (`null`) backend. **Not exposed in the settings form** — set via config import / `drush config:set`. See operations/archive-and-witness.md. |

## Form fields (`AuditChainSettingsForm::buildForm()`)

The form exposes the first nine keys; `witness_backend` has no form field.

- **Signing key** — a `select` populated from `key.repository`; the first option is *None (unkeyed
  SHA-256)*. Store the key material outside the DB (File or Environment key provider) — with it,
  forging a repaired chain also needs the key.
- **Retired signing keys** — a multi-`select` (only shown when at least one non-empty key exists).
  Verification accepts a row signed by any listed key, so rotating `hash_key` does not make earlier
  rows look tampered. Removing a key here makes the rows it signed unverifiable.
- **Encrypt metadata at rest** — a `select` from `encrypt.encryption_profile.manager`. The
  description states that rotating it orphans metadata *readability* until you re-encrypt, **not**
  the hashes: the chain is over the plaintext, so verification still succeeds while the previous
  profile remains loadable (each row records which profile produced its ciphertext, and the status
  report warns when a row still names a retired one). Run `audit-chain:reencrypt` to rewrite
  ciphertext in place, keeping the previous profile loadable until it finishes.
- **Stream entries to the logger channel** (`stream_enabled`).
- **Scheduled verification interval (seconds)** (`verify_interval`, `#min 0`).
- **Require keyed (HMAC) verification** (`verify_require_keyed`) — the enterprise assurance profile.
- **Export evidence off-system on cron** (`export_enabled`); when checked, **Export destination** and
  **Export channel filter** appear (`#states` visible). Destination values are trimmed on save.

`validateForm()` enforces the same rules as `EvidenceExporter` at save time: with export enabled the
destination may not be empty, and a plain `http://` destination to a non-loopback host is rejected
(`https://` or a loopback collector only) so evidence is not exposed in transit.

`submitForm()` casts each value (arrays filtered/reindexed for `previous_hash_keys`, strings trimmed
for the export fields) and writes them back to `audit_chain.settings`.

## Related status-report checks (`audit_chain_requirements()` in `.install`)

At runtime the module reports, without extra config: a configured **signing key that will not
resolve** (ERROR — the chain silently ran unkeyed), a **retired encryption profile** still on stored
rows (WARNING — run `audit-chain:reencrypt`), an active **prefix seal** (WARNING, informational),
**scheduled-verification health** (pending/passing/overdue/failed/foreign-seal, plus a documented
**unsigned-prefix** and **historical-exception** WARNING where a leading unkeyed prefix or a
disclosed-fork-with-verifying-successor is retained verbatim rather than rewritten, and an assurance-
profile-without-schedule warning), and **refused retention** (WARNING when `prune()` was asked to
delete but could not without breaking the shared chain).
