<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail TSA timestamping (audit_trail_tsa) — agent index

Submodule of [audit_trail](../../../../agent/start.md). RFC-3161 external trust anchoring. Core `^11.3 || ^12`. Depends on `audit_trail`, `key`. Needs the host `openssl` binary.

## What it does
`ChainTimestamper` (`src/Tsa/ChainTimestamper.php`, service `audit_trail_tsa.chain_timestamper`) anchors a chain head:
1. Read the head hash via `ChainRepository::getHead()`.
2. Build a TimeStampReq from it: `TimestampQueryBuilder::build($hash, $include_nonce)` — shells `openssl ts -query -digest <hex> -sha256 -cert` (imprint validated as 64-hex first; Process array, no shell).
3. POST the TSQ to the active provider's URL over the Guzzle `http_client` (`postQuery`), auth applied by `applyAuthOptions`.
4. Smell-test the response (≥16 bytes, DER `\x30`), then synchronously `openssl ts -verify -in <tsr> -queryfile <tsq> -CAfile <ca>` (validates messageImprint + nonce echo) when the provider has a pinned CA cert.
5. Write a chained `tsa_timestamp` row (`action='tsa_timestamp'`, resource `<chain>:<head_id>`) via `AuditTrailChainWriter`: permanent bucket holds `tsa_id`, `anchored_hash`, base64 TSR/TSQ + their SHA-256s.

`verifyRow()` re-verifies a stored row offline; `AuditTrailTsaCronHooks` walks chains on cron (per-chain throttle, skips a head that is already a TSA row).

## Provides
- Config entity `audit_trail_tsa_provider` (`src/Entity/AuditTrailTsaProvider.php`): URL, `ca_cert` (PEM), `include_nonce`, auth (`none`/`basic`/`bearer`/`mtls`) with all secrets as `drupal/key` refs, `provider_status` pending/active/inactive, `tsa_id`. Admin perm `administer audit trail`.
- Config object `audit_trail_tsa.settings`: `enabled`, `timeout_seconds` (30), `cron_enabled` (false), `cron_interval_seconds`; plus per-chain `audit_trail.chain.*.third_party.audit_trail_tsa` (`enabled`, `interval_seconds`).
- Routes (`audit_trail_tsa.routing.yml`): `settings_form` `/…/tsa`; provider CRUD + activate/deactivate; `chain_timestamp` (`administer audit trail` + `_csrf_token`); `verify_row` / `verify_chain` / `verify_all` (`run audit trail verification` + `_csrf_token`).
- Drush (`AuditTrailTsaCommands`): `audit_trail:timestamp [--chain|--all]`, `audit_trail:verify-timestamp [--row-id|--chain]`.
- Hooks: alters the parent entry-detail page (adds "Verify TSA timestamp" for `tsa_timestamp` rows) and chain entity operations; a requirements probe for openssl.

See [agent/config/providers.md](config/providers.md) for provider/auth configuration.
