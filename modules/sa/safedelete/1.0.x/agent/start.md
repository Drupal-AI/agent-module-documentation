<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SafeDelete (safedelete) — agent index

**Blocks deleting/archiving nodes that are linked from other entities' body fields (Linkit) to prevent broken links.**

- **Version:** 1.0.x (1.0.86)
- **Core:** ^10.3 || ^11 — requires `linkit`, `node`; needs `ezyang/htmlpurifier` (composer).
- **Config route:** `safedelete.settings` → `admin/config/development/safedelete` (perm `safedelete administration`).
- **Reports:** `admin/content/safedelete-orphanedpages` (+ `/viewreport`) — perms `safedelete create/view orphans report`.
- **Permissions:** administration, create/view orphans report, `safedelete show delete button` — all restricted.

**Security:** All routes are permission-gated (restricted); the module adds deletion-guard validation, not new public endpoints. No security findings. See [configure/settings.md](configure/settings.md).
