# Configuration

Event to Calendar needs to know which of your content types represent events, and
which fields on those types hold the dates and location it should put into each
calendar output. That is the whole of the configuration, and it is done on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **/admin/config/event-to-calendar**.

## Choose your event content types

The form lists your site's content types. Tick the ones that represent events — these
are the types whose nodes will get calendar outputs. Only nodes of a selected type can
be exported to a calendar.

## Map the date and location fields

For each content type you enable, tell the module which fields to read:

- **Start date field** — the field holding the event's start date/time. This becomes
  the start of the calendar entry.
- **End date field** — the field holding the event's end date/time.
- **Location field** — the field holding where the event takes place. Its value is
  written into the calendar entry's location.

Pick the field on each content type that matches each role. The controller reads these
mapped fields when it builds the iCal, vCal, CSV, RSS, and add-to-calendar outputs, so
getting the mapping right is what makes the exports accurate.

> **Note on time zones.** In this version the module converts event times from the
> America/Denver time zone to UTC when producing its output. If your events are in a
> different time zone, verify the resulting calendar entries land at the times you
> expect.

## Save

Click **Save configuration**. From then on, nodes of the enabled content types can be
exported through the `/event/{node_id}/…` endpoints and the **Add to Calendar** block.
