<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Events adds an event content type with proper recurring-date support, a date-filtered listing, a search page and category facets — the events section of a LocalGov Drupal site.

---

The heart of it is the `localgov_event` node type, whose `localgov_event_date` field is a **date_recur** field: an event can repeat on a rule (every Tuesday, first Monday of the month) and each occurrence is indexed separately, so a recurring event appears on every date it actually happens rather than only its first. `date_recur_modular` supplies the friendlier recurrence widget used on the add/edit forms, which `EventsAddEditCallbacks::configureNodeForm()` tunes further. Alongside the date the bundle carries an image, categories taxonomy, price, locality, location and a call-to-action link. Two views ship: `localgov_events_listing` (the date-filtered browse page) and `localgov_events_search`. `hook_views_pre_view()` fixes two everyday annoyances on the listing — an empty start filter defaults to today, and the end filter is bumped by one day so events *on* the end date are included rather than excluded. A daily `hook_cron()` guards against unbounded recurrence: it verifies `localgov_event_date` really is a `date_recur` field and manages the occurrence cache so infinitely repeating events do not generate rows forever. Styling is attached automatically on any path starting with `/events`. When the LocalGov Directories page or venue bundles are installed, `hook_modules_installed()` pulls in optional config so events can reference directory venues. Facets provide filtering by category, and `hook_localgov_roles_default()` grants the LocalGov editor and author roles the usual event permissions. The `localgov_events_remove_expired` submodule handles what happens to events after they finish.

---

- Publish a council's what's-on listing.
- Create a weekly recurring event that appears on every occurrence date.
- Model "first Monday of the month" style recurrence without custom code.
- Let visitors filter events by date range.
- Default the events listing to today's date automatically.
- Include events happening on the chosen end date in results.
- Filter events by category with facet blocks.
- Search events by keyword.
- Show event price and locality in listings.
- Add a call-to-action link (book, register) to an event.
- Illustrate events with an image.
- Link an event to a venue from the directories module.
- Give editors a friendly recurrence widget rather than raw RRULE input.
- Keep recurrence occurrence caches bounded for infinite rules.
- Style event pages consistently across the /events section.
- Let editors manage events without bespoke permission setup.
- Archive or delete events automatically after they finish (submodule).
- Build a "next 5 events" block from the shipped listing view.
- Support all-day and timed events.
- Publish an events feed for a partner site.
- Provide a searchable archive of past events.
- Categorise events by audience or theme.
- Run several event categories through one listing with facets.
- Migrate an existing events calendar into structured content.
