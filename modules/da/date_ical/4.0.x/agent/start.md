# date_ical — agent start

Exports date/event content as RFC-5545 iCalendar (.ics) feeds. Primary use is a **Views feed**
whose Format = `iCal Feed` style + `iCal Fields` row plugin, mapping Views fields to iCal
properties. Also ships an "Add to calendar" field formatter, a CKEditor 5 button, and an
optional Feeds importer. No settings form, no permissions, no info.yml dependencies (Views is
core). Needs the `kigkonsult/icalcreator` Composer library. Config schema present.

- Build a Views iCal feed (style + row plugin, field→property mapping, export options) → [configure/feed.md](configure/feed.md)
- "Add to calendar" field formatter + the per-entity feed / single-event download routes → [configure/formatter.md](configure/formatter.md)
- The reusable `date_ical.feed` service and how it drives icalcreator → [api/service.md](api/service.md)
- Import external .ics feeds (Feeds parser, mapping sources, import alter hooks) → [extend/feeds-import.md](extend/feeds-import.md)
- CKEditor 5 "Date iCalendar" button (insert per-event download links) → [extend/ckeditor.md](extend/ckeditor.md)

Access note: both routes declare `_access: TRUE`, but the feed controller enforces entity- and
field-level `view` access before emitting any data — see [configure/formatter.md](configure/formatter.md).
