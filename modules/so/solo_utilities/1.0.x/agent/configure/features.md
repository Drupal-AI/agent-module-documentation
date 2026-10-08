# Solo Utilities — features & configuration

All three features are no-ops unless the active default theme is `solo` or has `solo` in its base-theme
chain (`solo_utilities__is_solo_or_sub_in_hierarchy_active()`, reads `system.theme:default`).

## 1. Color Schemes Rules (config entity + negotiator)

Config entity type `color_schemes_rule`; schema `solo_utilities.color_schemes_rules.*`. Admin UI:
`/admin/config/solo_utilities/color-schemes-rules` (list), add/edit/delete forms under the same path.
Menu parent: `solo_utilities.admin` (`/admin/config/system/solo_utilities`).

Each rule stores:
- `id`, `label`, `status` (bool, enabled)
- `conditions` — a sequence of core **Condition** plugin configs (`id`, `settings`, `negate`)
- `conjunction` — `and` | `or`
- `predefined_theme` — the color-scheme **library** to load when the rule matches (also `theme_category`, `library` fields exist in schema)

**Evaluation:** on every page, `hook_preprocess_page` calls
`\Drupal::service('solo_utilities.color_schemes_negotiator')->evaluateRules()`. It loads all rules,
skips disabled ones, applies runtime contexts to context-aware conditions, resolves them by the
rule's conjunction (with per-condition negate), and returns the `predefined_theme` of the **first**
matching rule. So rule order matters; one library wins per request.

Manage rules with config (`drush cget`/`cset`) or the UI; there is no Drush command.

## 2. Block title visibility & tag

Enabled by the Solo theme setting `enable_block_title_visibility`. When on,
`hook_form_block_form_alter` removes core's `label_display` checkbox and inserts two selects after
the block **Title** field:
- `solo_block_title_visibility` — `visible` (always render) | `visually_hidden` (screen-readers only, adds `visually-hidden` class) | `none` (title not rendered)
- `solo_block_title_tag` — `h1`,`h2`(default),`h3`,`h4`,`h5`,`h6`,`div`

Both are saved into the block config `settings` array via an `#entity_builders` callback and applied
in `hook_preprocess_block` (which also reconstructs a fallback label for `views_block:*` and other
plugins). Tag is validated against an allow-list (falls back to `h2`).

On module enable/disable, `solo_utilities.block_title_visibility_migrator` migrates legacy
`label_display` values into `solo_block_title_visibility` and cleans them up on uninstall
(`hook_modules_enabled` / `hook_modules_disabled` / `hook_update_8001`).

## 3. Custom node widths

Enabled by the Solo theme setting `enable_custom_node_width`. When on, `hook_form_node_form_alter`
adds a **Custom Width** `select` to node add/edit forms with options:
`none`, `sw-800`, `sw-1024`, `sw-1280`, `sw-1440`, `sw-1600`, `sw-1920`, `sw-2560`, `sw-100` (100%).

The value is read from the POST request in `hook_node_presave` / `hook_node_insert` and stored per
node in the **content entity** `node_width` (custom DB table `solo_theme_node_width`: `id`, `node_id`,
`width_class`). Choosing `none` deletes the stored row. This is content data, not exported config.
The active theme consumes the stored class when rendering the node.
