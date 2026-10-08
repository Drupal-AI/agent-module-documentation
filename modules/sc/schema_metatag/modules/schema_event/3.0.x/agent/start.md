# schema_event — agent start

Submodule of [schema_metatag]. Adds a Metatag group `schema_event` (`@type` Event; ticket data
as nested Offer) with Tag plugins for Event properties (name, description, startDate, endDate,
doorTime, location, eventAttendanceMode, eventStatus, previousStartDate, offers, performer,
organizer, image, isAccessibleForFree, aggregateRating, review, url, @id). Configure the tags
with tokens under the site's **Metatag** settings; values render as JSON-LD via schema_metatag.
No config UI of its own.
