<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widgets, render element & webform element

The module implements existing core/Webform plugin types (it defines no plugin type of its own).

## Field widgets (Manage form display)
| Widget class | `field_widget` for | Field types |
|---|---|---|
| `Plugin\Field\FieldWidget\BootstrapDateTimeWidget` | Date/time | `datetime` |
| `Plugin\Field\FieldWidget\BootstrapDateRangeWidget` | Date-range | `daterange` |

Per-instance settings (in `settingsForm()`):
- `wrapper_class`, `column_size_class` — Bootstrap layout classes around the input.
- `date_date_format` — display/format string.
- `date_date_min`, `date_date_max` — selectable date bounds.
- `disabled_hours` — hours to block.
- `disable_days` — weekdays to disable (e.g. weekends).
- `exclude_date` — specific dates to disable (comma-separated, e.g. `03/07/2018`).

Pick the widget on *Manage form display* for a date field; open the gear icon to set the above.

## Render element
- `Element\BootstrapDateTime` — form element type `bootstrap_datetime_picker` (theme hook
  `input__bootstrap_datetime_picker`, registered via `hook_theme`). Use in a custom form:
  ```php
  $form['when'] = [
    '#type' => 'bootstrap_datetime_picker',
    '#title' => $this->t('When'),
  ];
  ```

## Webform element
- `Plugin\WebformElement\BootstrapDateTime` — makes the picker available as a Webform element (requires
  the `webform` module). Add it via the Webform element browser.

All three render the Tempus Dominus picker, passing the merged global + per-instance options to the
attached `datetimepicker` (or `datetimepicker-cdn`) library via `drupalSettings`.
