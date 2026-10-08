<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Autocomplete Plus

Extends Drupal's core entity autocomplete so each suggestion can show additional token-rendered context (for example an author, date, or status) appended after the label.

- Decorates the core `entity.autocomplete_matcher` service.
- Adds a per-widget "token string" third-party setting.
- Helps editors tell apart entities that share a label.
- Depends on the Token module for the token string.

---

# Installing & configuring

- Require and enable with Token (`drush en entity_autocomplete_plus`).
- Set a global default token string at `/admin/config/content/entity_autocomplete_plus`.
- Override per field on the entity-reference / inline-entity-form widget settings.
- The widget setting form is provided via `hook_field_widget_third_party_settings_form()`.
- A token browser link is shown for the mapped entity type.

---

# Usage & behaviour

- A `ServiceProvider` swaps the core matcher for `EntityAutocompletePlusMatcher`.
- `EntityAutocompletePlusMatcher` extends core `EntityAutocompleteMatcher`.
- The token string is injected as `token_string_suffix` into `#selection_settings`.
- Suggestions still come from the field's configured selection handler.
- Access filtering is delegated to that core selection handler (unchanged).
- Works with `entity_reference_autocomplete` and `inline_entity_form` widgets.
- The suffix is rendered per matched entity via the Token service.
- Global default applies unless a per-field token string overrides it.
- The settings summary shows the appended token for each configured widget.
- Only entity-reference field types are affected.
- No custom routes beyond the admin settings form are added.
- The settings form is gated by `administer site configuration`.
- No entity query bypasses the selection handler's access checks.
- Useful for taxonomy/user/node references with duplicate labels.
- Uninstalling reverts to the stock autocomplete matcher.
- Token module is a hard dependency.
