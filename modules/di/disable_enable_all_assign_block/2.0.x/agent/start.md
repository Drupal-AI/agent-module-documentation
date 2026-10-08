<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable And Enable All Assign Block (disable_enable_all_assign_block) — agent index
**Admin form to bulk enable/disable all blocks in chosen default-theme regions at once.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends on:** block
- **Routes:** `disable_enable_all_assign_block.admin` (`/admin/config/disable_enable_all_assign_block`) and `.settings_advanced` (config form) — both permission `administer site configuration`.
- **Config:** `disable_enable_all_assign_block.settings_advanced:daab_region`.

**Security:** All routes require `administer site configuration`; no anonymous or web-service endpoints. Submit handler reads `block.block.*` rows from `{config}` and `unserialize()`s them (trusted config data, admin-only route). Region toggle applies site-wide to the default theme.