<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Preview Deploy (config_preview_deploy) — agent index
**Reviews and deploys configuration from preview to production via checkpoints, unified diffs, and OAuth2 endpoints.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Requires:** system, simple_oauth, key
- **Preview routes:** dashboard/deploy/rebase/changes/diff/download — `deploy config from preview` or `PreviewEnvironmentAccess`
- **Production endpoints:** `POST .../deploy-endpoint` & `GET /api/config-preview-deploy/export` — `_permission: accept config deployments` + `_auth: ['oauth2']`; deploy payloads hash-verified (`HashVerification`, timestamped)
- **OAuth:** `OAuthController` authorize/callback (`deploy config from preview`)
- **Permissions:** `deploy config from preview`, `accept config deployments` (restricted), `administer config preview deploy` (restricted)
- **Security:** Config read/write endpoints are permission + OAuth2 gated and hash-verified. `GET /api/config-preview-deploy/status` is `_access: 'TRUE'` (public) but returns only deploy status (low). Keep OAuth/hash secrets in Key; limit the two restricted permissions.

See [api/endpoints.md](api/endpoints.md)