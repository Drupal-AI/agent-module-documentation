Radioactivity provides "energy" fields that track content popularity/hotness: each time an entity is viewed its field emits energy (increasing the value), and cron decays that energy over time using a linear, decay (half-life), or count profile — so recently-and-frequently-viewed content ranks highest and interest fades naturally.

---

The module ships two field types: the recommended `radioactivity_reference` (an entity-reference to a dedicated `radioactivity` content entity that holds the energy/timestamp, so a node revision doesn't change on every view) and the deprecated `radioactivity` field (stores energy/timestamp inline). A field's *Emitter* formatter attaches JS: when the entity is displayed, `Incident::createFromFieldItemsAndFormatter()` builds a signed incident (field name, entity type/id, target id, energy, and a SHA-1 hash over those plus the site hash salt) and puts it in `drupalSettings`; `js/triggers.js` POSTs collected incidents to the configured storage endpoint. Incoming incidents are validated (`Incident::isValid()` recomputes the hash — forging energy requires the site's hash salt) and stored, then cron (`RadioactivityProcessor`) processes them into entity energy via queue workers and separately runs decay per field settings (`profile`, `granularity`, `halflife`, `cutoff`). Storage is pluggable via `radioactivity.storage` config (`type`): `default` uses the `radioactivity_incident` DB table with the Drupal route `/radioactivity/emit` (permission `access content`); `rest_local`/`rest_remote` use the standalone `endpoints/file/rest.php` PHP script (which writes incidents to a temp JSON file) for sites where the Drupal route can't run (e.g. aggressive full-page caches or a remote collector). When energy falls below the cutoff, an `EnergyBelowCutoffEvent` (and a Rules event) fires. A Drush command `radioactivity:fix-references` backfills missing reference targets, and Views integration exposes the energy for sorting "most popular" listings.

---

- Track how "hot" / popular each node is and sort a view by it.
- Build a "Most viewed this week" or "Trending now" block that naturally fades old content.
- Count raw page views per entity (Count profile, never decays).
- Decay popularity linearly (loses 1 energy/second) with the Linear profile.
- Decay popularity exponentially with a configurable half-life (Decay profile).
- Rank forum topics, articles, or products by recent interest.
- Add a hotness metric without changing node revisions (use `radioactivity_reference`).
- Emit different energy amounts from different displays (e.g. teaser vs full view).
- Show the current energy value next to content (Emitter formatter "display" option).
- Sort or filter Views by the referenced radioactivity energy.
- Fire a Rules reaction when an item's energy drops below the cutoff (e.g. unpublish, un-feature).
- Fire a custom event (`EnergyBelowCutoffEvent`) when content cools off.
- Throttle write frequency with the granularity setting to reduce cron write load.
- Collect view events even behind aggressive page caching via the REST file endpoint.
- Send popularity events from a decoupled/front-end client to a remote collector (`rest_remote`).
- Keep energy updates out of the entity's revision history (non-revision save).
- Skip decay for unpublished entities automatically.
- Backfill reference targets after adding the field with `drush radioactivity:fix-references`.
- Build editorial dashboards of trending content.
- Feature/curate content automatically based on live popularity.
- Age out promoted banners or callouts as engagement declines.
- Provide a lightweight alternative to core Statistics for popularity ranking.
- Process large volumes of view events safely via chunked queue workers.
- Use multiple radioactivity fields on one entity to track different interaction types.
