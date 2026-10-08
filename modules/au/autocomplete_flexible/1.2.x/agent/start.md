<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete Flexible (autocomplete_flexible) — agent index

**A configurable entity-reference autocomplete form element + field widget driven by a JS plugin.**

- **Version:** 1.2.x (1.2.0)
- **Core:** ^10.3 || ^11 || ^12
- **Submodule:** `autocomplete_flexible_examples` (demo controller/form/library)
- **Form element:** `autocomplete_flexible` (`src/Element/AutocompleteFlexible.php`) — properties `#flexible_default_value`, `#flexible_options`, standard `#autocomplete_route_name`/`_parameters`; MIN_LENGTH 3, `|` separator, unlimited cardinality supported.
- **Field widget:** `EntityReferenceAutocompleteFlexibleWidget` (Manage form display, entity_reference fields).
- **Library:** `js/plugin/autocomplete-flexible.js` + `js/init.js`.
- **API hook:** `hook_autocomplete_flexible_widget_label(&$label, $form_state, $context)` (see `autocomplete_flexible.api.php`).
- **No routes / permissions / services** in the base module.

**Security:** the module adds no endpoints; suggestions come from the standard core entity-reference autocomplete route, so referenced-entity access checks apply as in core. Nothing anonymous or mutating is introduced.

See [extend/autocomplete_flexible.md](extend/autocomplete_flexible.md)
