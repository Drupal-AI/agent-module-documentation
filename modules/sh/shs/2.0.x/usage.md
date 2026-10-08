Simple Hierarchical Select (SHS) is a taxonomy-term field widget that renders one cascading select box per hierarchy level: picking a parent term reveals a fresh dropdown of its children, loaded on demand via AJAX.

---

SHS provides the `options_shs` field widget for entity-reference fields that target a single taxonomy vocabulary. Instead of one long flat `<select>`, it shows a chain of dropdowns — choose the top-level term and a new select appears listing that term's children, and so on down the tree. The children for each level are fetched from a JSON endpoint (`/shs-term-data/{identifier}/{bundle}/{entity_id}`) served by `ShsController::getTermData()`, which returns one level of the term tree (tid, name, description, langcode, and a `hasChildren` flag) as a cacheable response. On the client, a Backbone.js app (`Drupal.behaviors.shs`) reads `drupalSettings.shs`, replaces the field's plain textfield (class `shs-enabled`) with the rendered widget, and rebuilds the level selects as the user navigates. Widget settings include `force_deepest` (require a leaf-level selection, enforced again server-side in `validateElement`), plus `create_new_items` / `create_new_levels` (present in schema but disabled in the current UI). A matching read display formatter, `entity_reference_shs`, renders the selected term's full ancestry as an item list. SHS also overrides the core Views filters `taxonomy_index_tid` and `taxonomy_index_tid_depth` so the same cascading UI works as an exposed filter, and integrates with Search API's term filter when present. The submodule **shs_chosen** layers the Chosen jQuery plugin on top for searchable, styled selects. The whole widget is themeable and alterable through JS class-definition hooks, JS-settings hooks, and term-data alter hooks documented in `shs.api.php`.

---

- Turn a deep taxonomy (categories, regions, product types) into level-by-level dropdowns instead of one huge flat list.
- Let editors drill down a country → state → city vocabulary on a node form.
- Attach the `options_shs` widget to any entity-reference field pointing at a single vocabulary.
- Load each level's child terms on demand over AJAX so large trees stay responsive.
- Force editors to pick a leaf (deepest-level) term with the `force_deepest` setting.
- Enforce deepest-level selection server-side, not just in the browser, via `validateElement`.
- Display a selected term together with its full ancestry using the `entity_reference_shs` formatter.
- Optionally link each ancestry label to its term page in the formatter output.
- Use the cascading hierarchical select as a Views exposed filter ("Has taxonomy terms").
- Use it as an exposed filter with depth ("Has taxonomy terms (with depth)").
- Integrate the hierarchical filter with a Search API index's term filter.
- Add Chosen-style searchable dropdowns to the SHS levels via the shs_chosen submodule.
- Support multi-value term fields, adding another hierarchical selector row per value.
- Respect field cardinality when building default parent chains for pre-selected values.
- Show translated term names in the dropdowns when content translation is enabled for the vocabulary.
- Hide unpublished terms from users who lack `administer taxonomy` / view-unpublished permission.
- Fetch child-term data programmatically from the `/shs-term-data/...` JSON endpoint.
- Alter the JSON term data before it is cached with `hook_shs_term_data_alter()`.
- Alter the term-data JSON response per bundle or per field with the response-alter hooks.
- Override the Backbone model/view classes for a field with `hook_shs_class_definitions_alter()`.
- Customize per-level labels and animation speed with `hook_shs_js_settings_alter()`.
- Relabel the empty option (e.g. "- Select a country -") through the JS settings hook.
- Reuse the `shs.widget_defaults` service to compute the parent chain for a saved term value.
- Restrict the widget to fields that target exactly one taxonomy vocabulary (its `isApplicable` rule).
- Replace an unwieldy autocomplete term field with a guided, browsable hierarchy.
- Theme the widget and the formatter output via the `shs.form` and `shs.formatter` libraries/CSS.
