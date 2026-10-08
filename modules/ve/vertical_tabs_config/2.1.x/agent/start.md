<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertical Tabs Config — agent index

Hides and reorders the **vertical tabs on node add/edit forms** per content type and role.
Alters only `node_form`. No custom permission (uses core `administer site configuration`); no
plugins, no Drush.

- **Hide tabs (per content type / role) and set tab order — storage, routes, tab list** →
  [configure/tabs.md](configure/tabs.md)

Key facts:
- Two admin screens under `/admin/config/user-interface/vertical_tabs_config`:
  `vertical_tabs_config.visibility` (hide, the `configure` route) and
  `vertical_tabs_config.order` (weights). Both require `administer site configuration`.
- **Order** → config object `vertical_tabs_config.order`, keys `vertical_tabs_config_<tab>` (int weight).
  Shipped defaults meta=1..ds_switch_view_mode=8.
- **Visibility** → custom DB table **`vertical_tabs_config`** (`content_type`, `vertical_tab`,
  `hidden` 0/1, `roles` JSON). Empty `roles` = applies to all roles. NOT stored in config.
- Fixed tab list: `meta`, `options`, `menu`, `revision_information`, `path_settings`, `author`,
  `book`, `ds_switch_view_mode`. The Metatag tab is excluded from reordering.
