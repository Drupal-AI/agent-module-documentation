<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate (file_gate) — agent index

**Gates access to private files** with pluggable gate methods (short-lived **HMAC-signed URLs**, `authenticated`,
`token`, `referrer_lock`, `otp`; plus optional submodules) and delivers them to any decoupled front end. Depends
only on core `file`. Provides two permissions and the `GateMethod` plugin type. Version **1.10.x**, core
`^11.4 || ^12`, PHP `>=8.3`, package Security.

## Model in one paragraph
Gating is per field: mark a private file/image field storage "gated" (third-party setting `file_gate.gated`) and
pick a method. `hook_file_download()` (`file_gate_file_download()` in `file_gate.module`) then **denies by default**
(returns `-1`, a hard veto) for that field's `private://` files at `/system/files`, unless the account holds
**`bypass file gate`**. Authorized delivery happens only at `GET /api/file-gate/download`, which loads the file by
UUID, confirms it is gated (`FileGateResolver::getGateForFile()`), and runs the field's gate method's `grants()`.
Signed grants are HMAC-SHA256 (`GrantSigner`) over the file's normalized URI + canonical claims + a secret,
compared with `hash_equals`. The secret is injected from the environment, never stored in config; with no secret
the module fails closed (mint → `503`, validation → `FALSE`).

## Provides
- **Plugin type** `GateMethod` (attribute `\Drupal\file_gate\Attribute\GateMethod`, manager
  `plugin.manager.file_gate.gate_method` = `GateMethodManager`, base `GateMethodBase`, interface
  `GateMethodInterface`). Core methods: `signed_url`, `authenticated`, `token`, `referrer_lock`, `otp`.
- **Permissions** `administer file gate`, `bypass file gate` (both restricted). See below.
- **Routes** (`file_gate.routing.yml`): `file_gate.settings_form` (admin UI); the JSON API
  `download`, `mint`, `revoke`, `otp`, `otp_session`, `grants`, `grants_revoke_bulk` (all `_access: TRUE`,
  each self-authenticates — details in the API doc).
- **Services**: `file_gate.grant_signer`, `file_gate.secret_registry`, `file_gate.resolver`,
  `file_gate.file_target_resolver`, `file_gate.host_access`, `file_gate.grant_inventory`, `file_gate.otp_session`,
  `file_gate.metrics`, `file_gate.audit`, `file_gate.gated_field_overview`, and the
  `http_middleware.file_gate_authorization_shield` stack middleware.
- **Config** `file_gate.settings` (+ schema); per-field settings in field-storage third-party settings.

## Solution docs
- [Configuration & the file-access model](config/settings.md) — settings keys, secrets & rotation, per-field
  gating, `hook_file_download` deny, resolver, requirements/validator, admin UI.
- [HTTP API: routes, permissions, request/response](api/endpoints.md) — download / mint / revoke / otp /
  otp-session / grants / grants-revoke-bulk, the shared-secret auth model, flood limits, identity-aware mint.
- [Gate methods: the plugin type and the five core methods](plugins/gate-methods.md) — how each method decides
  access, per-field settings, and how to implement a custom `GateMethod`.

## Submodules (documented separately under `modules/<sub>/1.10.x/`)
- `file_gate_form` — coupled email / lead-capture form gate (`form` method + `LeadCapturedEvent`).
- `file_gate_commerce` — purchase / entitlement gate (`commerce` method + swappable entitlement checker).
- `file_gate_assurance` — hardware-backed OIDC / WebAuthn assurance gate (`assurance` method + DPoP + WebAuthn RP).
- `file_gate_mcp` — governed MCP Tool API plugins (status, lookup, grants list, metrics, single revoke).
