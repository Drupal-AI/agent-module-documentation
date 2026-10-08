<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Switcher — agent index

Lets privileged users **switch into another user account (impersonate)** and restore their session
(support/debugging). Gated by restricted `switch user accounts`; blocks target uid 1 (unless you are uid 1).
Requires PHP 8.0. Version **1.0.1**. Core `^10||^11`.

**Permission caveat (1.0.1):** no higher-privilege guard beyond uid-1 — it can impersonate other admins; grant
the (restricted) permission **only to fully-trusted admins**. Consider the **Masquerade** module for production.
