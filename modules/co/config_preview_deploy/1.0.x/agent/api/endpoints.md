<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoints & access posture

## Preview (source) UI — `deploy config from preview` / custom access
- `GET /admin/config/development/config-preview-deploy` — dashboard.
- `.../deploy`, `.../rebase` — forms (custom `PreviewEnvironmentAccess`).
- `.../changes`, `.../diff/{config_name}`, `.../download` — inspect/download diffs.
- `.../settings` — `administer config preview deploy` (restricted).
- `.../oauth/authorize`, `.../oauth/callback` — establish preview→production OAuth trust.

## Production (target) API
- `POST /admin/config/development/config-preview-deploy/deploy-endpoint` — `ProductionController::deploy`; `_permission: accept config deployments` + `_auth: ['oauth2']`. Requires body fields `diff`, `environment`, `auth_hash`, `timestamp`; `HashVerification::verifyHash($authHash, $timestamp)` must pass. Applies changes via configuration checkpoints.
- `GET /api/config-preview-deploy/export` — `exportConfig`; same permission + OAuth2; validates a hash from request headers.
- `GET /api/config-preview-deploy/status` — `getStatus`; **`_access: 'TRUE'` (public)**. Returns only deployment status metadata (low sensitivity), no config read/write.

## Security summary
Config-mutating and config-reading endpoints are restricted (`accept config deployments`) and OAuth2-authenticated, with hash+timestamp verification on deploy. The single public endpoint exposes status only. Store the OAuth client secret and verification keys via the **Key** module; keep the restricted permissions to trusted operators.
