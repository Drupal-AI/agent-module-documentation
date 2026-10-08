<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Total time & Yield pseudo-fields, duration + RDFa (module `recipe`)

Two display-only extra fields on the `node/recipe` bundle, declared by
`recipe_entity_extra_field_info()` under `['node']['recipe']['display']`:
`recipe_total_time` (label "Total time", weight 4) and `recipe_yield` (label "Yield", weight 1).
Both are computed in `recipe_node_view()` (`hook_ENTITY_TYPE_view`) only when the active view
display has that component enabled.

## Total time

`recipe_build_total_time()` iterates the entity's `FieldConfigInterface` fields and sums any
that are **integer type** and carry third-party setting `recipe:total_time == 1` and have a
non-null value. It renders **only when more than one** such field is filled in
(`$total_time_count > 1`), via `#theme => 'recipe_total_time'` wrapping a `recipe_duration`
render element. Label + label-display come from the node type's third-party settings
`recipe:total_time_label` / `recipe:total_time_label_display`.

The per-field opt-in checkbox is added by
`recipe_form_field_config_edit_form_alter()`: on any `recipe`-bundle **integer** field's config
edit form it shows *"Add this field's value to the Recipe's total time."*, stored as
`third_party_settings.recipe.total_time`. The default recipe type ships `recipe_prep_time` and
`recipe_cook_time` integer fields as the intended summands.

## Yield

`recipe_build_yield()` concatenates `recipe_yield_amount` + `recipe_yield_unit` into
`@yield_amount @yield_unit`; skipped when `recipe_yield_amount` is null. Label from node-type
`recipe:yield_label`. (Note a small upstream quirk: the yield build reuses
`total_time_label_display` for `#label_display`.)

## Node-type "Recipe settings" tab

`recipe_form_node_type_edit_form_alter()` adds a details group with textfield labels and a
label-display select (`above` / `inline` / `hidden` / `visually_hidden`) for both pseudo-fields;
`recipe_form_node_type_form_builder()` writes them as node-type third-party settings and
invalidates the `node_view` cache tag. Defaults ship in `config/install/node.type.recipe.yml`
(`total_time_label: 'Total time'`, `yield_label: Yield`, both `above`).

## Duration rendering

`template_preprocess_recipe_duration()` turns a minutes integer into `hours` / `minutes` strings
(`formatPlural`, e.g. `90` → "1 hour" + "30 minutes"). The `recipe_duration` **field formatter**
(`RecipeDurationFormatter`, applies to integer fields) uses the same
`recipe-duration.html.twig`.

## RDFa (schema.org) — only when core `rdf` is enabled

`template_preprocess_recipe_total_time()` attaches RDFa `content_attributes` mapping
`schema:totalTime` with `datatype xsd:duration` and callback `recipe_duration_iso8601()`
(minutes → ISO-8601 `PT#H#M`, `PT0M` when empty). `template_preprocess_recipe_yield()` maps
`schema:recipeYield`. Optional `config/optional/rdf.mapping.node.recipe.yml` supplies the field
mappings; `rdf` is a dev/test dependency (`suggest`), not required at runtime.
