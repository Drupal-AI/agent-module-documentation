<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

There is no central Recipe settings page. Configuration lives in three places.

## 1. Ingredient settings — `ingredient.ingredient_settings`

Route `/admin/structure/ingredient_settings`, form
`Drupal\ingredient\Form\IngredientSettingsForm` (`ConfigFormBase`, id
`ingredient_admin_settings`), `_permission: 'administer ingredient'`. This is the module's
`configure` link (declared on the `ingredient` submodule). Editable config `ingredient.settings`:

- `ingredient_name_normalize` (radios, required) — `0` = leave names as entered, `1` = lowercase
  new ingredient names on save. Enforced in `Ingredient::preSave()` for new entities only, and it
  **skips names containing `®`** (registered trademarks).
- `default_language` — when core `language` is enabled, a `language_configuration` element for the
  `ingredient` entity/bundle (content language settings).

Default: `ingredient_name_normalize: 0` (`config/install/ingredient.settings.yml`).

## 2. Node-type "Recipe settings" tab

On `/admin/structure/types/manage/recipe`, `recipe_form_node_type_edit_form_alter()` adds label +
label-display config for the Total time and Yield pseudo-fields, stored as node-type third-party
settings under the `recipe` provider. See [../fields/pseudo-fields.md](../fields/pseudo-fields.md).

## 3. Per-field settings

- On any `recipe`-bundle **integer** field: a
  *"Add this field's value to the Recipe's total time"* checkbox
  (`third_party_settings.recipe.total_time`).
- On an `ingredient` field: `unit_sets` (which of `us`/`si`/`common` appear) and `default_unit`.

## Editable unit vocabulary — `ingredient.units`

`config/install/ingredient.units.yml` seeds three unit sets (`us`, `si`, `common`); edit/export
this config to add units or sets. Read at runtime by the `ingredient.unit` service
(`IngredientUnitUtility`, ctor `@config.factory`). Schemas:
`modules/ingredient/config/schema/ingredient.schema.yml`, `config/schema/recipe.schema.yml`.

## Services

`recipe.breadcrumb` / `ingredient.breadcrumb` (breadcrumb builders, priority 100, adding a
Home → Recipes / Ingredients trail on recipe nodes and ingredient entities), `ingredient.unit`,
`ingredient.quantity` (fraction↔decimal), `ingredient.fuzzymatch` (free-text → unit key).
