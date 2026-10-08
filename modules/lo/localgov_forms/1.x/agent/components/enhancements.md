<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Element enhancements, form errors & the purge_date token

Small additions the module makes on top of Webform, all in `localgov_forms.module` /
`localgov_forms.tokens.inc` / `localgov_forms.libraries.yml`. No config, no routes.

## Two-decimal number constraint

Adds a **Two decimal places** option to core's Webform `number` element:

- `hook_webform_element_default_properties_alter()` adds property `localgov_forms_two_decimal`
  (default FALSE) to `number` elements.
- `hook_webform_element_configuration_form_alter()` renders a *LocalGov Forms* details section with
  a **Two decimal places** checkbox; `hook_form_webform_ui_element_form_alter()` disables the manual
  *step* field when it is ticked (`#states`).
- `hook_webform_element_alter()`: when set, forces `#step = 0.01`, adds `step="0.01"`,
  `inputmode="decimal"` and `data-two-decimal="true"`, attaches library
  `localgov_forms/localgov_forms_two_decimal` (`js/localgov_forms_two_decimal.js`, truncates on
  input, normalises `1` → `1.00` on blur/submit), and appends `localgov_forms_two_decimal_validate`
  to `#element_validate`.
- `localgov_forms_two_decimal_validate()` runs after core's `Number::validateNumber()` (which
  strips trailing zeros) and re-applies `number_format((float) $value, 2, '.', '')` so the **stored**
  value keeps two decimals, not just the display.

## Character-counter ARIA

`hook_webform_element_alter()`: any element with a `#counter_type` property gets library
`localgov_forms/localgov_forms_counter_aria` (`js/localgov_forms_counter_aria.js`) attached, which
adds accessible live-region announcements to Webform's character/word counter.

## Form errors library

`hook_preprocess_webform()` attaches `localgov_forms/localgov_forms.form_errors`
(`js/form_errors.js`) to **every** webform, improving how validation errors are surfaced. Depends on
`inline_form_errors` (a module dependency). All libraries in `localgov_forms.libraries.yml` are
local JS/CSS (`core/drupal`, `core/jquery`, `core/once`) — no external/CDN assets.

## purge_date token

`localgov_forms.tokens.inc` declares a `webform_submission:purge_date` token
(`hook_token_info` / `hook_tokens`). It computes the submission's automatic purge date from the
form's `purge_days` setting: `createdTime + purge_days * 86400`, formatted with
`WebformDateHelper::format($ts, 'medium', '')`. Chained date tokens work too
(`purge_date:long`, `purge_date:custom:d/m/Y`, …) via `token->generate('date', …)`. Only emits when
`purge_days` is set on the webform. Use it in confirmation/email text to tell submitters when their
data will be deleted.

## Theme hooks

`hook_theme()` registers `localgov_forms_uk_address_lookup` and `localgov_forms_uk_address` render
elements (templates in `templates/`); their `template_preprocess_*` functions expose composite
children in a `content` variable (lifted from Webform's composite preprocess).
