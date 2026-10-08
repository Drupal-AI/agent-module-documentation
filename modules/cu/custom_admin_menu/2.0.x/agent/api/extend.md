<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend Custom Admin Menu (metadata, hooks, condition, shortcuts)

## Per-item role / language visibility (menu-link `metadata`)

Custom-menu items can be hidden per role or interface language, but only via the menu-link **plugin
definition `metadata`** — there is no UI field on standard menu-link forms, so this works for links
defined in `*.links.menu.yml`, a menu-link deriver, or set through
`hook_menu_links_discovered_alter`. Filtering runs in
`CustomAdminMenuMenuItemDisplayManager` (`filterItems()` / `initMenuItemsDisplayState()`), and only
for links whose `menu_name` is `custom-admin-menu`.

Recognized `metadata` keys:

| Key | Type | Rule |
|---|---|---|
| `disallowed_roles` | array of role ids | Item hidden if the user has **any** listed role. |
| `need_roles` | array of role ids | Item hidden unless the user has **at least one** listed role. (Checked only if `disallowed_roles` is empty.) |
| `allowed_languages` | array of langcodes | Item hidden unless the current interface language is in the list. |

```yaml
# my_module.links.menu.yml
my_module.editor_only:
  title: 'Editor tools'
  menu_name: custom-admin-menu
  url: internal:/admin/content
  metadata:
    need_roles: ['editor']
    allowed_languages: ['en', 'fr']
```

User 1 (superuser) bypasses all of the above and always sees every item.

## Alter hooks

Both fire in `CustomAdminMenuManager` while building the custom menu (module hook then theme hook):

- `hook_custom_admin_menu_alter(array &$build)` — alter the whole custom-menu render array
  (`#items` etc.) before it is placed in the toolbar.
- `hook_custom_admin_menu_item_alter(array &$item, array $context)` — alter one item; `$context`
  has `plugin_id` (underscored/dashed link plugin id) and `suffix` (last dotted segment of the
  original plugin id). Each item already gets `toolbar-icon` + `toolbar-icon-<id>` classes.

## Theme Condition plugin

Core Condition plugin `custom_admin_menu_theme_condition` (`src/Plugin/Condition/ThemeCondition.php`,
label "Theme Condition"). Config: `allowed_themes` (checkboxes of installed themes). Evaluates true
when no theme is selected, or when the active theme is among the selected ones (respects negation).
Usable anywhere Drupal consumes condition plugins (e.g. block visibility). Schema:
`condition.plugin.custom_admin_menu_theme_condition` in `config/schema/custom_admin_menu.schema.yml`
(this is the only schema the module ships).

## Shortcuts template override

The shortcuts region (see configure doc) renders through theme hook `custom_admin_menu_shortcuts`
(template `templates/custom-admin-menu-shortcuts.html.twig`, variable `blocks`). A
`hook_theme_registry_alter` (`src/Hook/ShortcutTemplate.php`) redirects both the `toolbar` and
`custom_admin_menu_shortcuts` templates to the **admin theme's** `templates/toolbar/` directory when
that theme provides `custom-admin-menu-shortcuts.html.twig`, so an admin theme (e.g. Gin) can
override the shortcuts markup.

## Convenience redirect routes

`CustomAdminMenuController` provides toolbar-friendly "edit the matching entity" links (gated by
`access content overview`); each redirects to the target entity's edit form, which enforces its own
access:

- `/admin/node/edit` — redirect to the edit form of the newest node matching query params.
- `/admin/term/edit` — same for taxonomy terms.
- `/admin/{entity_type}/edit` — same for any entity type.

Query params map to entity properties (`loadByProperties`); a `:` in a key becomes `.` (nested
field). Array-valued params switch to an entity query with `condition(field, value, type)`.
`/admin/overview/{link_id}` (`CustomAdminMenuOverviewController`, extends core `SystemController`)
renders the admin overview block for a menu link and self-gates on whether the user has accessible
sublinks.
