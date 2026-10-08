<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coffre Fort (coffre_fort) — agent index

**Encrypted per-"safe" secret storage unlocked by password or external provider.**

- **Version:** 8.x-1.x · **Core:** ^8.9 || ^9 || ^10 · **Depends:** token
- **Config:** `coffre_fort.settings` → `/admin/config/system/coffre_fort` (`administer coffre fort`).
- **Manage routes:** `/admin/structure/coffre-fort/...` add/edit/delete/unlock/relock (perms `administer coffre fort`, `unlock coffre fort`, entity `update`).
- **Services:** `coffre_fort.encryption` (AES-256-CTR), private-data & secret-provider plugin managers.

**Security:** admin/entity-access gated. See [api/encryption.md](api/encryption.md).
