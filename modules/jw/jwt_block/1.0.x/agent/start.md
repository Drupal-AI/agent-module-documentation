<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT Block — agent index

**Block outputting a signed JWT** (for a JS app/external service). Version **1.0.0-alpha1**. Core `^10||^11`.

Signed via the JWT module (keys env-backed); scope claims/lifetime + cache per-user. Depends on core `block`, `key`, `jwt`.