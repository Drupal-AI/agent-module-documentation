<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sharerich (sharerich) — agent index

**Configurable responsive social-share button sets (RRSSB) rendered as a block, with `[sharerich:*]` token substitution.**

- **Version:** 2.0.x  •  core `^8 || ^9 || ^10 || ^11`  •  package Sharing  •  deps: token, block
- **Config entity:** `sharerich` (button sets), `config_prefix: set`, `admin_permission: administer sharerich`.
- **Routes:** `sharerich.admin_settings_form` (`/admin/config/sharerich/settings`), `entity.sharerich.collection` (`/admin/structure/sharerich`) + add/edit/delete — all perm `administer sharerich` (restricted).
- **Block:** `sharerich` (pick a set, orientation, sticky). **Alter hook:** `hook_sharerich_buttons_alter()`. **Tokens:** `sharerich.tokens.inc`.
- **Access:** all routes gated by restricted `administer sharerich`; button markup is admin config. See [configure/sets.md](configure/sets.md).