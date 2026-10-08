<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Countdown provides a single configurable block that counts down to — or up from — a chosen date/time, showing days, hours, minutes and seconds, either rendered server-side or as a live JavaScript timer.

---

The module is one block plugin, `countdown_block` (`Drupal\countdown\Plugin\Block\Countdown`), plus a bundled JS timer engine (`countdown/timer`) and its Drupal integration layer (`countdown/integration`). Every option lives on the placed block instance and is validated by config schema `block.settings.countdown_block`, so a countdown exports and imports with the rest of a site's configuration and several can coexist with different targets. A `render_mode` switch chooses between `static` (server-side PHP math, updates on refresh, works without JavaScript, with a `<noscript>` fallback) and `realtime` (a client-side timer with selectable precision from minutes to milliseconds, verbose/compact/custom display styles, timezone handling, drift compensation, and count-up as well as count-down). When the timer reaches zero a configurable completion action fires — do nothing, hide, show a message, redirect, reload, switch to elapsed time, or dispatch a custom JavaScript event — and a `Drupal.countdown` JS API (`getTimer`, `controlTimer`, `getAllTimers`) plus `countdown:*` events let other code react. The only dependency is core `block`; configuring a block needs the core `administer blocks` permission, and blocks are rendered uncached so the time is always current. Core support is a wide `^8.8 || ^9 || ^10 || ^11`.

---

- Count down to a product launch or release.
- Show days remaining until a conference or event.
- Count up from a project's start or launch date ("days since").
- Display a registration or submission deadline with a live timer.
- Place a countdown in any block region and target it with block visibility rules.
- Show a lightweight server-side countdown on SEO-critical pages.
- Run a high-precision millisecond timer for a special effect.
- Show a completion message when the timer hits zero.
- Redirect visitors to an event page the moment a countdown ends.
- Auto-reload a page when a sale or window opens.
- Switch automatically to elapsed time after an event starts.
- Trigger a custom JavaScript event (e.g. open a modal) on completion.
- Link the event name to more information (internal path or external URL).
- Format the timer with a custom token template like "DD days, HH:MM:SS".
- Show a compact "3d 2h 1m" or verbose "3 days, 2 hours" display.
- Set and optionally display the event's timezone.
- Run several independent countdowns on one page.
- Export a configured countdown with site configuration.
- Drive or pause a timer programmatically via the JS API.
- Build urgency for a limited-time offer or donation appeal.
- Support a site still on Drupal 8.8 or 9.
- Add a "time since launch" milestone counter.
