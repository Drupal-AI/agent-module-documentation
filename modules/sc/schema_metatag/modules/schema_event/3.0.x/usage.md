Adds a Schema.org `Event` group (and `Offer`) to Metatag, outputting JSON-LD for events so they qualify for event rich results.

---

A companion submodule of Schema.org Metatag. It registers a Metatag group `schema_event` with a Tag plugin per Event property, extending `SchemaNameBase`; ticket details are expressed as nested `Offer` data. Once enabled, the Event tags appear under the site's Metatag configuration and pull values from content via tokens. On render, Schema.org Metatag emits the collected tags in the page's `application/ld+json` script. Ideal for venues, box offices, conferences and community calendars seeking Google's event experiences. Requires `schema_metatag`.

---

- Add `Event` JSON-LD to event pages.
- Set the event `name` and `description`.
- Provide `startDate` and `endDate`.
- Add `doorTime` for admittance.
- Declare the `location` (Place / virtual).
- Set `eventAttendanceMode` (offline/online/mixed).
- Set `eventStatus` (scheduled, postponed, cancelled).
- Record `previousStartDate` for rescheduled events.
- Attach ticket `offers` with price and availability.
- List the `performer`(s).
- Name the `organizer`.
- Add an event `image`.
- Flag `isAccessibleForFree`.
- Include `aggregateRating` and `review`.
- Set the canonical `url` and stable `@id`.
- Power venue, conference and community calendars.
- Configure per content type, override per node.
- Validate output in Google's Rich Results Test.
