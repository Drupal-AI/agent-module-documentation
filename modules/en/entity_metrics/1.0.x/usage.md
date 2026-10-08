<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Metrics records node page views and media file downloads for entities and can enrich each event with an approximate visitor location read from a local MaxMind GeoLite2-City database.

---

Entity Metrics stores every recorded page view and file download as a row in its own `entity_metrics_data` table, keyed by entity type (`node` or `media`), entity id, timestamp, session id and client IP. A JavaScript behaviour POSTs to a recording endpoint on each canonical node view, and `hook_file_download()` records media downloads served through the `fedora` stream wrapper. The recording and count endpoints validate the entity type/id, verify the caller can view the entity, and rate-limit each IP to twenty events per rolling minute. Optionally, on cron or via a Drush command, the module reads a local GeoLite2-City `.mmdb` file (managed by the `geoip_autoupdate` dependency) to resolve each event's IP to a country/region/city and coordinates, storing de-duplicated locations in `entity_metrics_regions`; no visitor IP is ever sent to a remote API, and resolved IPs are cleared after enrichment. Two blocks surface the data: a per-node "view count" block (last-month and total counts fetched via AJAX) and a Leaflet map block that plots geolocated visits for a collection's member nodes.

---

- Record how many times each node is viewed on your Drupal site.
- Record how many times media files are downloaded (via the `fedora` stream wrapper).
- Display a per-node "Last month" and "Total" view-count block using the Node History block.
- Show a Leaflet map of where visits to a collection's member nodes came from using the Metrics Map block.
- Track engagement/popularity of content without a third-party analytics service.
- Enrich stored visit events with approximate country, region, city and coordinates.
- Keep all geolocation local: read a MaxMind GeoLite2-City `.mmdb` file, never call a remote geo API.
- Exclude staff or internal traffic by setting a cookie name whose "1" value flags rows to filter out.
- Rate-limit visit recording to twenty events per client IP per minute to blunt spam/inflation.
- Backfill historical events with geolocation from a CLI job using `drush entity-metrics:geolocate`.
- Process a bounded batch of pending events on each Drupal cron run.
- Resume an interrupted geolocation backfill automatically from per-event status.
- Retry previously unresolved public IPs after installing a newer database with `--retry-unknown`.
- Download or refresh the local GeoLite2 database with `drush entity-metrics:geoip-update`.
- Tune how many events are enriched per cron/CLI batch (1–10000, default 500).
- Point the module at `private://GeoLite2-City.mmdb` or an absolute local `.mmdb` path.
- Store de-duplicated visit locations so many events share one region row.
- Expose per-entity view counts to an entity's viewers via the `/entity-metrics/{type}/{id}` JSON endpoint.
- Cache the map block against a `entity_metrics_regions` cache tag so new locations invalidate it.
- Attribute MaxMind GeoLite2 data automatically in the page footer when geolocation is enabled.
- Support both IPv4 and IPv6 visitor addresses.
- Feed downstream aggregate/analytics reports that read the `entity_metrics_data` table.
- Run entirely on Drupal 10 or 11 with the `node` and `geoip_autoupdate` modules.
