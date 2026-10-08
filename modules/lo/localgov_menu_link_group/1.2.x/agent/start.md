<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov menu link group (localgov_menu_link_group) — agent index

Bundles existing menu links under a synthetic, non-clickable parent link so a long flat menu
(e.g. the admin "Add content" list) can be split into labelled groups. Each group is a
`localgov_menu_link_group` **config entity**; a menu-link deriver turns each into a `<nolink>`
group link at menu-build time and re-parents the chosen children under it.

- No runtime dependencies (core menu system only); dev-only `drupal/localgov_core`.
- No settings form / no `configure:` route. Manage groups at the entity collection
  `/admin/structure/menu/localgov_menu_link_group` (route `entity.localgov_menu_link_group.collection`).
- No permissions of its own, no Drush, no `services.yml`, no plugin type. Config schema shipped.
- Admin routes gated by the core **`administer site configuration`** permission.
- Optional: if the `multiselect` module is installed, the Child menu links field upgrades to a multiselect widget.

Solutions:
- **Create / manage a group (UI, drush, PHP), admin routes, field & config-schema reference** → [configure/groups.md](configure/groups.md)
- **How groups become menu links (deriver + grouper + hooks), render-time access hiding, ship/extend a group as config** → [api/menu-grouping.md](api/menu-grouping.md)

Key facts:
- Config entity id `localgov_menu_link_group`; config_prefix `localgov_menu_link_group`
  → config files `localgov_menu_link_group.localgov_menu_link_group.<id>.yml`.
- `config_export`: `id`, `group_label`, `weight`, `parent_menu`, `parent_menu_link`, `child_menu_links` (plus standard `status`/`langcode`/`dependencies`).
- entity_keys: id=`id`, label=`group_label`, status=`status`, weight=`weight`. Defaults: `parent_menu`=`admin`, `parent_menu_link`=`system.admin_content`, `weight`=0.
- New ids auto-prefixed `localgov_menu_link_group_` (form const `ENTITY_ID_PREFIX`); machine name derived from Group name.
- `child_menu_links` = numeric **sequence** of menu-link plugin ids (dots aren't allowed in config keys); `LocalGovMenuLinkGroup::set()` `array_values()`s them.
- Derived group link id: `localgov_menu_link_group:<parent_menu_link>:<machine_label>` (deriver `Plugin\Deriver\MenuGroups`; base def route `<nolink>`, enabled/expanded). Groups merge by parent link + label (smallest weight wins).
- Hooks: `hook_menu_links_discovered_alter` (re-parents children via `MenuLinkGrouper`), `hook_module_implements_alter` (runs this impl LAST), `hook_preprocess_menu` → `_localgov_menu_link_group_filter_menu` (render-time hide of empty groups), entity insert/update/delete → `plugin.manager.menu.link`->rebuild().
- Route names: `entity.localgov_menu_link_group.{collection,add_form,edit_form,delete_form}`.
- Classes: `Entity\LocalGovMenuLinkGroup`, `Form\LocalGovMenuLinkGroupForm`, `Controller\LocalGovMenuLinkGroupListBuilder`, `MenuLinkGrouper`, `Plugin\Deriver\MenuGroups`.
