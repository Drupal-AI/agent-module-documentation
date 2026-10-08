<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date time day stores a date together with a start and end time on that same day, in one field, rather than as a date range spanning two full datetimes.

---

Core gives you a datetime field and, through `datetime_range`, a range of two datetimes. Neither is the shape of "Tuesday, 9:00 to 17:00". A range technically stores it, but as two independent datetimes, so nothing stops an editor entering an end date on a different day, the widget asks for the date twice, and any query for "what is happening on this day" has to reason about both ends. This module adds a single field type (`datetimeday`, built on core `datetime`) that encodes the constraint in the data: one date, one start time, one end time, all on that day. You install it, then on any entity/bundle add a field of type **Date time day**; its storage setting **Day type** chooses whether times are stored as `H:i` (`time`) or `H:i:s` (`time_seconds`). On *Manage form display* pick a widget — **Date time day** (`datetimeday_default`, plain text time inputs) or **Date time day with seconds** (`datetimeday_h_i_s_time`) — which asks for the date once plus a start and end time and refuses to save if the end is before the start. On *Manage display* the **Default** formatter renders `date, start – end` with a configurable **day format**, **time format**, and the **day/time separators**. Version **2.0.2** on core `^10 || ^11`, depending on core `datetime`. It fits opening hours, class timetables, appointment slots, conference sessions, shift rotas — the large family of things that happen within one day. The boundary is the thing to establish first: **anything crossing midnight does not fit**, so an overnight shift or a session running to 01:00 needs the range field instead, and choosing the wrong one is expensive to reverse once content exists. The other point is **timezones**: a time on a day is only unambiguous once you know whose day it is, so confirm whether the field stores in UTC and renders in the site or user timezone, particularly on a site with an international audience.

---

- Store opening hours for a day.
- Record a class timetable slot.
- Store an appointment window.
- Record a conference session's time.
- Store a shift's start and end.
- Model a single-day event.
- Record a tour departure and return.
- Store a clinic's consultation hours.
- Record a workshop's duration.
- Model a market's trading hours.
- Store a booking slot.
- Record a meeting time.
- Model a delivery window.
- Store a screening time.
- Record a service's availability.
- Model an exam period on one day.
- Store a broadcast slot.
- Record a volunteer shift.
