<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel ICal (beehotel_ical) — agent index

Exports a unit's availability as an **iCal (.ics)** feed for external calendars. Dependency:
`bee_hotel`. Core `^9.4 || ^10 || ^11`.

## Routes (`.routing.yml`)

- `beehotel_ical.icalavailability` — `/beehotel_ical/availability/{node}` →
  `Controller\BeeHotelICal::availability`, perm `access content`. Returns `text/calendar`
  with a `Content-Disposition: attachment` `.ics` named from the node title.
- `beehotel_ical.admin_settings` — `/admin/config/services/beehotel_ical/settings` →
  `Form\BeeeHotelIcalSettingsForm`, perm `administer bee_hotel`.

## How it works

`availability()` walks the next ~10 days; for each night whose BAT state is in the configured
**blocking status** list it loads the `bat_event`, and emits a `VEVENT` (DTSTART/DTEND from
`event_dates`, UID = `event uuid @ host`, `STATUS:CONFIRMED`). Output = `head()` + `events()` +
`tail()`. It **generates** the calendar from local BAT data only — it never fetches a
request-supplied URL. Node title feeds only a sanitised filename (`cleanFileName()`).

## Config

`beehotel_ical.settings` → `ical.blocking_status` (comma-separated list of BAT statuses treated as
unavailable), set on the settings form.

## Solution docs

- Feed format, blocking status and subscribing an external calendar →
  [config/export.md](config/export.md)
