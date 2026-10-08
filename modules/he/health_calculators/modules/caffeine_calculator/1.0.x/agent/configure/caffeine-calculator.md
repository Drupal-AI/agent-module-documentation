<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Caffeine Calculator — configuration

## Admin settings
`/admin/config/tools/caffeine-calculator` (`caffeine_calculator.settings_form`, permission `Administer Caffeine Calculator`), backed by `SettingsForm` (`ConfigFormBase`, editable config `caffeine_calculator.settings`):
- **Drinks and Caffeine Amounts** — a textarea of `drink_name|caffeine_amount` lines (mg per 100 ml). Validated to require exactly one `|` per line; saved as a `drinks[]` list.
- **Help Text** — intro text shown above the front-end form.

A default drinks list and placeholder help text ship in `config/install/caffeine_calculator.settings.yml`.

## Front-end form
`/body-calculators/caffeine-calculator` (`caffeine_calculator.form`, permission `access content`), built by `CaffeineCalculatorForm`:
- If no drinks are configured it shows an error (with a config link for privileged users) and stops.
- Fields: drink (AJAX shows its mg/100 ml), drink amount (ml), age range, medical conditions, weight + unit (kg/lb).
- On AJAX submit (`ajaxResponse`) it computes a recommended daily limit (age/condition based) and the caffeine in the entered drink (`amount_per_100ml * ml / 100`) and renders both inline. Nothing is stored.

## Notes
- Weight in lb is converted to kg (`* 0.45359237`) before use.
- `help_text` is output via `#markup` after `t()`; it is admin-only input and Drupal admin-filters the markup.
