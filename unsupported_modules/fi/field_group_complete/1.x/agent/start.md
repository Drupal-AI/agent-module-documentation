<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Complete (field_group_complete) — agent index

**Adds a live complete/incomplete badge to Field Group leaves once their required fields are satisfied.**

- **Version:** 1.x  •  **Core:** ^10 || ^11  •  **Requires:** field_group  •  **Configure:** `field_group_complete.settings` (`/admin/config/content/field-group-complete`)
- **Assets:** `js/field_group_complete.js`, `js/field_group_complete.core.js`, `css/field_group_complete.css` (library `field_group_complete`). Form: `SettingsForm`.
- **Config:** `badge_text_complete`, `badge_text_incomplete`, `badge_visibility`, `custom_complete_classes`, `custom_required_classes`.
- **Route:** settings form gated by `administer site configuration`.
- **Security:** Client-side/presentational only; completion computed in JS, no data mutation, no endpoints beyond the admin settings form. No custom permissions.
