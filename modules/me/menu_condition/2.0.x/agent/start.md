# Menu Condition — agent index

Provides ONE core Condition plugin, **`menu_position`** ("Menu position"), and nothing else:
no config entity, no settings form, no configure route, no services, no permissions, no Drush.
It shows a block (or any condition consumer) when a chosen menu link — and its children — is in
the current page's active menu trail.

- **The `menu_position` plugin: the `menu_parent` value format, evaluate/summary logic, how it
  sits in block visibility config, cacheability** →
  [plugins/menu-position.md](plugins/menu-position.md)

Key fact: the stored value is a single string `menu_parent` = `"<menu_name>:<link_plugin_id>"`
(e.g. `main:standard.front_page`) or `"<menu_name>:"` for a whole menu. In a block it lives at
`block.block.<id>` → `visibility.menu_position.menu_parent`. Empty value → condition is TRUE
(no restriction).

## What this is (and is not)

It is a **block/condition visibility** helper keyed off menu structure — a display convenience.
It is **not** an access-control mechanism: it decides where a *block* renders, not who may reach
a route. Do not use it to protect content; use permissions/route access for that. The module has
no permissions or config UI of its own — the condition is set inside a block's Visibility settings
(gated by `administer blocks`).

## Diff 1.x → 2.0.x

The `menu_position` plugin's behavior, config value format, evaluate/summary logic, and
cacheability are **unchanged** between 1.x and 2.0.x. The 2.0.0 release is a supported-core /
packaging major bump, not a behavioral rewrite:

- **BC: core requirement narrowed** from `^8 || ^9 || ^10 || ^11` to **`^10 || ^11`**. Drupal 8
  and 9 are no longer supported — that is the reason for the major version. `data.json`
  `core_semver_minimum` moves 8000000 → 10000000.
- **Config schema added.** 2.0.x ships `config/schema/menu_condition.schema.yml` defining
  `condition.plugin.menu_position` with a single `menu_parent: string` mapping (extends
  `condition.plugin`). 1.x shipped no schema (`provides_config_schema` false → **true**).
- **Functional test added.** `tests/src/Functional/MenuPositionBlockVisibilityTest.php` places a
  `system_powered_by_block` gated by the condition and asserts it renders on the selected link and
  its descendants but not on siblings / unrelated pages.
- No new plugin/service/route/permission; the stored `menu_parent` string and existing block
  placements continue to work with no migration.
