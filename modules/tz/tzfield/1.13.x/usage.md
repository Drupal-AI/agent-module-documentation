<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Time Zone (tzfield) provides a **time zone field type** that stores a tz-database identifier (e.g. `Europe/London`) on any fieldable entity, with select-list widgets and display formatters.

---

The module defines the `tzfield` field type (`TimeZoneItem`), which stores a single `value` varchar(50) column (indexed) holding a PHP/tz-database time zone identifier and implements `OptionsProviderInterface` so its allowed values come from `\DateTimeZone::listIdentifiers()`. Per-field settings let you **exclude** specific zones from the options and default a new value to the **site's** default time zone (`default_site`) and/or the **current user's** time zone (`default_user`, only offered when user time zones are configurable). Two widgets ship: `tzfield_default` (**"Time zone"**, a select grouped by region) and `tzfield_offset` (**"Time zone with current offset"**, a select sorted by and labelled with each zone's current UTC offset, e.g. `(UTC+01:00) Europe/London`). For display, `hook_field_formatter_info_alter()` lets the field reuse core's `basic_string` formatter to print the raw identifier (the default formatter), and the module adds `tzfield_date` (**"Formatted current date"**) which renders the *current* time in that zone using a configurable PHP date format string (default `T`, e.g. `GMT`) via a lazy-builder. A `migrate` field plugin (`tzfield`) supports migrations. There is no admin UI or configure route — you add and configure the field through the normal Field UI, and its settings are validated by the module's config schema.

---

- Store the time zone of a location entity (city, office, store, venue) as `Europe/London`.
- Let editors pick a time zone from a region-grouped select on a content type.
- Offer a time zone select sorted by current UTC offset so editors can find zones by offset.
- Default a new node's time zone field to the site's default time zone.
- Default a field to the current user's own configured time zone.
- Exclude irrelevant or deprecated zones from the allowed options for a field.
- Display a stored zone as its identifier (`America/New_York`) using the basic string formatter.
- Display the *current local time/abbreviation* in the stored zone (e.g. `EST`) via `tzfield_date`.
- Show the current time in a venue's time zone using a custom PHP date format like `g:i a T`.
- Associate a time zone with a user profile to localize displayed times.
- Attach a time zone to an event so start times can be interpreted correctly.
- Record the operating time zone of a branch for scheduling/reporting.
- Power a "world clock" style listing by rendering `tzfield_date` across many location nodes.
- Feed the stored identifier into `DrupalDateTime::setTimezone()` in custom code.
- Validate submitted values against `\DateTimeZone::listIdentifiers()` via the options provider.
- Migrate legacy time-zone data into Drupal using the module's migrate field plugin.
- Provide a required time zone selection with no empty option on a create form.
- Use the field on taxonomy terms or media, not just nodes.
- Compute per-entity local times for notifications or digests based on the stored zone.
- Group offices by region using the region-grouped widget options.
- Keep stored data in canonical tz format for interoperability with other systems.
- Let a booking/appointment entity carry the customer's time zone.
