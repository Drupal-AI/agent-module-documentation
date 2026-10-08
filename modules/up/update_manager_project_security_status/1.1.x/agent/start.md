<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Manager Project Security Status — agent index

Adds **security-coverage status to core's Available Updates report** (flag projects covered vs unsupported by
the security-advisory policy). Depends on core `update`. Version **1.1.0**. Core `^10||^11`.

**Security-positive** admin feature — surfaces security-unsupported modules (won't get fixes). Augments the
already-admin-gated updates report; no access role.
