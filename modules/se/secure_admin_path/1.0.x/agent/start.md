<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Secure Admin Path — agent index

**Renames the /admin and /user path prefixes to a custom string** (reduce automated scanning). Provides
permissions. Version **1.0.1**. Core `^9||^10||^11`.

**Security through obscurity** — hides the admin/login location from bots (cuts noise) but is **not an access
control**; real protection stays with permissions/authentication (strong passwords, flood control, 2FA). Defense-in-
depth only.
