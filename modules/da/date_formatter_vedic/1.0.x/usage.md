<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vedic Date Formatter extends Drupal's date formatting with a custom PHP format character that outputs the current muhūrta — a 48-minute Vedic time division (30 muhūrtas span a full day).

---

The module decorates the core `date.formatter` service (`DateFormatterDecorator`, decoration priority 10) and uses a `DateReplacementService` to substitute the configured format character (default `q`) with the appropriate muhūrta name when a date is formatted. So a format string like `jS F Y, g:i a (Muhurta: q)` renders as e.g. `23rd April 2025, 10:30 am (Muhurta: Surya)`. An admin settings form at `/admin/config/regional/vedic-date-formatter` (permission `administer site configuration`) lets a site builder change the format character and override the 30 muhūrta names, with language awareness via the injected `language_manager` and `entity_type.manager`.

Because it decorates the core date formatter, the muhūrta character works anywhere Drupal date formats are used (field formatters, Views, custom code). The only server surface is the admin settings form; there are no anonymous or mutating endpoints and no external calls. Choose a format character that does not collide with a standard PHP date character you rely on.

---

- Show the current muhūrta name inside any Drupal date format.
- Use the `q` format character to output the muhūrta.
- Change the format character to avoid clashing with a standard one.
- Override any of the 30 muhūrta names.
- Localise muhūrta names for different site languages.
- Display the muhūrta in a Date field formatter.
- Display the muhūrta in a Views date column.
- Include the muhūrta in programmatically formatted dates.
- Add Vedic timekeeping context to event or article timestamps.
- Configure everything at `/admin/config/regional/vedic-date-formatter`.
- Decorate the core `date.formatter` service transparently.
- Combine the muhūrta character with standard PHP date characters.
- Render `jS F Y, g:i a (Muhurta: q)`-style formats.
- Map any timestamp to its 48-minute muhūrta division.
- Provide muhūrta output site-wide without per-field code.
- Keep the feature admin-only via `administer site configuration`.