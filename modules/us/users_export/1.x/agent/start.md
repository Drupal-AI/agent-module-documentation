<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Users Export (users_export) — agent index

Exports user accounts to a **flat file (CSV etc.)** at `/admin/people/export`. Version **dev**.
Core `^9 || ^10 || ^11`. Permission `users export access export page`.

**This is a concentrated PII extract** (names, emails, roles). The permission is the control —
**trusted admins only**; anyone holding it walks away with the whole user base's contact details.
The output file is unencrypted PII (GDPR-relevant); don't let it linger.