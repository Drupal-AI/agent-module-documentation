<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monitoring SSO (msso) — agent index

**Project bundle of a *forked* OAuth2 Server (`oauth2_server` 2.1.1) with custom monitoring-SSO endpoints; makes the site an OAuth2/OIDC provider.**

- **Version:** 1.1.x (dev checkout, msso branch 1.1.x; bundled oauth2_server reports 2.1.1)
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Config route:** `oauth2_server.overview` (`/admin/structure/oauth2-servers`), permission `administer oauth2 server`.
- **Endpoints:** `/oauth2/authorize`, `/oauth2/token`, `/oauth2/UserInfo`, `/oauth2/revoke` (`use oauth2 server`); `/oauth2/certificates`, `/oauth2/jwk` (`_access: 'TRUE'`, public keys only — expected).
- **Permissions:** `administer oauth2 server`, `use oauth2 server`.
- **Security (report):** this is a **modified fork**. Custom `authorize()` code leaks the redirect `Location` (with the auth `code`) as a base64 JSON body when `$_REQUEST['return_data']=='mon'`; dead custom OIDC-discovery code trusts `$_SERVER['HTTP_HOST']` and `echo...die`s; README leaked a local `.ssh` dir listing (no key material). Canonical `oauth2_server` 2.1.x is documented separately.

See [api/endpoints.md](api/endpoints.md).
