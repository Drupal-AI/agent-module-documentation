Bee Hotel ICal exports each unit's blocked availability as a downloadable iCal (.ics) feed for external calendars to sync.

---

This submodule adds an availability export: /beehotel_ical/availability/{node} returns a text/calendar .ics document listing the unit's blocked nights (BAT events whose state is in the configured blocking-status list) as VEVENTs. External services - Google Calendar, Airbnb, Booking.com - can subscribe to keep their availability in sync with the Bee Hotel property. The feed is generated purely from local BAT event data; it does not fetch any remote URL. An admin settings form configures which BAT statuses are treated as blocking.

---

- Publish a unit's availability as a standard .ics feed.
- Let Google Calendar subscribe to a room's blocked dates.
- Sync availability to Airbnb or Booking.com via iCal import.
- Choose which BAT statuses count as 'blocking' (unavailable).
- Serve the feed as a downloadable attachment with no-cache headers.
- Generate events from local BAT data (no external calls).
- Give each unit its own named .ics file based on the node title.
- Expose availability for a rolling window of upcoming days.
- Integrate channel management without a paid connector.
