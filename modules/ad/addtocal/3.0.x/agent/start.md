# Add to Cal — agent index

Two date-field **formatters** that render an "Add to Calendar" button (Google/Yahoo/Outlook.com/
Office.com/`.ics`). No admin page (`configure: null`) — configured per field on Manage display.
Depends on core `datetime`; uses the `spatie/calendar-links` PHP library. No Drush, no permissions.

- **Apply the formatter, its settings keys, supported field types, and the `addtocal-url` token** →
  [configure/formatter.md](configure/formatter.md)
- **Customize/extend the generated links (`hook_addtocal_links_alter`)** →
  [hooks/links-alter.md](hooks/links-alter.md)

Key facts:
- Formatter ids: `addtocal_view`, `addtocal_grouped_view`. Field types: `date`, `datestamp`,
  `datetime`, `daterange`, `daterange_timezone`, `date_recur`, `smartdate`.
- Formatter settings: `event_title`, `location`, `description` (token-aware), `separator`
  (range fields), `past_events` (bool). Extends `DateTimeCustomFormatter` (date-format settings too).
- Theme hook `addtocal_links` (`addtocal-links.html.twig`); token type `addtocal-url` with
  sub-tokens `google`, `yahoo`, `web_outlook`, `web_office`, `ics`.
