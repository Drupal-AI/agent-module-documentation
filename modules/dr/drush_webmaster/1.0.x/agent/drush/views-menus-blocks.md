<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site structure: views, menus, blocks

YAML output; mutating commands accept `--dry-run`. Managers: `ViewManager` +
`ViewsDiscoveryService` (`@views.views_data`), `MenuManager` (injects `@database`), `BlockManager`.

## Views — `wm:view:*` (`ViewCommands`)

CRUD, lifecycle, discovery, preview and a file-based edit/apply workflow.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:view:list` | `wm-vl`, `wm:v:list` | — |
| `wm:view:get` | `wm-vg`, `wm:v:get` | `view_id` |
| `wm:view:create` | `wm-vc`, `wm:v:create` | `view_id` `label` + `--description --base-table --base-field --tag --dry-run` |
| `wm:view:update` | `wm-vu`, `wm:v:update` | `view_id` `--label --description --tag --dry-run` |
| `wm:view:delete` | `wm-vd`, `wm:v:delete` | `view_id` `--dry-run` |
| `wm:view:enable` / `disable` | `wm-ve`/`wm-vdi` … | `view_id` `--dry-run` |
| `wm:view:clone` | `wm-vcl`, `wm:v:clone` | `source_id` `new_id` `label` `--dry-run` |
| `wm:view:tables` | `wm-vt`, `wm:v:tables` | — (available base tables) |
| `wm:view:available:fields\|filters\|sorts\|relationships\|arguments\|areas` | `wm-vaf`/`wm-vafi`/`wm-vas`/`wm-var`/`wm-vaa`/`wm-vaar` … | `base_table` `--group` |
| `wm:view:validate` | `wm-vval`, `wm:v:validate` | `file` (validate a view YAML) |
| `wm:view:preview` | `wm-vp`, `wm:v:preview` | `view_id` `display_id` + `--args --exposed --page --items-per-page --output` |
| `wm:view:config` | `wm-vcfg`, `wm:v:config` | `view_id` (raw config) |
| `wm:view:edit` | `wm-ve` | `view_id` (export to versioned YAML) |
| `wm:view:apply` | `wm-va` | `view_id` `--dry-run` |
| `wm:view:history` | `wm-vh` | `view_id` |
| `wm:view:revert` | `wm-vr` | `view_id` `--version --dry-run` |

- The **`wm:view:available:*`** family is powered by `ViewsDiscoveryService`, which reads
  `views.views_data` for a base table so an agent can learn valid field/filter/sort/argument/
  relationship/area handler ids before editing a view. `--group` filters by handler group.
- `wm:view:edit`/`apply`/`history`/`revert` reuse `FileVersionManager` (versioned view YAML under
  `~/.drush-wm/views/`). `wm:view:apply` reads the latest exported file
  (`file_get_contents` + `Yaml::parse`) and re-saves the `view` config entity.
- `wm:view:preview` renders a display through the render service; `ViewManager` calls
  `$view->access($display_id)` before rendering the preview (the one access check in the module,
  used only to decide whether preview is allowed).
- **Alias collision note:** `wm:view:enable` and `wm:view:edit` both declare alias `wm-ve`. Use the
  full command names to be unambiguous.

## Menus — `wm:menu:*` (`MenuCommands` + `MenuManager`)

Manages `menu` config entities and `menu_link_content` entities.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:menu:list` | `wm-ml`, `wm:m:list` | — |
| `wm:menu:get` | `wm-mg`, `wm:m:get` | `menu_id` (with link tree) |
| `wm:menu:create` | `wm-mc`, `wm:m:create` | `menu_id` `label` `--description --dry-run` |
| `wm:menu:delete` | `wm-md`, `wm:m:delete` | `menu_id` `--dry-run` (blocked if locked or has links) |
| `wm:menu:link:list` | `wm-mll`, `wm:m:l:list` | `menu_id` |
| `wm:menu:link:add` | `wm-mla`, `wm:m:l:add` | `menu_id` `--title --link-uri --weight --description --enabled --expanded --dry-run` |
| `wm:menu:link:update` | `wm-mlu`, `wm:m:l:update` | `link_id` `--title --link-uri --weight --description --enabled --dry-run` |
| `wm:menu:link:delete` | `wm-mld`, `wm:m:l:delete` | `link_id` `--dry-run` |

- Menu id validated `^[a-z][a-z0-9_-]*$`. Link URI validated by `MenuManager::isValidUri()` — allows
  `internal: entity: route: base:` prefixes and `http(s)://` URLs.
- `MenuManager` builds the tree via `@menu.link_tree` (with checkAccess + sort manipulators) and, if
  the tree comes back empty, **falls back to a parameterised `@database` select** on
  `menu_link_content_field_data` filtered by `menu_name` (`->condition('menu_name', $menu_id)` — a
  bound parameter, not string-built SQL) to work around SQLite revision/language quirks.

## Blocks — `wm:block:*` (`BlockCommands` + `BlockManager`)

Places and manages `block` config entities in theme regions.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:block:list` | `wm-bl`, `wm:b:list` | `--theme` (default theme) |
| `wm:block:types` | `wm-bt`, `wm:b:types` | — (available block plugin ids) |
| `wm:block:get` | `wm-bg`, `wm:b:get` | `block_id` |
| `wm:block:place` | `wm-bp`, `wm:b:place` | `plugin_id` `region` `--theme(required) --id --label --weight --dry-run` |
| `wm:block:update` | `wm-bu`, `wm:b:update` | `block_id` `--region --weight --label --status --dry-run` |
| `wm:block:remove` | `wm-br`, `wm:b:remove` | `block_id` `--dry-run` |

`BlockManager` uses `@plugin.manager.block`, `@theme_handler` and `@config.factory`; `wm:block:list`
and `wm:schema:dump`'s block section report id/label/region/plugin/status/weight for a theme.
