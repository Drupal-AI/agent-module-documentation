<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Add To Calendar renders an "Add to Calendar" button (iCalendar, Google Calendar, Outlook, Outlook Online, Yahoo) next to date fields on entity pages, using the third-party addtocalendar.com widget library. Editors get a button that exports an event to a visitor's calendar of choice.

---

The module works two ways. First, it adds a **third-party formatter setting** to core Date/time (`datetime`) and Datetime Range (`daterange`) field formatters: on *Manage display* you tick "Show Add to Calendar" and the button is appended after the rendered date, with event title/description/location/organizer/end-date each mapped to another field on the entity, a token/static string, or the node title. Second, it defines its own boolean-based **field type** `add_to_calendar_field` (widget `add_to_calendar_widget_type`, formatter `add_to_calendar`) that adds a standalone button to any entity and can be placed in Views — the per-entity checkbox lets an editor enable or disable the button on individual items. Event data is emitted as hidden `<var>` markup (start/end date, timezone, privacy, calendars list) that the addtocalendar.com JS (`//addtocalendar.com/atc/1.5/atc.min.js`, loaded as an external library) turns into the interactive button. Styling offers "No styling", "Blue", or "Glow Orange". Two alter hooks (`hook_addtocalendar_field_alter`, `hook_addtocalendar_field_FIELD_NAME_alter`) let you rewrite a field's emitted value. There is no configuration page (`configure` is null); all settings live on the field formatter or field instance.

---

- Add an "Add to Calendar" button beside an event node's start-date field on its display.
- Let visitors export an event to Google Calendar, Outlook, Yahoo, or download an `.ics` file.
- Append the button to a Datetime Range field so both start and end times populate the calendar entry.
- Map the calendar event's title to the node title and its location to an address field.
- Use tokens (e.g. `[node:title]`, `[node:field_venue]`) to build the event description shown in the calendar.
- Add a standalone Add-to-Calendar field to a content type via the module's `add_to_calendar_field` field type.
- Expose the Add-to-Calendar button as a Views field for a listing of upcoming events.
- Give editors a per-node checkbox to switch the button on or off for individual events.
- Show a "Disabled Text" / expired message instead of the button for past events.
- Restrict which calendar providers appear in the button's dropdown (e.g. only Google + iCalendar).
- Mark an event as public or private in the exported calendar entry.
- Force HTTPS-only calendar links via the security-level setting.
- Show the button on only one delta of a multi-value date field, or on all of them.
- Choose the "Blue" or "Glow Orange" prebuilt button style, or output unstyled markup for custom CSS.
- Set the organizer name and organizer email from the site settings or from entity fields.
- Localize the button text (e.g. "Save the date") via the display-text setting.
- Alter the emitted event value programmatically with `hook_addtocalendar_field_alter()`.
- Rewrite a specific field's calendar value with `hook_addtocalendar_field_FIELD_NAME_alter()`.
- Add calendar export to conference session nodes rendered in a teaser view mode.
- Attach the button to a webinar's date field so registrants can block their calendar.
- Provide calendar export on media or taxonomy entities that carry a datetime field.
- Deploy the button configuration as exported config (`third_party_settings.addtocalendar` on the view display).
- Present a consistent calendar-export UX across many content types by enabling the formatter setting on each.
