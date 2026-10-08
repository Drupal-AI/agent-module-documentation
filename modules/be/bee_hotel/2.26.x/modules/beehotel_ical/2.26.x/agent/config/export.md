<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# iCal availability export

## The feed

`GET /beehotel_ical/availability/{node}` (`Controller\BeeHotelICal::availability`,
perm `access content`) returns a `text/calendar` `.ics` attachment. Structure:

- `head()` — `BEGIN:VCALENDAR` + PRODID/VERSION/CALSCALE/METHOD/X-WR-* headers.
- `events()` — loops the next ~10 days; for each day whose `Event::getNightState()` is in the
  configured **blocking status** set, loads the day's `bat_event` and appends a `VEVENT`
  (`DTSTART;VALUE=DATE`, `DTEND;VALUE=DATE`, `UID:{uuid}@{host}`, `STATUS:CONFIRMED`,
  `SUMMARY:bbs bee_hotel`).
- `tail()` — `END:VCALENDAR`.

Response sets no-cache + security headers and `Content-Disposition: attachment; filename="beehotel_<clean-title>.ics"`.

## Configure blocking statuses

`Form\BeeeHotelIcalSettingsForm` at `/admin/config/services/beehotel_ical/settings`
(perm `administer bee_hotel`) writes config `beehotel_ical.settings:ical.blocking_status` — a
comma-separated list of BAT state names that should be exported as busy/blocked.

## Subscribe from an external calendar

Give the external service (Google Calendar / Airbnb / Booking.com iCal import) the full URL
`https://<site>/beehotel_ical/availability/<node-id>`. The feed is generated from local BAT
events only — no outbound fetch is performed by this module.
