<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete List (autocomplete_list) — agent index

**An entity-reference field widget: one autocomplete box plus a list of selected references.**

- **Version:** 2.0.x
- **Core:** `^9.1 || ^10 || ^11`  · package Fields · depends on core `field`
- **Plugin:** `EntityReferenceAutocompleteList` (widget id `entity_reference_autocomplete_list`, field type `entity_reference`).
- **Settings:** `match_operator` (`CONTAINS`/`STARTS_WITH`), `size`, `placeholder`.
- **No routes, permissions or services** — a pure field-widget plugin using core AJAX (`AjaxResponse`, `InvokeCommand`).

**Security:** no endpoints or permissions; selections are validated against field constraints and output through `FieldFilteredMarkup`/`Html`. No security findings.

See [plugins/widget.md](plugins/widget.md)
