<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Preview Deploy lets teams review configuration differences in a preview environment and push approved changes to production as unified diff files, using configuration checkpoints and OAuth2-authenticated production endpoints.
---
On the preview side, a dashboard (`/admin/config/development/config-preview-deploy`) and deploy/rebase forms let an authorized user inspect changes, view per-config diffs, download a diff, and initiate a deployment; those routes are gated by the `deploy config from preview` permission or a custom `PreviewEnvironmentAccess` check. Production exposes an OAuth2-authenticated API: `POST /admin/config/development/config-preview-deploy/deploy-endpoint` and `GET /api/config-preview-deploy/export`, both requiring the restricted `accept config deployments` permission plus `_auth: ['oauth2']` (via simple_oauth). The deployer applies changes against core configuration checkpoints and verifies an authentication hash (`HashVerification`) with a timestamp on inbound deploy payloads. An OAuth authorize/callback flow (`OAuthController`) establishes the preview→production trust, and settings/keys are managed via the Key module.

Operationally, the sensitive production endpoints are permission- and OAuth2-gated and additionally hash-verified. One route, `GET /api/config-preview-deploy/status` (`ProductionController::getStatus`), is declared `_access: 'TRUE'` — intentionally public — but it only returns deployment status information (low sensitivity); the export and deploy endpoints that read/write configuration are properly restricted to `accept config deployments` with OAuth2. Treat the OAuth client secret and hash/verification keys as secrets (stored via Key), and keep the `accept config deployments` and `administer config preview deploy` permissions limited to trusted operators.
---
- Enable the module with simple_oauth and key dependencies.
- Configure settings at `/admin/config/development/config-preview-deploy/settings`.
- Set up the OAuth2 client for the preview→production trust.
- Review pending config changes on the dashboard.
- View a per-config unified diff before deploying.
- Download a diff file of pending changes.
- Deploy approved config from preview to production.
- Rebase the preview environment against production.
- Authenticate production API calls with OAuth2 (simple_oauth).
- Restrict deploy/export endpoints to `accept config deployments`.
- Verify inbound deploy payloads via hash + timestamp.
- Poll `GET /api/config-preview-deploy/status` for deploy status (public, status only).
- Use configuration checkpoints to roll changes safely.
- Store OAuth/hash secrets via the Key module.
- Limit dashboard access with `deploy config from preview`.
- Keep `administer config preview deploy` to trusted admins only.