<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Admin Menu (custom_admin_menu) — agent index

Shows a site-built menu in the Admin Toolbar instead of, or alongside, the default `admin` menu.
You create an ordinary menu **whose machine id is exactly `custom-admin-menu`**, add links, enable
the module at `/admin/config/system/custom-admin-menu`, and pick an insertion mode. Two permissions
(`access_custom_menu`, `access_default_menu`) decide per role which menu each user sees; per-item
role/language visibility is driven by menu-link `metadata`. Depends on `admin_toolbar`; core `^11`.

Settings route `custom_admin_menu.settings_form` → `/admin/config/system/custom-admin-menu`
(permission `administer custom_admin_menu configuration`). No `configure:` key in `.info.yml`, no
Drush. Config object `custom_admin_menu.settings` is **created only when the form is first saved**
and has **no config schema** (schema file covers only the Theme Condition plugin).

- **Enable it, insertion modes, creating the `custom-admin-menu` menu, the shortcuts region, setting config by PHP/Drush** → [configure/custom-admin-menu.md](configure/custom-admin-menu.md)
- **The three permissions and how they gate the two menus** → [permissions/permissions.md](permissions/permissions.md)
- **Per-item role/language visibility metadata, the alter hooks, the Theme Condition plugin, the shortcuts template override** → [api/extend.md](api/extend.md)

Key facts:
- The menu that drives everything is loaded by machine id `custom-admin-menu` (hyphens) —
  constant `CustomAdminMenuManager::CUSTOM_MENU_NAME`. The shipped
  `config/optional/system.menu.custom_admin_menu.yml` uses id `custom_admin_menu` (underscores) and
  is **not** the menu the code reads; create/name your menu `custom-admin-menu`.
- Config keys (`custom_admin_menu.settings`): `enable` (bool), `include_in_admin` (bool),
  `insertion_type` (`prepend`|`append`, only when `include_in_admin`), `wrap_admin` (bool),
  `shortcuts_region` (admin-theme region machine name or empty).
- Behavior lives in toolbar hooks (`src/Hook/Toolbar.php`): `hook_toolbar_alter` (separate-menu
  mode) and `hook_preprocess_menu` for `menu__toolbar__admin` (merged mode). Superuser (uid 1)
  always sees the full default menu and bypasses item visibility filtering.
- Provides a core Condition plugin `custom_admin_menu_theme_condition` (limit by active theme),
  two alter hooks (`custom_admin_menu`, `custom_admin_menu_item`), and convenience redirect routes
  (`/admin/node/edit`, `/admin/term/edit`, `/admin/{entity_type}/edit`, all gated by
  `access content overview`) plus an overview route `/admin/overview/{link_id}`.
- Saving the settings form flushes all persistent caches (module invokes `cache_flush` + clears
  every cache bin), so config changes take effect immediately.
