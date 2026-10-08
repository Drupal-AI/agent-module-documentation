<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSO Bouncer — agent index

**Group-based authorization on OpenID Connect SSO** — validates Keycloak group claims and **denies login for
users whose group isn't authorized** (maps `clientId`→allowed groups/roles). Implements
`hook_openid_connect_pre_authorize()`. Depends on `openid_connect`; Drush commands. Version
**1.0.0-alpha1**. Core `^11`.

Genuine authorization control at the correct hook — runs **before** authorization, can **deny** (fail-closed
for unauthorized groups). Configure group→role mappings carefully (permissive mapping over-grants); store the
OIDC client secret as a secret; test that unauthorized groups are denied.
