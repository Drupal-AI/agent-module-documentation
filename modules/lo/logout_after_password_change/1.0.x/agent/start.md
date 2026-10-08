<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logout After Password Change — agent index

**Forces a user logout after a password change/reset** (event subscriber calls `user_logout()` on the
password-reset flag → re-auth required). Version **1.0.6**. Core `^9||^10||^11`.

**Security-positive** session hygiene (re-auth after a credential change; supports log-out-after-change). No
access role.
