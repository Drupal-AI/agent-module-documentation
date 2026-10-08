<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The datetime "Reset" button

## Install & enable

```bash
composer require drupal/datetime_reset
drush en datetime_reset -y
```

Only dependency is core **`datetime`**. No sub-modules, no permissions, no Drush commands, no
routes. Everything lives in `datetime_reset.module`.

## Enable it on a field

The feature is a **third-party widget setting**, so it is turned on per field, per form display:

1. *Structure → (Content type / bundle) → Manage form display*.
2. For a Datetime field (Date, Date/Time, or Date range), click the **gear** on its widget row.
3. Tick **"Reset button"** ("This will display a reset button next to the date and time inputs
   allowing to empty their values.").
4. **Update**, then **Save**.

The gear checkbox only appears when the field's widget is a core Datetime widget — precisely when
the widget object `instanceof Drupal\datetime\Plugin\Field\FieldWidget\DateTimeWidgetBase`
(`datetime_reset_field_widget_third_party_settings_form()`). The widget summary line then reads
**"Display reset button."** or **"No reset button."**
(`datetime_reset_field_widget_settings_summary_alter()`).

### Config / schema

The setting is stored as a boolean third-party widget setting under key
`datetime_reset` → `reset`, exported inside the form-display config
(`core.entity_form_display.<entity>.<bundle>.<mode>`). Schema is
`field.widget.third_party.datetime_reset` in `config/schema/datetime_reset.schema.yml`:

```yaml
field.widget.third_party.datetime_reset:
  type: mapping
  label: DateTime Reset
  mapping:
    reset:
      type: boolean
      label: 'Reset'
```

Example fragment inside a form display's widget config:

```yaml
third_party_settings:
  datetime_reset:
    reset: true
```

## How the button is added (render side)

`datetime_reset_field_widget_single_element_form_alter()` reads
`$widget->getThirdPartySetting('datetime_reset', 'reset')`. When true it flags the inner form
elements so the process callback will act on them:

- Normal case: sets `$element['value']['#datetime_reset']['reset'] = TRUE`, and also
  `$element['end_value']` when present (Date **range** fields).
- **SmartDate compatibility**: if `$element['time_wrapper']` exists, it flags
  `time_wrapper['value']` and (if present) `time_wrapper['end_value']` instead.

`datetime_reset_element_info_alter()` appends `_datetime_reset_process_element` to the `datetime`
element type's `#process`. That callback, when `#datetime_reset['reset']` is set, injects a button:

```php
$element['reset_button'] = [
  '#type' => 'button',
  '#value' => t('Reset'),
  '#name' => 'reset_' . $element['#id'],
  '#attributes' => ['class' => ['datetime-reset-button']],
  '#ajax' => ['event' => 'click'],
];
$element['#attached']['library'][] = 'datetime_reset/datetime_reset';
```

So each reset button's `#name` is `reset_` + the datetime element's DOM `#id`, and it carries the
CSS class `datetime-reset-button`. The library `datetime_reset/datetime_reset`
(`datetime_reset.libraries.yml`) loads `js/datetime_reset.js` and depends on `core/drupal.ajax`.

## How the button behaves (client side)

`js/datetime_reset.js` defines `Drupal.behaviors.dateTimeReset`. Using `once('datetime_reset', …)`
it binds a click listener to every `.datetime-reset-button` (capture phase). On click it:

1. `event.preventDefault()` + `event.stopPropagation()` — the form is **not** submitted and the
   `#ajax` round-trip is suppressed.
2. Recovers the container id: `button.name.substr(6)` strips the `reset_` prefix, giving the
   datetime element's `#id`.
3. `document.getElementById(containerId)`, then within it clears
   `input[type="date"].value = ''` and `input[type="time"].value = ''`.

Net effect: the visible date and time inputs of that one widget are emptied in the browser. Nothing
is persisted until the editor saves the form, and normal core datetime field
validation/required-ness applies at save time.

## Scope & limits

- Targets **core Datetime widgets only** (anything extending `DateTimeWidgetBase`) — not plain text
  or other field types.
- Clears only `input[type="date"]` / `input[type="time"]` inside the widget container; widgets that
  render dates differently (custom markup without those input types) will not be cleared.
- Purely a UX convenience — no server-side action, no route, no access change.
