<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Countdown block (`countdown_block`)

Class `Drupal\countdown\Plugin\Block\Countdown` (`src/Plugin/Block/Countdown.php`),
`@Block(id = "countdown_block", admin_label = @Translation("Countdown"))`. Injects
`date.formatter`. `getCacheMaxAge()` returns `0` (never cached).

Place it at `/admin/structure/block` ("Place block" → search "Countdown"). All
options live on the block instance and are validated by config schema
`block.settings.countdown_block`.

## Render modes (`render_mode`)

- `static` — server-side. `build()` → `buildStaticCountdown()`: computes days/hours/
  minutes/seconds in PHP (`formatPlural`), renders `#theme => 'countdown'` with
  `#render_mode => 'static'`, attaches `countdown/block`. `accuracy` sets the smallest
  unit shown. Updates only on page refresh; works without JS.
- `realtime` — client-side. `build()` → `buildRealtimeCountdown()`: emits a
  `drupalSettings.countdown.countdown_<block_id>` config object and attaches
  `countdown/timer` + `countdown/integration`; the JS ticks in the visitor's browser.
  A `<noscript>` fallback (`generateFallbackContent()`, `dateFormatter->formatInterval`)
  is included. Old/invalid blocks fall back to `static`.

## Settings (all keys under `settings:` on the block config entity)

`defaultConfiguration()` defaults shown. `getConfigValue()` supplies defaults and
migrates legacy `url`→`event_link` and `display_format`→`display_style`.

| Key | Default | Mode | Meaning |
|-----|---------|------|---------|
| `event_name` | `''` | both | Optional label. Rendered `Html::escape`d (or as a link when `event_link` set). |
| `event_link` | `''` | both | Optional URL for the label. `<front>`, internal `/node/123`, or external. Validated in `blockValidate()`. |
| `render_mode` | `realtime` | — | `static` or `realtime` (see above). |
| `accuracy` | `s` | static | Smallest unit: `d`, `h`, `m`, `s`. |
| `timer_mode` | `countdown` | realtime | `countdown` (to future) or `countup` (from past). |
| `precision` | `seconds` | realtime | `minutes`/`seconds`/`tenths`/`hundredths`/`milliseconds` — display + tick rate. |
| `display_style` | `auto` | realtime | `auto`/`verbose`/`compact`/`custom`. |
| `custom_template` | `''` | realtime | Token template (used when `display_style=custom`; required then). Tokens: `DD D HH H MM M SS S mmm mm m`. |
| `separator` | `', '` | realtime | Text between units (verbose/compact). |
| `show_zero` | `false` | realtime | Show units whose value is 0. |
| `max_units` | `4` | realtime | Max units shown (1–7). |
| `offset` | `0` | realtime | Start offset in seconds. |
| `auto_start` | `true` | realtime | Start timer on load. |
| `drift_compensation` | `true` | realtime | Correct long-run timer drift. |
| `enable_events` | `false` | realtime | Emit the `countdown:*` JS events (see theme doc). |
| `debug_mode` | `false` | realtime | Console logging. |
| `timezone` | server tz | realtime | PHP tz id (`TimeZoneFormHelper::getOptionsList()`). |
| `show_timezone` | `false` | realtime | Append tz abbreviation to the display. |
| `timestamp` | `time()` | both | Target as a Unix timestamp. Form collects month/day/year + hour/min/sec and `mktime()`s it in `blockSubmit()`. |
| `completion_action` | `none` | both | See table below. |
| `completion_message` | `''` | both | Shown when action=`message`. |
| `completion_url` | `''` | both | Target when action=`redirect`. |
| `completion_event_name` | `countdown:custom-complete` | both | JS event fired when action=`event`. Validated `^[a-zA-Z][a-zA-Z0-9:_\-\.]*$`. |
| `completion_event_data` | `''` | both | Optional JSON payload for the custom event (JSON-validated). |
| `display_format` | `''` | legacy | Deprecated; mapped to `display_style` for old blocks. |

## Completion actions (`completion_action`)

Applied when a countdown reaches zero. In `static` mode, handled by
`handleStaticCompletion()` (server render); in `realtime`, by the integration JS.

| Value | Behavior |
|-------|----------|
| `none` | Stop at zero (shows 00:00:00 / zero units). |
| `hide` | Static: empty markup. Realtime: fade out + `display:none`. |
| `message` | Show `completion_message` (escaped). Static: `<div class="countdown-completion-message">`. Realtime: `escapeHtml` into the display. |
| `redirect` | Static: `<meta http-equiv="refresh" content="1;url=…">`. Realtime: `window.location.href`. URL from `completion_url`. |
| `reload` | Static: meta refresh. Realtime: `window.location.reload()`. |
| `elapsed` | Switch to counting up from the target time. |
| `event` | Fire a `CustomEvent` named `completion_event_name` with `completion_event_data` as `detail`. |

`completion_action` is hidden in the form when `timer_mode=countup`.

## Configure via PHP / drush

The block is a standard block config entity; set values under `settings`:

```php
$block = \Drupal\block\Entity\Block::load('countdown'); // your block id
$settings = $block->get('settings');
$settings['event_name'] = 'Conference';
$settings['render_mode'] = 'realtime';
$settings['timer_mode'] = 'countdown';
$settings['timestamp'] = strtotime('2026-12-31 09:00:00');
$settings['display_style'] = 'compact';
$settings['completion_action'] = 'message';
$settings['completion_message'] = 'It has started!';
$block->set('settings', $settings)->save();
```

Because config lives on the block instance, several countdowns can run with
different targets, and each exports with `drush config:export`. Config schema:
`config/schema/countdown.schema.yml` (`block.settings.countdown_block`).
