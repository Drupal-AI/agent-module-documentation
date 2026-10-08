<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# calendar_link — Twig API

Provided by `Drupal\calendar_link\Twig\CalendarLinkTwigExtension`.

## Functions

### `calendar_link(type, title, from, to, all_day = false, description = '', address = '')`
Returns a single URL string for one provider.

- `type` — provider key: `google`, `yahoo`, `ical`, `weboutlook` (Outlook.com), `weboffice` (Office 365) and other keys defined by the module's Enum (see `src/`).
- `title` — event title (string).
- `from`, `to` — start/end as PHP `\DateTime` objects (pass the same value twice for a point-in-time event).
- `all_day` — boolean; when true the time component is dropped.
- `description`, `address` — optional strings included in the provider URL.

### `calendar_links(title, from, to, all_day = false, description = '', address = '')`
Returns an **array** keyed by provider type, each value a URL — convenient for rendering a "add to calendar" menu of all providers.

## Template example

```twig
{# $node.field_start / field_end are datetime fields; .date gives a DateTime #}
<a href="{{ calendar_link('google', label, node.field_start.date, node.field_end.date, false, body, location) }}">
  Add to Google Calendar
</a>

<ul class="add-to-calendar">
  {% for provider, url in calendar_links(label, node.field_start.date, node.field_end.date) %}
    <li><a href="{{ url }}">{{ provider }}</a></li>
  {% endfor %}
</ul>
```

## Notes
- Output is a URL string; Twig auto-escapes it (the extension does **not** set `is_safe => ['html']`), so field values are escaped normally.
- `ical` returns a `data:`/`.ics`-style link for download rather than a remote provider URL.
- No configuration and no services beyond the Twig extension — enabling the module is all that is required.