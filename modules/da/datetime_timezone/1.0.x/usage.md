<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Datetime Timezone adds a date field type and widget that let the person entering a date also choose the timezone it is in, and store that timezone with the value.

---

Core stores datetime values in UTC and displays them in the site's or the viewer's timezone. That is correct for a timestamp — a moment that happened — but wrong for some real cases. An event listing that says "7pm" means 7pm *where the event is*, and if a conference in Tokyo and one in Denver are in the same view, normalising both to the site timezone misrepresents both. The missing piece is that the timezone is part of the data, not a display preference.

This module makes it part of the data. The field type extends core's `datetime` to carry a timezone the editor selects in the widget, so the stored value knows its own zone. That is the right model for scheduled local events, travel itineraries, and anything where "the timezone this was entered in" is information worth keeping rather than a rendering concern.

It is a distinct field type built on core `datetime`, which means — as with any new field type — an existing core date field cannot be converted in place; adopting it for existing content is an add-a-field-and-migrate exercise. Decide before the content exists where you can.

Four small classes — a field type, a widget, and two formatter classes — with no routes, no permissions and no configuration page.

---

- Store a date with its own timezone.
- Let an editor choose the timezone.
- Represent a local event time correctly.
- Show event times in their own zones.
- Avoid normalising all dates to the site zone.
- Handle multi-timezone event listings.
- Record a travel itinerary's local times.
- Extend core's datetime field.
- Add the timezone widget to a form.
- Keep timezone as data, not display.
- Plan a migration from a core date field.
- Choose the field type when creating the field.
- Display a date in its stored timezone.
- Support conferences across timezones.
- Keep "entered in" timezone with the value.
- Distinguish a local time from a timestamp.
- Add a zoned date to a content type.
- Use core datetime validation.
- Avoid a display-only timezone hack.
- Model scheduled local events accurately.