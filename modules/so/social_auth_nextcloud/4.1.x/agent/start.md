<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Nextcloud — agent index

A **Social Auth network plugin for login with Nextcloud** (OAuth2, self-hosted). Depends on `social_auth`.
Version **4.1.0**. Core `^9.5||^10||^11`.

Authentication — thin network plugin; the **OAuth flow (state check + token exchange) is handled by the Social
Auth framework**. Client ID/secret as secrets (HTTPS, trusted instance); review account-linking. No access role
of its own.
