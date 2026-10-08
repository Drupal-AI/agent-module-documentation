<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Humanitarian ID — agent index

A **Social Auth network plugin for login with Humanitarian ID** (OAuth2). Depends on `social_auth`. Version
**5.0.0**. Core `^9||^10||^11`.

Authentication — thin network plugin; the **OAuth flow (incl. `state` CSRF check + token exchange) is handled by
the Social Auth framework**. Client ID/secret as secrets (HTTPS); review account-linking settings. No access
role of its own.
