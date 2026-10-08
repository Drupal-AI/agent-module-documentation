<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom widgets (custom_widgets) — agent index

**Two field widgets: allowed-values autocomplete for List fields (optionally via Select2) and a flat taxonomy select with parent-chain labels.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Widgets:** `custom_widgets_text_autocomplete` (list_float/integer/string), `custom_widgets_flat_select` (entity_reference → taxonomy)
- **Routes:** `custom_widgets.text_autocomplete`, `custom_widgets.text_autocomplete_select2` — JSON, `_access: 'TRUE'`
- **Helpers (.module):** `custom_widgets_calculate_hash()` = `Crypt::hmacBase64(serialize($params), Settings::getHashSalt())`; `custom_widgets_get_allowed_options()` = `options_allowed_values()`.
- **Security:** the two `_access:'TRUE'` autocomplete routes are gated by an HMAC keyed on the site hash salt (recomputed in `TextAutocompleteController::handleAutocomplete`/`handleAutocompleteSelect2`, `AccessDeniedHttpException` on mismatch). Controller only **reads** a field's allowed-values definition and returns JSON; **no writes, no reflection of the `q` input**.

See [configure/widgets.md](configure/widgets.md).