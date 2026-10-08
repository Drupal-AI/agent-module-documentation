<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The widget API (`hook_jstwidget`), microformat markup, and the client engine

jstimer has no Drupal plugin type. Widgets are registered through a **hook**, `hook_jstwidget()`,
which each widget module implements and which `jstimer_get_widgets()` gathers via
`moduleHandler()->invokeAll('jstwidget')`.

## `hook_jstwidget()` contract

Return a `stdClass` with:

| Property | Purpose |
|---|---|
| `->name` | Machine name **and** the CSS class the engine matches (e.g. `jst_timer`, `jst_clock`). |
| `->label` | Human label (used by the legacy formatter shim). |
| `->js_name` | Fully-qualified JS constructor, e.g. `Drupal.jstimer.jst_timer` — instantiated in `Drupal.behaviors.jstimer`. |
| `->theme_function` | PHP function that renders the widget's microformat markup (e.g. `jst_timer_show`). |
| `->js_code` | The widget's JavaScript, concatenated into `timer.js`. |
| `->settings` | (optional) default formatter settings array. |

`jstimer_get_javascript()` builds, for every widget, `new <js_name>()` into the
`countdown_auto_attach([...])` array and appends `->js_code` to the file. So enabling a widget
module and re-saving settings (or reinstalling) is what makes its code appear in `timer.js`.

## The generated engine (`jstimer_get_javascript()` heredoc)

- `Drupal.behaviors.jstimer.attach` → `Drupal.jstimer.countdown_auto_attach([ new Widget(), … ])`.
- `countdown_auto_attach()` calls `.attach()` on each widget; each widget's `attach()` selects its
  elements, wraps each in an item object, and pushes items onto `Drupal.jstimer.timer_stack`.
- `Drupal.jstimer.timer_loop()` iterates the stack **backwards**, calling `item.update()`; an item
  returning `false` is spliced out. While the stack is non-empty it re-arms with
  `setTimeout('Drupal.jstimer.timer_loop()', 999)` — one shared ~1s loop for all timers/clocks.
- Utilities added to the browser: `LZ(x)` (zero-pad), and on `Date.prototype`:
  `jstimer_set_iso8601_date(string)` (regex ISO-8601 parser with timezone handling — throws
  `DatePatternFail` on bad input), `jstimer_get_moy()` (month abbr), `jstimer_get_dow()` (weekday
  abbr).

## Microformat markup

`theme_function`s emit a wrapper span with the widget class plus hidden child spans carrying the
parameters. `jst_timer_show()` (whitelist: `datetime, dir, format_txt, format_num, threshold,
complete, tc_redir, tc_redir_delay, tc_msg, interval, current_server_time`) produces e.g.:

```html
<span class="jst_timer">
  <span style="display:none" class="datetime">2026-12-25T00:00:00+00:00</span>
  <span style="display:none" class="dir">down</span>
  <span style="display:none" class="format_txt">%days% days + %hours%:%mins%:%secs%</span>
</span>
```

On the client, each item's `loadProps()` reads those hidden spans by class name into `this.props`.
An optional `<span class="no_js_txt">` provides fallback text for no-JS visitors.

## Adding your own widget

Implement `hook_jstwidget()` in a module that depends on `jstimer`, returning the `->name` (=CSS
selector class), `->js_name` constructor (define `Drupal.jstimer.<name> = function(){…}` with an
`attach()` that pushes items exposing an `update()` returning a boolean), and a `->theme_function`
that renders the wrapper span. Re-save the jstimer settings (or reinstall) to recompile `timer.js`.
The shipped `jst_timer` and `jst_clock` submodules are the two reference implementations.

## Legacy note

`jstimer.module` also declares a `jstimer` theme + `theme_jstimer()` (looks the widget up by name
and calls its `theme_function`) and loads `jstimer.field.inc.old`, a D7 `hook_field_formatter_*`
shim whose render calls are commented out. Neither is on the active D8+ render path — the working
formatter is the `JsTimerDefaultFormatter` plugin
([../fields/formatter.md](../fields/formatter.md)).
