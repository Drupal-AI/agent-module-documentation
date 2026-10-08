<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `datetime` field formatter (`JsTimerDefaultFormatter`)

`src/Plugin/Field/FieldFormatter/JsTimerDefaultFormatter.php`

```php
@FieldFormatter(
  id = "jstimer_jst_timer",
  label = @Translation("JsTimer - Timer"),
  field_types = { "datetime" }
)
```

- Applies to core **`datetime`** fields only (not `daterange`, not the legacy `date`/`datestamp`
  types — those were the D7 formatter's targets, now in the unused `jstimer.field.inc.old`).
- Extends core `FormatterBase`; uses `StringTranslationTrait`.
- Requires the **`jst_timer`** submodule to be enabled — `viewElements()` calls the global
  `jst_timer_show()` function, which only exists when `widgets/jst_timer.module` is loaded.

## Settings (`defaultSettings()`)

| Setting | Default | Meaning |
|---|---|---|
| `dir` | `down` | Countdown (`down`) or count-up (`up`). Select in `settingsForm()`. |
| `format_txt` | `''` | Optional per-display format-template string (overrides the global format). Textfield. |

`settingsSummary()` just appends *"Displaying a countdown timer"*.

## How it renders (`viewElements()`)

For each item with a non-empty `$item->date` (a `DrupalDateTime`):

1. If the field's `datetime_type` is `date` (date-only, no time), it fills in the current time via
   `DrupalDateTime::setDefaultDateTime($date)`.
2. `dateToWidget($date->getTimestamp(), 'jst_timer', $this->getSettings())` converts the timestamp
   to an ISO-8601 string with `date('c', $ts)` and builds
   `['widget_name' => 'jst_timer', 'widget_args' => ['datetime' => <iso>, 'dir' => …, 'format_txt' => …]]`
   (only non-empty settings are copied in).
3. `jst_timer_show($args['widget_args'])` (defined in `widgets/jst_timer.module`) returns the
   microformat markup — a `<span class="jst_timer">` wrapping hidden `<span class="datetime|dir|
   format_txt">` children. That string is assigned to `$elements[$delta]['#markup']`.

The client-side engine (see [../api/widgets.md](../api/widgets.md)) then finds the
`.jst_timer` span, reads the hidden spans, and animates the countdown/count-up once per second.

## Enable it on a field

UI: create/choose a **Date** (`datetime`) field on a bundle →
*Structure → (bundle) → Manage display* → set that field's format to **JsTimer - Timer** → gear
icon → pick direction and (optionally) a format template.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_event_date.type jstimer_jst_timer -y
drush cr
```

```yaml
# core.entity_view_display.node.article.default
content:
  field_event_date:
    type: jstimer_jst_timer
    label: above
    settings:
      dir: down
      format_txt: '%days% days + %hours%:%mins%:%secs%'
```

## Notes

- `format_txt` and `dir` are **display configuration**, set by users with Field-UI /
  "administer <entity> display" access; the emitted `datetime` value is a strict ISO string from
  `date('c', …)`.
- The format tokens (`%days%`, `%hours%`, `%dow%`, `%moy%`, proximity styling, completion
  behaviour, etc.) are all interpreted by the `jst_timer` widget — documented in
  [../../modules/jst_timer/8.x-1.x/agent/widgets/timer.md](../../modules/jst_timer/8.x-1.x/agent/widgets/timer.md).
- There is no formatter for the clock; a clock is placed as raw `<div class="jst_clock"></div>`
  markup, not through a field.
