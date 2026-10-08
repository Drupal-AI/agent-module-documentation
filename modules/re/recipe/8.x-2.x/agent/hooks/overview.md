<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & migration (module `recipe`)

All in `recipe.module`.

## Display / theming

- `hook_theme()` — registers `ingredient_recipeml_formatter`, `recipe_duration`,
  `recipe_total_time`, `recipe_yield`.
- `hook_entity_extra_field_info()` — declares the `recipe_total_time` and `recipe_yield` display
  pseudo-fields on `node/recipe`.
- `hook_ENTITY_TYPE_view()` (`recipe_node_view`) — populates those pseudo-fields; see
  [../fields/pseudo-fields.md](../fields/pseudo-fields.md).
- `template_preprocess_recipe_duration/_total_time/_yield/_view_plain_text/_view_recipeml` —
  preprocessors (duration math, RDFa, Content-Type headers).
- `recipe_duration_iso8601()` — minutes → ISO-8601 duration (used as an RDFa datatype callback).

## Form alters

- `recipe_form_field_config_edit_form_alter()` — adds the `recipe:total_time` checkbox to
  integer fields on the recipe bundle.
- `recipe_form_node_type_edit_form_alter()` + `recipe_form_node_type_form_builder()` — the
  node-type "Recipe settings" tab (pseudo-field labels), then invalidates the `node_view` tag.

## Migration (Drupal 6/7 → this field model)

- `hook_migration_plugins_alter()` (`recipe_migration_plugins_alter`) — detects the legacy Recipe
  module on the D7 source (schema 7000–7199) and injects process mappings
  (`source`→`recipe_source`, `yield`→`recipe_yield_amount`, `instructions`→`recipe_instructions`,
  etc.) onto the `recipe` node migrations, tags them `Recipe 7.x-1.x node`, and adds a dependency
  on `recipe1x_ingredient`.
- `hook_migrate_prepare_row()` (`recipe_migrate_prepare_row`) — for those tagged migrations,
  reads the legacy `recipe` table row (via `DrupalSqlBase::getDatabase()`) and copies its columns
  onto the migrate Row as source properties.

Migration definitions ship under `migrations/` (D6 `recipe61_*`, D7 `recipe72_*`, translations,
ingredient field display/instance) with migrate source plugins `Recipe61`, `Recipe71`, `Recipe72`
and, in the ingredient submodule, `recipe1x_ingredient*`. State file
`migrations/state/recipe.migrate_drupal.yml`.
