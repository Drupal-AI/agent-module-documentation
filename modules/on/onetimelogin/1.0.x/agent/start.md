<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# One Time Login — agent index

Generates **secure one-time login links** for users (login without password — onboarding/support/
recovery). Built on core **`user_pass_rehash()`** (strong, user-specific token) + short URL `/s/{hash}`,
IP-binding, expiry, single-use, revocation. Generation is permission-gated (`access one-time login`) +
CSRF + rate-limited + active-user checks. Config at `onetimelogin.settings`; **Drush commands** +
permissions. Version **1.0.6**. Core `^9||^10||^11||^12`.

Soundly built. **Restrict the generation permission tightly** (it grants login-AS-user); keep expiry
short; treat links as sensitive bearer credentials; use revoke to invalidate.
