<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAgenda integrates the OpenAgenda event-management platform with Drupal, importing and displaying events from an OpenAgenda agenda identified by its UID.

---

OpenAgenda connects a Drupal site to the OpenAgenda platform — a shared event-publishing and
aggregation service — and surfaces its events on the site instead of maintaining them as local
content. You point the module at an OpenAgenda agenda by its UID and it renders that agenda's events
as listings, single-event pages and filtered views. It is a common fit for cultural and municipal
sites that already curate events in OpenAgenda. The module ships an OpenAgenda field with a matching
widget and formatter, a default `openagenda` content type, and block-based filters you place in
Structure → Block layout.

Version 4.0.x targets Drupal `^10.4 || ^11` and adds a hard Composer dependency on
`openagenda/sdk-php >= 1.3.1`: all traffic to `api.openagenda.com` goes through that SDK, which the
module builds from the stored OpenAgenda account **public key** and Drupal's `http_client_config`
settings. Configuration lives at `openagenda.form` (`/admin/config/services/openagenda`), gated by
the single `administer openagenda` permission; the event/AJAX/filter routes require `access content`
plus node view access. Because event data comes from the external OpenAgenda service, what the site
can display depends on that service and its API being available.

---

- Display OpenAgenda events on a Drupal 10.4+/11 site.
- Import events from an OpenAgenda agenda by its UID.
- Show event listings and single event pages.
- Filter events with block-based filters (map, calendar, cities, keywords, favorites, relative date, text search, additional field).
- Add sort, submit, total-results and active-filters blocks to the agenda page.
- Show an event map (Leaflet) and an event timetable block on event pages.
- Attach the OpenAgenda field to any content type, or use the default `openagenda` content type.
- Connect through the openagenda/sdk-php SDK to api.openagenda.com.
- Enter your OpenAgenda account public key on the settings form.
- Configure defaults at openagenda.form (events per page, language, columns, style).
- Set a search-relevance threshold (Off / Auto / Custom score) globally or per agenda.
- Disable automatic re-search on filter change (manual submit).
- Include or exclude embedded HTML content in event descriptions.
- Show only current and upcoming events via a prefilter.
- Provide prev/next navigation between search results (navigation context).
- Depend on core node, field and serialization.
- Restrict configuration with the `administer openagenda` permission.
- Serve cultural/municipal event sites from a shared agenda.
- Surface externally curated events without local duplication.
- Support interface translation (bundled French translation).
- Override any display aspect via the module's Twig templates.
