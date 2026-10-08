# jQuery Countdown Timer — agent index

One block plugin that renders a jQuery-driven countdown to a target date. Depends on core `block`.
No config page (`configure` null), no permissions, no Drush, no plugin types. Provides a config
schema for the block settings.

- **The block plugin, its two settings, and how the target/font reach the browser** →
  [configure/block.md](configure/block.md)

Key facts:
- Block id `jquery_countdown_timer` (admin label "Countdown Timer"),
  `src/Plugin/Block/JqueryCountdownTimerBlock.php`.
- Settings: `countdown_datetime` (stored `Y-m-d H:i:s`, default "tomorrow") and `font_size`
  (int, default 28). Schema `block.settings.countdown_config`.
- `build()` outputs empty divs `#jquery-countdown-timer` / `#jquery-countdown-timer-note`, attaches
  library `jquery_countdown_timer/countdown.timer`, and sets
  `drupalSettings.countdown = { unixtimestamp: strtotime(datetime), fontsize }`.
- Library deps: `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once` + module CSS/JS.
- Configured entirely via Block layout (`/admin/structure/block`).
