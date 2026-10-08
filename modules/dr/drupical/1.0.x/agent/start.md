<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupical — agent index

Displays upcoming Drupal community events (DrupalCons, camps, meetups, trainings) fetched
from the Drupal.org events API. Ships **one block** plugin `events_block` (admin label
"Events Feed"), gated by the `access events` permission. No admin settings form: the three
config keys live only in `drupical.settings`. Requires no non-core modules. All `src/`
classes are marked `@internal`.

Key facts:
- Block plugin id: `events_block` (`Drupal\drupical\Plugin\Block\EventsBlock`).
- Permission: `access events` (gates the block and the load-more route).
- Config object: `drupical.settings` → `max_age` (86400), `cron_interval` (21600), `limit` (5).
- AJAX route: `drupical.load_more` at `/events-feed/load-more`.
- Services: `drupical.fetcher` (EventsFetcher), `drupical.renderer` (EventsRenderer).
- Theme hooks: `drupical`, `drupical_item`. Cron refreshes the event cache.

- **Configure & place the feed** (block placement, the three settings keys, permission,
  cron behavior, event cache) → [configure/settings-and-block.md](configure/settings-and-block.md)
- **Fetch/render events from code** (the two services, the `Event` object, event-type map)
  → [api/services.md](api/services.md)
