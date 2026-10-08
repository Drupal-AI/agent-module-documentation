<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recipe ships a `recipe` node bundle for cooking recipes plus an `ingredient` submodule whose custom field type stores each ingredient as a structured quantity + unit + reference rather than a line of prose.

---

Installing the module and its required `ingredient` submodule creates a `recipe` node type (fields: description, instructions, notes, source, prep time, cook time, yield amount/unit) and a separate `ingredient` content entity (name-only, translatable, at `/ingredient/{id}`). The substance is the `ingredient` field type (`Drupal\ingredient\Plugin\Field\FieldType\IngredientItem`, extends core `EntityReferenceItem`): each delta stores `target_id` (the ingredient entity), a `quantity` float, a `unit_key` string and a free-text `note`, entered through the `ingredient_autocomplete` widget which parses fractions like `1 1/2` into decimals and auto-creates missing ingredient entities. Units come from editable config (`ingredient.units` — `us`, `si`, `common` sets defined in `IngredientUnitUtility`); a per-field setting picks which sets appear and the default unit. At display time `recipe_node_view()` adds two pseudo-fields declared via `hook_entity_extra_field_info`: **Total time** sums every integer field on the bundle whose `field_config_edit_form` third-party checkbox `recipe:total_time` is ticked (shown only when ≥2 such fields have values), and **Yield** concatenates `recipe_yield_amount`/`recipe_yield_unit`; their labels/label-display are configured on the node-type edit form's "Recipe settings" tab. Durations render through `recipe_duration` theming (minutes → "1 hour 30 minutes") and, if core `rdf` is enabled, templates emit `schema:totalTime` (ISO-8601 via `recipe_duration_iso8601()`) and `schema:recipeYield` RDFa. Formatters: `recipe_duration` (integer), `ingredient_default` and `ingredient_recipeml` (ingredient field). Export is done with a custom Views **display** plugin (`recipe`, id `recipe`, returns a `CacheableResponse` with its own Content-Type) plus two **style** plugins — `recipeml` (RecipeML 0.5 XML) and `recipe_plain_text` (wordwrapped, tag-stripped text) — wired up by the shipped optional views `recipes`, `recipeml`, `recipe_plain_text` and `ingredients`. All access uses standard node permissions plus the ingredient entity permissions (`add/edit/delete/view ingredient`, `administer ingredient`); there is no bulk import beyond an optional Feeds target and the D6/D7 migration hooks. This module has nothing to do with core's config-and-content "Recipes" system (Drupal 10.3+) — say which is meant on any 10.3+ site.

---

- Build a cooking-recipe website with a ready-made content type.
- Store each ingredient as structured quantity + unit + reference, not prose.
- Enter quantities as fractions (`1 1/2`) that are parsed to decimals.
- Auto-create ingredient entities as editors type new names.
- Restrict a recipe field to U.S., metric (SI) or common unit sets.
- Compute and display a recipe's total time from multiple time fields.
- Combine yield amount and unit into one displayed pseudo-field.
- Emit schema.org RDFa (`totalTime`, `recipeYield`) for richer search results.
- Export recipes as RecipeML 0.5 XML for interchange with other recipe software.
- Offer a printer-friendly plain-text view of recipes.
- Maintain a reusable, translatable ingredient vocabulary at `/admin/content/ingredient`.
- List every recipe that references a given ingredient.
- Normalize new ingredient names to lowercase (trademark-aware) on save.
- Migrate legacy Recipe 6.x/7.x nodes and ingredients into the field-based model.
- Import recipes/ingredients in bulk via the Feeds ingredient target.
- Publish a restaurant menu or bakery product pages as structured dishes.
- Run a community cookbook or family recipe archive.
- Support a food blog or meal-planning site with consistent recipe data.
- Categorize recipes by cuisine using ordinary taxonomy fields.
- Extend the supplied Recipe type with nutrition or dietary fields (it is a starting point).
