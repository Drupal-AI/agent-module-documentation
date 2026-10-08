Add to Cal is a field formatter for date fields that renders an "Add to Calendar" button generating links to Google, Yahoo, Outlook.com, Office.com, and a downloadable iCal (.ics) file for the event.

---

Add to Cal provides two Field API formatters — `addtocal_view` ("Add to Cal", a button that opens a menu of calendar options) and `addtocal_grouped_view` ("Add to Cal grouped button") — that attach to date field types: `date`, `datestamp`, `datetime`, `daterange`, `daterange_timezone`, `date_recur`, and `smartdate`. Both extend core's `DateTimeCustomFormatter`, so they also expose its date-format settings, and add their own settings: `event_title`, `location`, `description` (all token-aware, defaulting the title to the entity label), a `separator` for date-range fields, and a `past_events` toggle that decides whether the widget appears for events already in the past. Link generation is delegated to the `spatie/calendar-links` library, producing one `Link` per field delta with Google/Yahoo/WebOutlook/WebOffice/Ics generators. The module defines a theme hook `addtocal_links` (template `addtocal-links.html.twig`) for the rendered button/menu, exposes an `addtocal-url` token type (with `google`, `yahoo`, `web_outlook`, `web_office`, `ics` sub-tokens) so calendar URLs can be embedded elsewhere, and invites customization through `hook_addtocal_links_alter()`. It has no admin settings page (`configure: null`); everything is configured per field on the entity's Manage display page. It depends on core's `datetime` module and suggests `token`.

---

- Add an "Add to Calendar" button under an event's date field on the node display.
- Let visitors add an event to Google Calendar, Yahoo, Outlook.com, or Office.com in one click.
- Offer a downloadable `.ics` file so events import into Apple Calendar / MS Outlook.
- Render the button for a `datetime` "event date" field via the `addtocal_view` formatter.
- Use the grouped-button variant (`addtocal_grouped_view`) for a more compact display.
- Show calendar links for a Date Range field, honoring start and end times.
- Support Smart Date fields, converting their timestamps into calendar links.
- Set a custom event title with tokens (e.g. `[node:title]`) instead of the entity label.
- Populate the event location from a token or static text via the `location` setting.
- Add an event description (token-aware) to the generated calendar entries.
- Choose whether to keep showing the widget for past events with the `past_events` toggle.
- Customize the separator between start and end dates for range fields.
- Embed a raw calendar URL elsewhere using the `addtocal-url` token (e.g. `[node:field_date:addtocal-url:google]`).
- Output only the Google Calendar URL for a field using the `:google` token variant.
- Alter or add calendar link generators with `hook_addtocal_links_alter()`.
- Remove the `.ics` option or inject a custom generator via the alter hook.
- Override the rendered button markup by overriding the `addtocal-links.html.twig` template.
- Provide accessible "Add to Calendar" menus with ARIA labels out of the box.
- Handle all-day events correctly (dates without a time component).
- Reuse one date field with a plain date formatter on one view mode and Add to Cal on another.
- Give editors calendar buttons without writing any custom code.
- Localize calendar links by rendering per the field's timezone context.
- Standardize event calendar buttons across many content types by configuring the formatter per bundle.
- Drive a conference or webinar schedule page where each session offers calendar links.
