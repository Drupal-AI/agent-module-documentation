<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Content (admin_toolbar_content) — agent index

Rebuilds the content-facing parts of the Admin Toolbar's `admin` menu: a per-content-type
"Content" tree with **Add** and **Recent items** links, plus new top-level **Categories**
(vocabularies), **Media**, **Menus** and **Webform submissions** menus, and account links on the
Drupal icon. What appears is decided by a set of internal `AdminToolbarContent` plugins (one per
area), each toggleable in config. Depends on **both** `admin_toolbar` and `admin_toolbar_tools`
(it subclasses the latter's `MenuLinkEntity`). Core `^10.2 || ^11`.

Settings route `admin_toolbar_content.settings` → `/admin/config/user-interface/admin-toolbar-content`
(permission `administer site configuration`). No permissions, no Drush, one config object, one plugin type.

- **The settings form, the `admin_toolbar_content.settings` config tree, every per-plugin option, setting it via PHP** → [configure/settings.md](configure/settings.md)
- **The `AdminToolbarContent` plugin type — the 6 built-in plugins, how the menu is (re)built, recent-items behavior, writing your own plugin** → [plugins/admin_toolbar_content.md](plugins/admin_toolbar_content.md)
- **Grouping items with `hook_admin_toolbar_content_collections` and the `admin_toolbar_content_plugins_info` alter** → [api/collections.md](api/collections.md)

Key facts:
- Config object `admin_toolbar_content.settings`: top-level `common.*` and a `plugins.<id>.*` map
  (one entry per plugin: `content`, `categories`, `media`, `menus`, `webform`, `drupal`).
- Plugin manager service `admin_toolbar_content.manager`
  (`Drupal\admin_toolbar_content\AdminToolbarContentPluginManager`); discovery namespace
  `Plugin/AdminToolbarContent`, annotation `@AdminToolbarContentPlugin`, alter `admin_toolbar_content_plugins_info`.
- Menu links come from the deriver `admin_toolbar_content.menu_links`
  (`AdminToolbarContentMenuLinks`); the module rebuilds them on entity insert/update/delete via
  `AdminToolbarContentPluginManager::menuLinkRebuild()`.
- Recent-content links are per-user placeholders resolved at render by
  `Plugin\Menu\RecentMenuLinkEntity` (access-checked query, `user` cache context).
- No settings page permission of its own; every generated link inherits the access of its target
  route/entity. Ships one CSS library `admin_toolbar_content/global`.
