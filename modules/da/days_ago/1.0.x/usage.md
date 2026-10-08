Days ago is a single field formatter that displays a datetime or timestamp field as the whole number of days between that date and the current time.

---

The module ships one plugin, `DaysAgoFieldFormatter` (formatter id `days_ago_field_formatter`, label "Days ago"), which applies to core `datetime` and `timestamp` field types. On any entity view display you can switch such a field's format to "Days ago" and, instead of a formatted date, it renders a plain integer — the absolute day count returned by PHP's `DateInterval::format("%a")` between the field value and `\Drupal::time()->getCurrentTime()`. There is no settings form, no configuration object, no permissions, no routes, no Drush commands and no dependencies beyond Drupal core; the whole module is the one formatter class. A timestamp value of `0` (or less) renders as the literal string `0`, and the output is HTML-escaped before display. Note that the difference is absolute, so a future date is shown as a positive day count just like a past one, and only the day component is emitted (no "ago"/"in" wording, hours or months).

---

- Show how many days ago a node was authored by setting the "Authored on" (created) timestamp field to the Days ago format.
- Display the number of days since a comment or content item was last changed/updated.
- Render a custom "Published date" or "Event date" datetime field as an age in days.
- Give editors a quick at-a-glance "N days old" indicator on content listings via the entity's teaser display.
- Present a membership or account-created date as days elapsed on a user profile display.
- Show days remaining/elapsed for a deadline or due-date datetime field (value is the absolute day count).
- Replace a verbose formatted date with a compact integer in dense table-like view modes.
- Surface "days since last login" style figures where the source is a timestamp field.
- Display the age in days of a media item's created date on its display.
- Show how long ago a product, listing, or classified was posted, driven by a datetime field.
- Indicate the number of days since a support ticket or issue entity's created date.
- Provide a lightweight "days since publication" figure for article bylines.
- Show days elapsed for a subscription start-date field on commerce or membership entities.
- Render a "days on site" metric from a user's created timestamp in a directory listing.
- Display days since a file or document entity's upload date.
- Show the day count for a recurring reminder or task's due datetime field.
- Present days elapsed since an order's placed timestamp in an admin view mode.
- Give a numeric "freshness" signal (days old) for cached or imported content.
- Show days since a review or rating was submitted.
- Display the day difference for any custom datetime/timestamp field without writing a Twig template or custom formatter.
