<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Datepicker — element, Webform & API

## Form API element
`#type => 'easy_datepicker'` (`src/Element/EasyDatepicker.php`, extends Textfield) — progressively-enhanced textfield attaching library `easy_datepicker/datepicker`. Options: min/max date, disable future/past, display format, initial view (days/months/years).

## Attach API
`easy_datepicker_attach(&$element, array $options = [])` — turn any custom textfield into a picker from code.

## Webform integration (soft)
`easy_datepicker_webform_element_alter()` attaches the picker to any Webform **Text** field with the `js-easy-datepicker` class. Per-field overrides via `data-cdp-*` attributes.

## Options alter
`hook_easy_datepicker_options_alter(&$options, $context)` — tighten/localize options per field (e.g. locale-based format).

## Value normalization
`easy_datepicker_normalize_date_value()` element-validate callback normalizes every submitted value to `Y-m-d` using strict `DateTime::createFromFormat` and rejects invalid/rolled-over dates (`getLastErrors()`), so downstream storage/exports are consistent.

## Defaults
`/admin/config/content/easy-datepicker` (`administer easy_datepicker settings`) — site-wide min/max/format defaults.
