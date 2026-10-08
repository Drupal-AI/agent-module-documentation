<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupical fetches upcoming Drupal community events from the official Drupal.org events API and displays them in an "Events Feed" block you can place anywhere on your site or on the admin dashboard.

---

Drupical provides a single block plugin, `events_block` (admin label "Events Feed"), that renders a list of upcoming Drupal community events — DrupalCons, camps, meetups, trainings and more — pulled from the Drupal.org events API (`https://www.drupal.org/api-d7/node.json?type=event`). The `EventsFetcher` service walks the paged feed until it hits the first already-ended event, parses each item into an immutable `Event` value object (id, title, url, start/end dates, location, type, featured flag), sorts them with DrupalCon "featured" events first and then by soonest start date, and caches the result in an expirable key/value store for `max_age` seconds (default 86400). A `hook_cron` implementation refreshes that cache every `cron_interval` seconds (default 21600). The block shows `limit` events (default 5) and an AJAX "Load More" button backed by the `/events-feed/load-more` route and `EventsController`. Access to the block and the AJAX route is gated by the `access events` permission. The module has no admin settings form: the three settings (`max_age`, `cron_interval`, `limit`) live only in the `drupical.settings` config object, and the outbound links (organize, DrupalCon, camps, add-event) are hard-coded service parameters. It requires no modules outside core and pairs well with the Dashboard module used by Drupal CMS.

---

- Show upcoming Drupal community events on the administrative dashboard so site admins see them at login.
- Embed a live list of DrupalCons, DrupalCamps, meetups and trainings on a public page of your Drupal site.
- Keep a Drupal community/user-group site's homepage automatically populated with the next global events.
- Surface featured DrupalCon events at the top of an events list without manual curation.
- Give editors an at-a-glance events widget without building a View or an event content type.
- Let visitors browse more events via an AJAX "Load More" button instead of paging reloads.
- Cache external event data so the Drupal.org API is only hit periodically, not on every page load.
- Refresh event data automatically on cron at a configurable interval.
- Restrict who can see the events feed by granting the `access events` permission to specific roles.
- Display each event's location (city + country, or "Online/Virtual") resolved from the feed.
- Provide a low-maintenance "what's happening in Drupal" panel for intranets or team dashboards.
- Add a community-events sidebar block to an Olivero or Claro-themed site.
- Tune how many events show at once by editing the `limit` config key.
- Lengthen or shorten how long event data is cached via the `max_age` config key.
- Change how often cron re-fetches events via the `cron_interval` config key.
- Theme the events list or a single event by overriding the `drupical` / `drupical_item` Twig templates.
- Call the `drupical.fetcher` service from custom code to get parsed upcoming `Event` objects.
- Render an events feed programmatically from a controller or block via the `drupical.renderer` service.
- Show events on a Drupal CMS site using the recommended Dashboard integration.
- Provide a starting point for a customised community-events integration built on Drupal.org's API.
- Give new Drupal site owners a friendly "explore the community" element out of the box.
