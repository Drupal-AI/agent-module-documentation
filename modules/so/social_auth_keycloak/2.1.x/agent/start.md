<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Keycloak — agent index

A **Social Auth network plugin for login with Keycloak** (OAuth2/OIDC, self-hosted). Depends on `social_api`,
`social_auth`. Version **2.1.0**. Core `^9.1||^10||^11`.

Authentication — thin network plugin; the **OAuth flow (state check + token exchange) is handled by the Social
Auth framework**. Client ID/secret as secrets (HTTPS, trusted realm); review account-linking. No access role of
its own.
