<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Make My Profile Private (MMPP) — agent index

Lets **users make their profile private**. Depends on core `user`. Version **1.0.1**. Core `^9||^10||^11`.

**Correctly enforced** — a custom **entity access handler** (`MmppAccessHandler`) governs user-entity view
access (owner + admins allowed; `forbidden()` for others when private). Enforced at the **entity access** layer,
so it's respected by the canonical page **and JSON:API/REST/Views** (no API leak). Access/privacy.
