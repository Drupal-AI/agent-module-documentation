<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hook, libraries, and JS API

## Theme hook `countdown`

Defined in `countdown_theme()` (`countdown.module`), template
`templates/countdown.html.twig`, preprocess `template_preprocess_countdown()`.

Variables: `accuracy`, `event_link`, `event_name` (already formatted/escaped, with
"until …" / "since …" direction), `days_left`, `hrs_left`, `min_left`, `secs_left`,
`title`, `render_mode` (default `static`), `block_id`. Preprocess adds wrapper
classes `countdown-wrapper` and `countdown-<render_mode>`.

The template has two branches: `static` prints the pre-computed unit strings
according to `accuracy`; otherwise it prints a `.countdown-placeholder`
("Loading…") inside `#countdown-display-<block_id>` that the JS replaces, plus a
`.countdown-event-info` block when an event name is set.

## Libraries (`countdown.libraries.yml`)

| Library | Files | Depends on | Used for |
|---------|-------|------------|----------|
| `countdown/timer` | `js/lib/countdown.js` | — | Bundled `CountdownTimer` engine (no external deps). |
| `countdown/integration` | `js/countdown.integration.js` | jquery, jquery.once, drupal, drupalSettings, `countdown/timer` | Drupal behavior: reads settings, drives timers, completion actions, events. |
| `countdown/block` | `js/lib/countdown.js` | core/drupal | Legacy library attached by `static` render mode. |
| `countdown/admin` | `js/countdown.admin.js`, `css/countdown.admin.css` | jquery, jquery.once, drupal | Block configuration form UI only. |

The timer engine writes output with `element.textContent` (not `innerHTML`), so
formatted time / custom templates are inserted as text.

## drupalSettings

- Realtime: `drupalSettings.countdown['countdown_' + block_id]` = the block's JS
  config (render_mode, timer_mode, timestamp, precision, display_style/format,
  custom_template, separator/show_zero/max_units, offset, auto_start,
  drift_compensation, timezone/show_timezone, completion_* , enable_events, debug_mode).
- Static: `drupalSettings.countdown.block.accuracy`.

## JavaScript API (`Drupal.countdown`)

Public helpers exposed by the integration layer:

```js
var timer   = Drupal.countdown.getTimer(blockId);
var timers  = Drupal.countdown.getAllTimers();
var elapsed = Drupal.countdown.isElapsedMode(blockId);
Drupal.countdown.controlTimer(blockId, 'start');  // start|pause|resume|stop|reset
```

When `enable_events` is on, the container element (`#countdown-<block_id>`)
dispatches these events (jQuery/DOM):
`countdown:start`, `countdown:pause`, `countdown:resume`, `countdown:stop`,
`countdown:tick`, `countdown:complete`, `countdown:elapsed`, and (for the `event`
completion action) the configured `completion_event_name`
(default `countdown:custom-complete`).

```js
$('#countdown-' + blockId).on('countdown:complete', function (e, time, timer) { /* … */ });
```
