<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSO Connector – Social Login — agent index

**OAuth2 social login** (Google/Microsoft/GitHub/LinkedIn/Facebook/generic). Version **1.0.1**. Core `^11.2||^12`.

Callback validates CSRF `state` before login (positive). Secrets env-backed. Perms: `administer sso connector social`, `manage own social accounts`. Depends on `sso_connector`, core `user`/`block`/`file`/`image`.