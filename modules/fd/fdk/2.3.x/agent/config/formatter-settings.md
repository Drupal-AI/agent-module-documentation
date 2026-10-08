<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FDK formatter settings (field third-party settings)

FDK stores its options as **field formatter third-party settings**, so there is no standalone config
form or route. Settings are attached to the entity view display and travel with exported config.

## Where they live

- Hook `fdk_field_formatter_third_party_settings_form()` (`fdk.module`) → `FDKHelper::settingsForm()`
  (`src/FDKHelper.php`) builds the form section that appears on every field's formatter settings
  (Manage display, and per-field in Layout Builder).
- Hook `fdk_field_formatter_settings_summary_alter()` → `FDKHelper::formatter_settings_summary_alter()`
  adds a summary using theme hook `fdk_settings_summary` (`templates/fdk-settings-summary.html.twig`).
- Config schema: `config/schema/fdk.schema.yml`, type `field.formatter.third_party.fdk` (a `mapping`).
  `provides_config_schema: true`.

## Settings groups (schema keys)

Top-level `details` element is `fdk`, containing four mappings:

- **`field_wrapper`** — wrapper around the whole field.
  - `html_element` (select: `_default`, `div`, `_other`), `html_element_other` (custom tag),
    `html_element_classes` (space-separated), `html_element_attributes` (textarea, one `attribute|value`
    per line; tokens supported), `force_multiple` (boolean — render the wrapper even for a single value).
- **`field_item_wrapper`** — wrapper around each field item value.
  - `html_element` (select: `_default`, `a` (Link), `h1`–`h6`, `div`, `span`, `p`, `strong`, `_other`),
    `html_element_other`, `html_element_link_href` (link destination, tokens supported; used when element
    is `a`), `html_element_classes`, `html_element_attributes`.
- **`label`** — the field label.
  - `value` (override label text; hidden inside Layout Builder forms, which provide their own title
    override), `html_element` (select `_default`/`div`/`_other`), `html_element_other`,
    `html_element_classes`, `html_element_attributes`.
- **`field_delimiter`** — between multi-value items.
  - `enabled` (boolean — "Add comma between field items"), `value` (delimiter string, default `', '`),
    `include_and` (add `and` before the last item when more than one value).

Defaults are supplied by `FDKHelper::prepareConfigurationSettings()` (each `html_element` defaults to
`_default`, i.e. FDK does not alter that aspect).

## Validation (in FDKHelper)

- `validateHtmlTagName()` — for `_other`, requires a non-empty value matching `/^[a-zA-Z]+\d?$/`
  (letters plus an optional single digit); errors on invalid tag names.
- `validateHtmlAttributesList()` — each non-empty line must match `/^([\w]+(\-[\w]+)*)\|(.*)$/`
  (an `attribute|value` pair); otherwise "Invalid attribute setting(s)".
- `validateHref()` — when the item element is `a`, the link destination is required.

## Token integration

When `token` module is enabled, the form adds `token_tree_link` helpers for the attribute textareas and
the link href, scoped to the target entity type (`$field_definition->getTargetEntityTypeId()`).
Token replacement is performed at render time (see [../theming/field-rendering.md](../theming/field-rendering.md)).

## Operating

1. Go to a bundle's Manage display (`/admin/structure/…/display`) or open the field in Layout Builder.
2. Open the field's formatter settings gear; find **Field Display Kit Settings**.
3. Set wrapper elements / classes / attributes / label / delimiter as needed, update, and save the
   display. Repeat per view mode for different treatments.
