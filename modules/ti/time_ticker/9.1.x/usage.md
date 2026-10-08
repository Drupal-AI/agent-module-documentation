<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Time Ticker shows a live-updating clock, formatted for an admin-selected timezone, in a Drupal block.

---

The module stores a single timezone in `time_ticker.settings` (configured at `/admin/config/regional/time-ticker`, permission `administer blocks`). A `TimeService` computes the current time for that timezone and formats it as `jS M Y - h:i:s A`. The provided block renders the clock, and a small JavaScript library polls the AJAX endpoint `/time_ticker/ajax` (route `time_ticker.time`, permission `access content`) which returns the formatted string as JSON so the displayed time advances without a page reload.

Setup is: enable the module, set the timezone on the settings form, then place the Time Ticker block in a region via Block layout. The AJAX endpoint is read-only and returns only the formatted current time — no user or system data. Note the settings form is gated by `administer blocks` rather than a regional-config permission, and the timezone offset calculation in `TimeService::getTime()` is computed but then overwritten by a plain formatted `$current_time`, so the effective output reflects the server clock formatting.

---
- Enable the module and place the Time Ticker block in a region.
- Set the display timezone at `/admin/config/regional/time-ticker`.
- Show a live clock in the header or footer of the site.
- Display the current date alongside the time for visitors.
- Refresh the time client-side via the `/time_ticker/ajax` endpoint.
- Present time in a chosen timezone regardless of server timezone.
- Add a ticking clock to an intranet or dashboard page.
- Give editors a quick visual confirmation of the site's regional time.
- Use the block on multiple pages by placing it in a global region.
- Restrict who can change the timezone via the `administer blocks` permission.
- Theme the clock output with the module's Twig template.
- Poll the JSON endpoint from custom JS if you need the value elsewhere.
- Show a formatted `jS M Y - h:i:s A` timestamp to end users.
- Provide a lightweight clock without third-party JS libraries.
- Localise the displayed time for a regional audience.
- Combine with other regional settings for a consistent time display.
