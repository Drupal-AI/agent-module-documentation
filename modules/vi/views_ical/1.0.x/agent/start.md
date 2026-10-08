# Views iCal (views_ical) — agent index

Renders a View's results as an iCalendar (`.ics`) feed. It is **pure Views plugins** — no
settings page, no permissions, no config schema, no Drush (`configure` = null). All setup
happens inside a view. Depends on `views`; bundles the `eluceo/ical` and `html2text/html2text`
PHP libraries.

- **The plugins it defines (display / style / row ids) and how to assemble a feed** →
  [plugins/views-plugins.md](plugins/views-plugins.md)
- **Step-by-step: build an iCal feed (wizard vs legacy), the `views_ical` date format, headers** →
  [configure/build-feed.md](configure/build-feed.md)

Key ids (grounded in `src/Plugin/views/`):
- Display: **`ical`** ("iCal display", extends Feed, adds a `filename` option).
- Style: **`ical_wizard`** ("iCal Style Wizard", recommended) and **`ical`** ("Legacy iCal style").
- Row: **`ical_fields_wizard`** ("iCal fields row wizard", recommended) and **`ical_fields`**
  ("Legacy iCal Fields row").
- Installs date format **`views_ical`** ("Views iCal date"), pattern `Ymd\THis\Z`.
