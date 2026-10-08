<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Region in Content (regionincontent) — agent index

**Injects theme block regions into node content templates via hook_preprocess_node so blocks can render inside the node body.**

- **Version:** 1.x
- **Core:** ^9 || ^10 || ^11
- **Route:** `regionincontent.admin_settings_form` (`/admin/config/user-interface/regionincontent`, perm `administer site configuration`)
- **Mechanism:** `hook_preprocess_node()` reads `regionincontent.settings:region`, intersects with active theme regions, renders them into node variables (view mode `full`)
- **Configure:** `regionincontent.admin_settings_form`

**Security:** Single admin config route gated by `administer site configuration`; no anonymous or mutating endpoints. Blocks rendered in-content keep their own visibility/access rules.
