<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Countdown (countdown) — agent index

Provides one block plugin, `countdown_block`, that counts down to (or up from) a
configured target date/time. Each placed block can render **server-side** (static
PHP, updates on refresh) or **real-time** in the browser via a bundled JS timer
library. No routes, no permissions of its own, no services, no drush — everything
is configured on the block instance (needs core `administer blocks`).

- Depends on core `block`. Core requirement `^8.8 || ^9 || ^10 || ^11`.
- `configure`: none (no settings form/route). Config lives in the block instance,
  validated by schema `block.settings.countdown_block`, so it exports with `drush cex`.

Solution docs:
- **Place & configure a countdown block, all settings, completion actions** → [blocks/countdown.md](blocks/countdown.md)
- **The `countdown` theme hook, template, JS libraries, drupalSettings, and JS API** → [theme/countdown.md](theme/countdown.md)

Key facts:
- Block plugin id `countdown_block` → class `Drupal\countdown\Plugin\Block\Countdown` (admin_label "Countdown").
- Config schema key: `block.settings.countdown_block` (~25 mapped settings).
- Two render modes via `render_mode`: `static` (theme + PHP math) and `realtime` (JS).
- Theme hook `countdown` (`templates/countdown.html.twig`, `template_preprocess_countdown()`).
- Libraries: `countdown/timer`, `countdown/integration`, `countdown/block` (legacy static), `countdown/admin` (form UI).
- JS API namespace: `Drupal.countdown` (`getTimer`, `controlTimer`, `getAllTimers`, `isElapsedMode`).
- Block caching is disabled (`getCacheMaxAge()` returns 0; render arrays set `max-age => 0`).
- `.install`: `hook_requirements` (runtime block-count status), `hook_install` (welcome message),
  `countdown_update_8101` (migrates legacy `url`→`event_link`, backfills new settings).
- `hook_help` on `help.page.countdown`. `.info.yml` reports legacy `version: '8.x-1.11'`.
