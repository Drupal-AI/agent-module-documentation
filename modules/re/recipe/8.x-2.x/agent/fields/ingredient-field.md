<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ingredient` field type (submodule `ingredient`)

`Drupal\ingredient\Plugin\Field\FieldType\IngredientItem` — extends core
`EntityReferenceItem`, so it is an entity-reference to `ingredient` entities **plus** three extra
per-delta columns. Annotation: `default_widget = "ingredient_autocomplete"`,
`default_formatter = "ingredient_default"`, `category = "reference"`,
`list_class = IngredientFieldItemList`. `defaultStorageSettings()` forces
`target_type = ingredient`. Added via Field UI ("Ingredient" under *Reference*) or config; the
shipped instance is `field.field.node.recipe.recipe_ingredient`.

## Stored columns (`schema()`)

| Column | Type | Notes |
|---|---|---|
| `target_id` | int unsigned | Ingredient entity id. Indexed; FK to `ingredient.id`. |
| `quantity` | float, nullable | Decimal amount (fractions converted on save). |
| `unit_key` | varchar 255, NOT NULL, default `''` | Untranslated key into `ingredient.units`. |
| `note` | varchar 255, NOT NULL, default `''` | Free-text prep note ("finely chopped"). |

Property definitions add `quantity` (untyped `DataDefinition::create('')`), `unit_key` (string),
`note` (string) on top of the inherited reference properties.

## Field settings (`fieldSettingsForm`)

- `unit_sets` — checkboxes of unit-set options from `ingredient.unit` service
  (`getUnitSetOptions()`); only units in the enabled sets appear in the widget. Empty = all units.
- `default_unit` — select whose options are AJAX-rebuilt from the chosen sets
  (`processDefaultUnit` / `setChangeAjaxCallback`).

`generateSampleValue()` creates a random ingredient entity + random quantity/unit for
devel-generate.

## Widget `ingredient_autocomplete` (`IngredientWidget`)

Per delta renders: `quantity` textfield (size/max 8), `unit_key` select (options from
`ingredient.unit` → `createUnitSelectOptions`, sorted by name), `target_id`
`entity_autocomplete` (`#target_type => ingredient`, `#autocreate` bundle `ingredient`,
`#validate_reference => FALSE`), and a `note` textfield. Attaches library
`ingredient/drupal.ingredient`.

- **Fraction parsing**: `massageFormValues()` runs the quantity through
  `IngredientQuantityUtility::getQuantityFromFraction()` and `round(..., 6)`, so `1 1/2` → `1.5`.
  Display reverses it via `getQuantityFromDecimal(..., '{%d} %d&frasl;%d', TRUE)`.
- **Autocreate**: the autocomplete returns an array when the typed ingredient does not exist;
  `massageFormValues()` lifts that into `target_id`, and core saves a new `ingredient` entity.
  So **any user who can edit a recipe can create ingredient entities** through the widget,
  independent of the `add ingredient` permission (that permission gates the standalone
  `/ingredient/add` form).
- **Validation** (`validate()`): if a name is present but no unit chosen, sets a form error
  "You must choose a valid unit."

## Units config

`ingredient.units` (`config/install/ingredient.units.yml`) defines three editable sets:
`us` (cup, pint, quart, gallon, pound, ounce, fluid ounce), `si` (milliliter…kilogram),
`common` (tablespoon, teaspoon, slice, clove, loaf, pinch, package, can, drop, bunch, dash,
carton, unit, unknown). Each unit has `name`, `plural`, `abbreviation`, `aliases`. Resolved by
`IngredientUnitUtility` (service `ingredient.unit`, ctor arg `@config.factory`);
`IngredientUnitFuzzymatch` (`ingredient.fuzzymatch`) matches free text to a unit key.

## Formatters

- `ingredient_default` (`IngredientFormatter`, ingredient field) — themed
  `ingredient-formatter.html.twig`, shows quantity/unit/name/note.
- `ingredient_recipeml` (`IngredientRecipeMLFormatter`, in the parent `recipe` module) —
  RecipeML `<ingredient>` markup, used by the RecipeML export.
- `recipe_duration` (`RecipeDurationFormatter`, on **integer** fields) — see
  [pseudo-fields.md](pseudo-fields.md).
