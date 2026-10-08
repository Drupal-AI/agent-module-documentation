<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OIDC Refresh — agent index

**Keeps the OIDC session alive by refreshing it via AJAX** at an interval (optionally interaction-only). Depends
on `oidc`. Provides permissions. Version **1.1.0**. Core `^9||^10||^11||^12`.

Auth-support — **token/session handling is done by the OIDC module** (this just triggers refreshes; stores no
tokens). Mind the walk-away-session trade-off (interaction-only + sane intervals). No access role beyond
permission.
