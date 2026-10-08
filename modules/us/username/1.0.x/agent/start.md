<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Username — agent index

Provides **alternative username modes for registration and login** (display name, phone, etc.;
`username_displayname`/`username_phone` submodules). Depends on core `user`, `token`. Provides permissions.
Version **1.0.0-alpha3**. Core `^8.8||^9||^10||^11`.

Auth-identifier feature — a login identifier must be **unique**; a contact identifier (phone) used for login/
reset should be **verified** (unverified = identity/takeover risk). Changes the identifier surface, not the
password check (core still verifies the password).
