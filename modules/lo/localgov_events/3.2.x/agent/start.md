<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Events (localgov_events) — agent index

Event content type with recurring dates (date_recur), a date-filtered listing view, a search view
and category facets. No `configure` route, no permissions of its own, no config schema, no Drush.

- **Bundle, fields, views and the exposed-filter behaviour** →
  [configure/setup.md](configure/setup.md)
- **Recurrence handling, cron guard and form callbacks** → [api/recurrence.md](api/recurrence.md)

Submodule (own docs):
- `localgov_events_remove_expired` →
  [../../modules/localgov_events_remove_expired/3.2.x/agent/start.md](../../modules/localgov_events_remove_expired/3.2.x/agent/start.md)

Key facts:
- Bundle **`localgov_event`**; fields: `localgov_event_date` (**date_recur**),
  `localgov_event_image`, `localgov_event_categories`, `localgov_event_price`,
  `localgov_event_locality`, `localgov_event_location`, `localgov_event_call_to_action`, `body`.
- Views: `localgov_events_listing`, `localgov_events_search`.
- `hook_views_pre_view()` on `localgov_events_listing`:
  - empty `start` exposed filter → defaults to **today**;
  - `end` exposed filter → **+1 day** before querying, so events on the end date are included.
  Remember this if you build your own display from the same view — the adjustment is applied by
  view id, so a cloned view with a different id loses it.
- `hook_cron()` runs **at most once per day** (state key
  `localgov_events.infinite_cache_last_run`, 86400s guard). It checks that
  `localgov_event_date` still exists and is of type `date_recur`, then manages
  `DateRecurOccurrences` so infinitely recurring events do not accumulate unbounded occurrence
  rows.
- `hook_page_attachments()` attaches the `localgov_events/events-styling` library on any path
  starting with **`/events`** — a path-prefix check, so a differently pathed events section gets no
  styling.
- `hook_modules_installed()` (skipped while syncing) installs optional config when
  `localgov_directories_page` / `localgov_directories_venue` arrive, so events can link to
  directory venues.
- Form alters on `node_localgov_event_form` / `…_edit_form` delegate to
  `EventsAddEditCallbacks::configureNodeForm()`.
- `hook_localgov_roles_default()` grants editor/author node permissions for `localgov_event`.
