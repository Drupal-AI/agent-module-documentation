<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recipe (`recipe`) — agent index

Culinary-recipe module: a `recipe` **node bundle** plus a bundled **`ingredient`** submodule that
adds an Ingredient **content entity** and a custom `ingredient` reference **field type**. Version
**8.x-2.3**, `core_version_requirement: ^10 || ^11`. Requires `recipe:ingredient`, core `node`,
`path`, `text`. License GPL-2.0-or-later. Config schema provided; no Drush commands; no plugin
*types* defined.

> **Name collision — always disambiguate.** Core has a separate feature called **Recipes**
> (packaged config + content applied to a site, the successor to distributions), unrelated to this
> module and to cooking. On a Drupal 10.3+ site say which is meant.

## What it actually is (read the source, not the name)

- `recipe.info.yml` — bundle-provider module. Only route is `recipe.landing_page` (`/recipe`,
  `_permission: 'access content'`). Config `install/` ships the `recipe` node type, nine
  `field.storage`/`field.field` definitions (description, instructions, notes, source, prep_time,
  cook_time, yield_amount, yield_unit, and the `ingredient` field), form/view displays, and
  optional views + RDF mapping. No `recipe.permissions.yml`.
- `recipe.module` — the logic: view-time pseudo-fields, node-type/field third-party settings,
  duration + RDFa theming, D6/D7 migration wiring. See [hooks](hooks/overview.md).
- `modules/ingredient/` — the substance: the Ingredient entity, the `ingredient` field type,
  the autocomplete widget, unit config, and all the entity permissions.

## Map

- [fields/ingredient-field.md](fields/ingredient-field.md) — the `ingredient` field type, its 4
  stored columns, the `ingredient_autocomplete` widget (fraction parsing, autocreate), unit sets,
  and the formatters.
- [fields/pseudo-fields.md](fields/pseudo-fields.md) — Total time + Yield extra fields, how the
  `recipe:total_time` third-party checkbox drives the sum, duration formatting, RDFa.
- [views/export.md](views/export.md) — the `recipe` Views display plugin and the `recipeml` /
  `recipe_plain_text` style plugins; shipped views.
- [permissions/overview.md](permissions/overview.md) — node permissions + the five `ingredient`
  entity permissions and the access handler.
- [configure/overview.md](configure/overview.md) — Ingredient settings form, node-type "Recipe
  settings" tab, per-field unit config, editable `ingredient.units`.
- [hooks/overview.md](hooks/overview.md) — `hook_entity_extra_field_info`, `recipe_node_view`,
  form alters, `hook_migration_plugins_alter` / `hook_migrate_prepare_row`.

## Key names

- Entity: `ingredient` (base_table `ingredient`, data_table `ingredient_field_data`,
  admin_permission `administer ingredient`, links `/ingredient/{ingredient}[/edit|/delete]`).
- Field type `ingredient` → `IngredientItem` (extends `EntityReferenceItem`); widget
  `ingredient_autocomplete`; formatters `ingredient_default`, `ingredient_recipeml`.
- Integer formatter `recipe_duration` (`RecipeDurationFormatter`).
- Views: display `recipe`, styles `recipeml` + `recipe_plain_text`; views `recipes`, `recipeml`,
  `recipe_plain_text`, `ingredients`.
- Services: `recipe.breadcrumb`, `ingredient.breadcrumb`, `ingredient.unit`, `ingredient.quantity`,
  `ingredient.fuzzymatch`.
- Config: `ingredient.settings` (`ingredient_name_normalize`), `ingredient.units` (sets `us`,
  `si`, `common`).
