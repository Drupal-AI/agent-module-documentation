<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the custom widgets

Both widgets are configured on **Manage form display** for the relevant field.

## Autocomplete (`custom_widgets_text_autocomplete`)
Field types: `list_float`, `list_integer`, `list_string`. Settings:
- `max_items` — max suggestions returned (default 15).
- `matching_method` — `contains` or `beginswith`.
- `use_select2` — `yes`/`no` (only offered when the Select2 module is enabled).

At render time the widget attaches `#autocomplete_route_parameters` including a `hash` =
`custom_widgets_calculate_hash([...field_name, count, entity_type_id, matching_method, uid...])`.
Requests hit `custom_widgets.text_autocomplete` (or `…_select2`); the controller recomputes the HMAC
(keyed on `Settings::getHashSalt()`) and returns `AccessDeniedHttpException` unless it matches.
Response is JSON drawn from `options_allowed_values()` of the field — allowed option labels/keys only.

## Flat select (`custom_widgets_flat_select`, extends OptionsSelectWidget)
Field type: `entity_reference` to `taxonomy_term`. Setting:
- `force_deepest` — hide top-level (parentless) terms so only leaf terms are selectable.
Each option label becomes the full `Grandparent >> Parent >> Child` chain via `loadParents()`.

## Security note
The autocomplete endpoints are `_access: 'TRUE'` but require a valid site-salt HMAC and only expose
field allowed-values (config-level), so they are not a data-leak or mutation surface.
