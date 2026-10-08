# The `addtocal` Date Augmenter plugin

`addtocal_augment` does **not** define a plugin type; it implements one plugin of the
`date_augmenter` type (defined by the `date_augmenter` module). To write your own augmenter, see
that module — here we document what `addtocal` produces so you can call, theme, or extend it.

## Class & registration

`Drupal\addtocal_augment\Plugin\DateAugmenter\AddToCal`, annotated/attributed
`id = "addtocal"`, extends `DateAugmenterPluginBase`, implements `PluginFormInterface` and
`ContainerFactoryPluginInterface`. Instantiate via the manager:

```php
$plugin = \Drupal::service('plugin.manager.dateaugmenter')->createInstance('addtocal');
$output = [];
$plugin->augmentOutput($output, $start, $end, [
  'settings' => $settings,   // the option keys (see configure/settings.md)
  'entity'   => $node,       // used for label + token replacement
  'allday'   => FALSE,
  'repeats'  => 'RRULE:FREQ=WEEKLY',  // optional; adds recurrence
  'ends'     => $last_instance_dt,    // optional; for recurring "is it upcoming"
]);
// $output['addtocal'] is a render array (#theme addtocal_links / addtocal_links__modal).
```

## What `buildLinks()` / `augmentOutput()` produce

For a start (and optional end) `DrupalDateTime`:

- **Google** — `https://calendar.google.com/calendar/render?action=TEMPLATE&...` with
  `text` (title), `dates` (`start/end`, format `Ymd\THi00`), and optional `details`,
  `location`, `ctz` (timezone), `recur`.
- **iCal (Apple)** — a `data:text/calendar;charset=utf8,BEGIN:VCALENDAR...` string with
  `PRODID` (= site name), optional `VTIMEZONE`, then a `VEVENT` (UID = entity UUID, SUMMARY,
  DTSTAMP in UTC, DTSTART/DTEND with `;TZID=` prefix, optional DESCRIPTION/LOCATION, RRULE).
- **Outlook** — the same iCal structure but with `VTIMEZONE` removed and DTSTART/DTEND written in
  UTC (`...Z`).

Lines are joined with the `%0D%0A` separator (`implodeRecursive`).

## Rendering / theme

- `#theme = 'addtocal_links'` normally, or `'addtocal_links__modal'` when
  `settings.target === 'modal'` (which also attaches `addtocal_augment/modal`).
- Theme variables: `label`, `ical`, `outlook`, `google`, `id` (a unique DOM id from the title),
  `icons`. Templates: `templates/addtocal-links.html.twig`,
  `templates/addtocal-links--modal.html.twig`.

## Timezone & gating logic (agent gotchas)

- `extractTimezone()`: uses the start date's timezone, else `system.date` default. If
  `ignore_timezone_if_UTC` (default true) and the zone is UTC, the timezone is dropped.
- Past-event gating: if the (last) end is before "now" and `past_events` is false, `buildLinks()`
  returns nothing — no links render. Set `past_events = true` to force them.
- `event_title` empty **and** no `entity` in options → returns nothing.
- `parseField()` runs token replacement (when the `token` service exists and an entity is given),
  strips markup, and normalizes whitespace unless `retain_spacing` is set.

## Extending

Subclass `AddToCal` and override `getCurrentDate()` (isolated for testing the past-event gate) or
`buildLinks()`/`augmentOutput()` to change the emitted calendar payloads; register your subclass
as a new `date_augmenter` plugin id.
