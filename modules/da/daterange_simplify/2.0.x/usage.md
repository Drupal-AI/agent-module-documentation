Date Range Simplify provides field formatters and Twig helpers that render daterange and datetime fields as compact, locale-aware date phrases using the flack/ranger library.

---

The module ships two field formatters and a Twig extension, all backed by a single `Simplify` service that wraps `openpsa/ranger`. The **Simplify** formatter targets core `daterange` fields and collapses the common parts of a start/end pair into one phrase (for example "October 5, 2013, 10:00 AM to 1:30 PM" or "Jan 12-15, 1952"), with configurable range and date-time separators. The **Intl** formatter targets single `date`/`datetime` fields and renders them with the same simplified style options. Both formatters let you pick a date style and time style from the PHP `IntlDateFormatter` set — none, full, long, medium, short — and can pin output to a specific time zone. The Twig extension exposes an `intl_date` filter and a `current_lang()` function so themes can format arbitrary dates the same way. Output is locale-driven: the display language (or an explicit locale) selects month names, ordering and separators, and non-English locales require the PHP `php-intl` extension. There are no permissions, routes, Drush commands or admin settings pages — everything is configured per view-display under Manage display.

---

- Show a node's event daterange field as a single tidy phrase instead of two full dates.
- Collapse a same-day time range to "October 5, 2013, 10:00 AM to 1:30 PM".
- Collapse a multi-day range that shares a month/year to "Jan 12-15, 1952".
- Render a start/end pair where only the differing parts are repeated, saving horizontal space in teasers.
- Format a single `datetime` field with the Intl formatter using a medium date + short time.
- Format a date-only `date` field with just a date style (time set to "none").
- Produce fully spelled-out dates ("Tuesday, April 12, 1952") by choosing the "full" date style.
- Produce highly abbreviated dates ("12/13/52") by choosing the "short" style.
- Localize event dates automatically to the visitor's interface/URL language on multilingual sites.
- Force a specific locale's date phrasing regardless of the current UI language via the Twig filter's `lang` argument.
- Override the display time zone per formatter so all values show in, e.g., the venue's zone rather than the viewer's.
- Customize the range separator (default "-") to a word like "to" or an en dash.
- Customize the date-time separator (default ", ") between the date portion and the time portion.
- Preview sample "2 hours apart" and "2 days apart" output live in the Manage display settings summary.
- Format dates inside a Twig template with `{{ node.field_when.0.value|intl_date('long','short') }}`.
- Get the current two-letter language code in a template with `{{ current_lang() }}`.
- Feed the Twig filter a raw stored value (ISO 8601 string, `Y-m-d`, or a UNIX timestamp) or a `DrupalDateTime` object.
- Standardize event/date display across many content types without defining custom date formats in Drupal config.
- Replace verbose default daterange output ("Sat, 10/05/2013 - 10:00 - Sat, 10/05/2013 - 13:30") with a human phrase.
- Handle open-ended ranges where the end value is empty by falling back to the start value.
- Keep output time-zone-cache-aware so cached renders vary correctly per viewer time zone.
- Offer editors a display option that needs no extra date-format entities or admin configuration.
