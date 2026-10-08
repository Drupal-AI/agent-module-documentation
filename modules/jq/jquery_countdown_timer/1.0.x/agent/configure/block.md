# Configure — Countdown Timer block

Block plugin `jquery_countdown_timer` (`JqueryCountdownTimerBlock extends BlockBase`). No global
settings; everything is per-block-instance configuration set in Block layout.

## Placing & configuring
`/admin/structure/block` → **Place block** → "Countdown Timer". The block form (`blockForm`) has:
- **Timer date** (`jquery_countdown_timer_date`) — a `datetime` element, required, year range
  `2016:+50`, default value "tomorrow". Saved to config `countdown_datetime` as `Y-m-d H:i:s`.
- **Timer font size** (`jquery_countdown_timer_font_size`) — a required `number`, default 28.
  Saved to config `font_size`.

`defaultConfiguration()` returns `countdown_datetime` = tomorrow (`Y-m-d H:i:s`) and `font_size` = 28.

## Config schema
`block.settings.countdown_config` (`config/schema/jquery_countdown_timer.schema.yml`):
```yaml
countdown_datetime: text   # target date/time
font_size: text            # font size
```

## Render output
`build()` returns:
- Markup: `<div id="jquery-countdown-timer"></div><div id="jquery-countdown-timer-note"></div>`
  (empty containers the JS fills).
- `#attached['library'][] = 'jquery_countdown_timer/countdown.timer'`.
- `#attached['drupalSettings']['countdown'] = ['unixtimestamp' => strtotime($countdown_datetime),
  'fontsize' => $font_size]`.

The JS (`js/jquery_countdown_timer.js` + `_init.js`) reads `drupalSettings.countdown` and animates
the countdown client-side. Note the single `countdown` drupalSettings key is not namespaced per
block instance, so placing multiple instances on one page shares one settings payload — the last
block's values win for pages rendering more than one instance.
