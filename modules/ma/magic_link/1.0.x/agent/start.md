<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Magic Link — agent index

Adds an **HTMX-powered passwordless magic-link login** to the core login form (request a one-time login link
by email). Config at `magic_link.settings`; Drush + permissions. Version **1.0.6**. Core `^11`.

**Sound:** token is an **HMAC-SHA256 signature keyed with the site's hash salt** over `uid|exp|nonce`,
verified with **`hash_equals()`** + **expiry check** (unforgeable without the salt, expiring); key-value store
for one-time/persistent state. **Caveats:** the link **is an email-delivered login credential** — HTTPS,
short expiry, account security depends on the user's email security.
