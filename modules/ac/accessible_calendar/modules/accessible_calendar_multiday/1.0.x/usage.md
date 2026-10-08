Accessible Calendar - Multiday is an optional submodule that makes events spanning several days render as one continuous strip across the calendar cells.

---

Accessible Calendar - Multiday is a small companion submodule of Accessible Calendar (it depends on it). It provides no UI, routes, permissions, or services; instead it implements `hook_preprocess` for the calendar's day cells and adds multiday metadata and classes to each event row, plus a CSS/JS library. With it enabled, an event whose date range covers multiple days is annotated on every cell it appears in with its position in the run — first, middle, or last — so themes and the bundled CSS/JS can draw it as one continuous, connected sequence rather than a repeated single-day entry. Disabling the submodule leaves the base calendar fully functional but without the multiday attributes and styling.

---

- Render a multi-day conference or festival as one continuous bar across the calendar days it spans.
- Show a hotel booking or reservation (check-in to check-out) as a connected strip rather than separate daily entries.
- Style the first day of a multiday event differently using the `is-multi--first` class.
- Style the last day of a multiday event using the `is-multi--last` class.
- Style the interior days of a run using the `is-multi--middle` class.
- Flag any cell that belongs to a multiday event with the generic `is-multi` class.
- Read an event's position within its run in JavaScript via the `data-accessible-calendar-instance` attribute.
- Read the total span length via the `data-accessible-calendar-instances` attribute.
- Drive custom multiday visuals (rounded ends, connectors) from `js/multiday.js` / `css/multiday.css`.
- Keep single-day events untouched while only multiday events receive the extra classes.
- Enable it alongside "Calendar by month" for continuous month-spanning event bars.
- Enable it alongside "Calendar by week" so events crossing several weekdays connect within the week row.
- Turn multiday styling on or off site-wide simply by enabling/disabling the submodule, with no config changes.
- Extend the multiday preprocessing in your own theme, since it exposes standard row attributes on `$variables['rows']`.
- Present academic terms or project phases that run over consecutive days as unified spans.
