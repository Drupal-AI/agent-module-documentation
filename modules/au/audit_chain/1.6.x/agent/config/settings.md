<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — `audit_chain.settings`

Install/enable: `drush en audit_chain` (pulls core `user` and contrib `key`, `encrypt`). No
permissions are declared; the module works headless via its service the moment it is enabled.

Form: `Drupal\audit_chain\Form\AuditChainSettingsForm` (extends `ConfigFormBase`), route
`audit_chain.settings` at **`/admin/config/system/audit-chain`**, requirement
**`administer site configuration`**, menu link under *Configuration → System*. Config object
`audit_chain.settings` (schema `config/schema/audit_chain.schema.yml`, install defaults
`config/install/audit_chain.settings.yml`).

## Keys (all default to unkeyed / off)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `hash_key` | string | `''` | **Signing key**: a Key-module entity ID. Empty ⇒ plain SHA-256 (no forgery resistance against DB access). Prefer a File or Environment key provider so the secret is not in the database. |
| `previous_hash_keys` | sequence | `[]` | **Retired signing keys** still accepted at verify time, so rotating `hash_key` does not make old rows look tampered. Removing an ID makes rows it signed unverifiable. |
| `encryption_profile` | string | `''` | Encrypt-module profile ID for **at-rest metadata encryption**. Empty ⇒ metadata stored as plaintext JSON. |
| `stream_enabled` | bool | `false` | Emit each entry to the `audit_chain` logger channel for SIEM forwarding. |
| `verify_interval` | int (seconds) | `0` | Run full chain verification on cron at most this often. `0` disables the schedule. |
| `verify_require_keyed` | bool | `false` | **Assurance profile**: scheduled verification fails (rather than falling back to unkeyed SHA-256) when no key is configured or rows were written unkeyed. |
| `export_enabled` | bool | `false` | Push new rows to `export_destination` after each cron run (verification-gated). |
| `export_destination` | string | `''` | `https://` ingest URL (POSTed as `application/x-ndjson`) or a server file path (appended under `LOCK_EX`). |
| `export_channel` | string | `''` | Restrict the cron export to one channel; empty = all. |

`submitForm()` trims the destination/channel and filters empty retired keys. The retired-keys and
export fields are only shown when applicable (retired options non-empty / export enabled).

## Key handling model (why two states matter)

`AuditChainLogger::resolveHashKey()` distinguishes **no key configured** (unkeyed by design;
`hook_requirements()` says nothing) from **a configured key that will not resolve** (a fault: writes
fall back to unkeyed and `hook_requirements()` reports it at **ERROR** — see
`audit_chain_requirements()` in `.install`). The two produce the same hash but mean opposite things,
so the module never conflates them. Guarantees hold only while the signing/encryption keys are
protected outside the database — that is the module's stated threat model, surfaced in the form
descriptions.

## Rotations

- **Signing key:** set the new `hash_key`, move the old ID into `previous_hash_keys`. History keeps
  verifying under the retired key.
- **Encryption profile:** changing it orphans rows encrypted under the old profile (the chain covers
  the plaintext, so those rows stop verifying once the old profile is gone). Run
  `drush audit-chain:reencrypt --from=OLD --to=NEW` **before** removing the old profile; each row
  records the profile that produced its bytes, and the status report WARNs while any differ from the
  configured profile.
