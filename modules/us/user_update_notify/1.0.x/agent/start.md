<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Update Notify — agent index

**Emails a notification to a configured address when a user account is updated**. Depends on `token`. Provides
permissions. Version **1.0.0-beta4**. Core `^9.2||^10||^11`.

**Security-monitoring-positive** (spot unauthorized account changes / takeover indicators). Notification may
include **account PII** — send to a **trusted admin address**. No access role beyond permission.
