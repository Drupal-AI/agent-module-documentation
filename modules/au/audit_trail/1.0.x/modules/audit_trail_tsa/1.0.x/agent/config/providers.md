<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TSA providers, auth, and settings

## `audit_trail_tsa_provider` config entity
`src/Entity/AuditTrailTsaProvider.php` (schema `audit_trail_tsa.provider.*`). Managed at `/admin/config/system/audit-trail/tsa-providers` (`AuditTrailTsaProviderForm` add/edit/delete + custom `activate`/`deactivate` forms), permission `administer audit trail`. Fields:
- `tsa_id` (int, auto `max+1` at create; stored on `tsa_timestamp` rows so verification resolves the provider even after a rename), `id` (`tsa_<n>`), `label`.
- `url` — RFC-3161 endpoint (HTTP(S)).
- `ca_cert` — PEM bundle pinned for `openssl ts -verify -CAfile`. Empty = the sync post-stamp verify is skipped (offline-only trust); the row still stores TSR/TSQ.
- `include_nonce` (default TRUE) — some legacy TSAs reject a nonce.
- `auth_type` — `none` | `basic` | `bearer` | `mtls`.
- `provider_status` — `pending` | `active` (exactly one at a time; activating retires the prior) | `inactive` (kept for historical verification).
- `created`, `deactivated`.

## Auth modes (`ChainTimestamper::applyAuthOptions`)
Every secret is a `drupal/key` reference resolved at request time (`resolveKeyValue`), never stored on the entity — so `drush cex` output stays credential-free. `calculateDependencies()` pins only the Key(s) for the active mode so a Key can't be deleted out from under a provider.
- `none` — no credentials (public TSAs / evaluation).
- `basic` — `auth_username` + `auth_password_key_id` → Guzzle `auth: [user, pass]`.
- `bearer` — `auth_token_key_id` → `Authorization: Bearer <token>` header.
- `mtls` — `auth_client_cert` (public PEM) + `auth_client_private_key_id` (+ optional `auth_client_passphrase_key_id`); the cert and key are written to short-lived **0600 temp files**, passed as Guzzle `cert`/`ssl_key`, and unlinked in a `finally` (even on a thrown request) so key material never lingers on disk.

TLS certificate verification is Guzzle-default (never disabled). The imprint is validated as a 64-char hex string before reaching openssl, which is invoked via the Symfony `Process` array form (no shell interpolation).

## `audit_trail_tsa.settings` (config object)
Install defaults: `enabled: true`, `timeout_seconds: 30`, `cron_enabled: false`, `cron_interval_seconds: 86400`. `ChainTimestamper` refuses to run when `enabled` is false or no provider is active.

## Per-chain override
`audit_trail.chain.*.third_party.audit_trail_tsa` (attached to `audit_trail_chain` entities via third-party settings): `enabled` (stamp this chain on cron, default TRUE — manual `drush audit_trail:timestamp` ignores it) and `interval_seconds` (nullable, inherits the global cron interval).
