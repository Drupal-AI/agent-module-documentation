<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FullCalendar Solr (fullcalendar_solr) — agent index

**A Views style plugin that renders a Search API/Solr result set as an interactive FullCalendar year calendar.**

- **Version:** 1.0.x  ·  **Core:** ^9 || ^10 || ^11  ·  **Package:** Views
- **Depends on:** views, search_api. Backend must support the `search_api_facets` feature.
- **Provides:** Views style plugin `fullcalendar_solr` (`src/Plugin/views/style/FullCalendarSolr.php`), theme `views_view_fullcalendar_solr`.
- **Config:** style settings map a string Date field (`YYYY-MM-DD`) and a Year contextual filter; view path must end in `year`.
- **Libraries:** loads FullCalendar 6.1.5 as an **external** asset from unpkg.com (CDN, no SRI).
- **No routes / permissions / write endpoints** — it is purely a display formatter.

**Security:** no server endpoints of its own; only concern is the externally-hosted FullCalendar JS (CDN dependency without SRI) — vendor it locally under a strict CSP.

See [configure/year-calendar.md](configure/year-calendar.md).