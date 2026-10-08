<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jst_timer` countdown/count-up widget

Source: `widgets/jst_timer.module`. Enable with `drush en jstimer jst_timer -y`.

## Registration

`jst_timer_jstwidget()` returns a descriptor with `name='jst_timer'`, `label='Countdown timer'`,
`js_name='Drupal.jstimer.jst_timer'`, `theme_function='jst_timer_show'`, default settings
`['dir'=>'down','format_txt'=>'']`, and a `->js_code` heredoc. The parent's build pipeline
concatenates that code into `timer.js` and instantiates `new Drupal.jstimer.jst_timer()` in the
`Drupal.behaviors.jstimer` bootstrap.

## Microformat markup (`jst_timer_show()`)

Emits `<span class="jst_timer">` with hidden child spans for whichever of these keys are set:
`datetime, dir, format_txt, format_num, threshold, complete, tc_redir, tc_redir_delay, tc_msg,
interval, current_server_time` (plus optional leading `no_js_txt` fallback text). The parent's
`JsTimerDefaultFormatter` calls this with `datetime` (ISO string from the date field), `dir`, and
`format_txt`.

## Client behaviour (`Drupal.jstimer.jst_timer_item`)

- `attach()` runs `jQuery(".jst_timer").each(...)`, builds an item per span, and (if parse
  succeeds) pushes it onto `Drupal.jstimer.timer_stack`.
- `loadProps()` reads each hidden span (by class) into `this.props` (defaults: `dir='down'`,
  `format_num=0`, message/highlight/redirect pulled from config at build time). If `format_txt` is
  set it becomes the output format, else preset `format_num` from `Drupal.jstimer.formats`, else
  preset 0.
- `parse_microformat()`: if `interval` is set, target = now + interval seconds; else parse
  `datetime` via `Date.prototype.jstimer_set_iso8601_date` (throws `NoDate` if empty). An optional
  `current_server_time` span adjusts the target for client/server clock skew.
- `update()` (called each ~1s by the shared loop): computes `get_duration(now, target)` and
  `String.replace`s the format tokens, then sets the element HTML via jQuery `.html()`.

## Format tokens

Static (replaced once): `%day%`, `%month%`, `%year%`, `%moy%` (Jan…Dec), `%dow%` (Sun…Sat).
Live (each tick): `%years%`, `%ydays%`, `%days%` (total days), `%hours%`, `%mins%`, `%secs%`
(zero-padded via `LZ`), `%hours_nopad%`, `%mins_nopad%`, `%secs_nopad%`, `%sign%` (`-`/`+`),
`%months%`, `%tot_months%`, `%tot_hours%`, `%tot_mins%`, `%tot_secs%`. Unit-suffixed forms like
`%days% days`, `%hours% hours`, `%mins% minutes`, `%secs% seconds`, `%years% years`,
`%months% months` are run through `Drupal.formatPlural` for correct singular/plural (in a
try/catch, since `formatPlural` can be brittle). Duration math lives in `get_duration()`
(calendar-month aware; `dur.diff` in seconds, `dur.sign` for before/after target).

## Completion behaviour (countdown only, `dir='down'` and target passed)

- **Complete message**: if set, the element HTML is replaced with `timer_complete_message`.
- **Alert**: if `tc_msg` set, a JS `alert()` fires once (config: *Timer complete alert message* —
  admin help says "Do NOT use HTML").
- **Redirect**: if `tc_redir` set and the delay elapsed, `window.location = tc_redir` — or
  `window.location.reload(true)` when the value contains `<reload>`. Then `update()` returns
  `false` to drop the item.

## Proximity styling

When `dir='down'` and `jstimer_highlight_down='1'` and the remaining time ≤ `threshold*60` seconds,
the output is wrapped as `<span {highlight[0]}={highlight[1]}>…</span>` (highlight parsed from the
`jstimer_highlight` config, e.g. `style="color:red"`). For `dir='up'` the equivalent uses
`jstimer_highlight_up` and latches once past the threshold.

## Admin settings (added to the jstimer form)

`jst_timer_form_jstimer_admin_settings_alter()` adds the **Timer widget** fieldset:

- **Timer formats** (`jst_timer_formats`, `#tree`): a textarea per preset (index 0 = global
  default) plus a blank one to add another; blanks are dropped on save. Fallback presets when
  empty are the four `<em>(%dow% %moy%%day%)</em>…` / `%days% shopping days left` strings.
- **Proximity styling**: `jstimer_highlight` (CSS statement), `jstimer_highlight_threshold`
  (minutes), `jstimer_highlight_down`, `jstimer_highlight_up`.
- **Timer complete redirect**: `jst_timer_redirect_path` (URL or `<reload>`),
  `jst_timer_redirect_delay` (seconds).
- **Timer complete message**: `jst_timer_complete_message` (HTML replacing the timer).
- **Timer complete alert message**: `jst_timer_complete_alert_message` (plain text).

`jst_timer_admin_settings_submit()` (registered first via `array_unshift`) writes these into
`jstimer.settings` before `timer.js` is rebuilt. Config keys are defined in the parent —
[../../../../8.x-1.x/agent/config/settings.md](../../../../8.x-1.x/agent/config/settings.md).

## Notes

- Values embedded into the generated JS are passed through the parent's
  `jstimer_clean_for_javascript()` (newlines→`<br/>`, strip CR, `'`→`"`); `jst_timer_redirect_path`
  is embedded raw. All of these are `administer site configuration` settings.
- `translate_replacements()` exists only to expose the plural strings to the localization system
  (the JS file itself isn't scanned by localize.drupal.org).
- The format-template output is written to the DOM with jQuery `.html()`, so format templates are
  intentionally HTML (the module ships HTML defaults like `<em>…</em>`).
