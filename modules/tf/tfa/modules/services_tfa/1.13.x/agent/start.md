<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TFA Web Services (services_tfa) — agent index

Deprecated submodule of **tfa** that exposes a single Services-module endpoint to validate a TFA
one-time code for a user. Package **Services**, core `^8 || ^9 || ^10`, license GPL-2.0-or-later,
version **1.13.x** (versioned with the parent `tfa` project).

- **Status: deprecated.** `services_tfa.info.yml` sets `lifecycle: deprecated`
  (see https://www.drupal.org/node/3395756); the plugin class is `@deprecated in tfa:8.x-1.4` and
  removed in `tfa:2.0.0-alpha3` with no replacement. Do not build new integrations on it.
- **Dependencies:** `services:services` (contrib) and `tfa:tfa`.
- **Provides:** no routes/permissions/config/schema/hooks of its own — just one Services plugin.

## What it provides

- **`GenericValidation`** (`src/Plugin/ServiceDefinition/GenericValidation.php`) — a
  `@ServiceDefinition` (id `tfa_login`, method `POST`, path `auth/tfa`, category *Security*). Its
  `processRequest()` reads `id` (uid), `code`, and `plugin_id` from the request, checks `plugin_id`
  is in `tfa.settings.allowed_validation_plugins`, instantiates that validation plugin for the uid
  via `plugin.manager.tfa.validation`, and calls `validateRequest($code)` under a per-uid lock. →
  [api/web-service.md](api/web-service.md)

## Fast facts (from source)

- Returns `1` on success; throws `AccessDeniedHttpException` when parameters are missing, when
  `plugin_id` is not allowed, when the code was recently used (`isAlreadyAccepted()`), or when the
  code is invalid.
- Validation, decryption, and replay protection are entirely the base module's (`TfaBasePlugin`,
  `TfaTotpValidation::validateRequest`, etc.); this class only routes the request.
