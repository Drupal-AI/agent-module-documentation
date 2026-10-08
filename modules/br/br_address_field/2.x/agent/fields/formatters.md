<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display formatters & Twig template

All formatters live in `src/Plugin/Field/FieldFormatter/`, apply to `br_address_field_type`, and
escape output — single-part formatters set `#plain_text` (and a `#markup` of
`nl2br(Html::escape($item->value))`); the plain formatter renders through a Twig template
(auto-escaped).

## Whole address — `br_address_plain_formatter`
`BrAddressPlainFormatter`, label "Brazilian address" (the field type's default formatter).
- Setting `display_state` (default 0): `0` = full state name ("Complete name"), `1` = two-letter
  initials.
- `viewElements()` maps each item to a `#theme => 'br_address_field'` render element passing
  `postal_code`, `thoroughfare`, `number`, `street_complement`, `neighborhood`, `city` and the
  resolved `state` (looked up in the 27-UF map when `display_state` = 0, else raw initials).
- Rendered by `templates/br-address-field.html.twig` (theme hook `br_address_field`, registered in
  `br_address_field.module::br_address_field_theme()`), which prints each present part inside
  `<p class="address" translate="no">`. Values are printed through Twig `{{ }}` (auto-escaped).

## Single-part formatters
Each renders one column via `#plain_text`:

| Formatter id | Class | Label | Value |
|---|---|---|---|
| `br_address_postal_code_formatter` | `BrAddressPostalCodeFormatter` | Postal Code | `postal_code` |
| `br_address_thoroughfare_formatter` | `BrAddressThoroughfareFormatter` | Thorougfare | `thoroughfare` |
| `br_address_number_formatter` | `BrAddressNumberFormatter` | Number | `number` |
| `br_address_complement_formatter` | `BrAddressComplementFormatter` | Complement | `street_complement` |
| `br_address_neighborhood_formatter` | `BrAddressNeighborhoodFormatter` | Neighborhood | `neighborhood` |
| `br_address_city_formatter` | `BrAddressCityFormatter` | City | `city` |
| `br_address_state_formatter` | `BrAddressStateFormatter` | State | `state` (initials) |
| `br_address_state_full_formatter` | `BrAddressStateFullFormatter` | State full | full state name (from the 27-UF map) |

(Labels reproduced verbatim from the plugin annotations, including the "Thorougfare" typo.) The
single-part formatters have empty `settingsForm()`/`settingsSummary()` — no configurable options.

## Theming
- Override `br-address-field.html.twig` in your theme to change the full-address markup (available
  variables: `postal_code`, `thoroughfare`, `number`, `street_complement`, `neighborhood`, `city`,
  `state`).
- Styling comes from CSS library `br_address_field/theme` → `css/br_address_field.css`, attached by
  the widget; there is no formatter-attached library.
