Provides a "Calendar download" field type that, combined with a Datetime field on the same entity, generates a downloadable `.ics` (iCalendar) file so visitors can add the entity's event to their calendar.

---

The `calendar_download_type` field type stores three editable sub-values — `summary`, `description`, `url` —
plus a computed `fileref` to the generated managed file. Its storage settings pick which sibling `datetime`
field supplies the event date(s) (`date_field_reference`) and the target `uri_scheme`/`file_directory`
(default `public://icsfiles`). The widget (`calendar_download_default_widget`) offers Summary/Description/URL
inputs and a token-tree of the entity's fields; the Summary and Description support **tokens** (e.g.
`[node:title]`) that are resolved against the host entity. On entity save, `preSave()`/`postSave()` drive
`IcsFileManager`: `CalendarPropertyProcessor` interpolates tokens and reads the referenced datetime field into
a date list, then `ICalFactory` (using the `eluceo/ical` library) builds a VEVENT per date — Summary and
Description are run through `html2text` and the library's `X-ALT-DESC` HTML property, and the URL is normalized
to the site scheme/host. The result is written to a managed `.ics` file (named from the entity + field UUIDs)
and tracked in `file_usage`; the formatter (`calendar_download_default_formatter`) renders an "iCal Download"
link. The generated file lives in `public://` and is intentionally downloadable without authentication. iCal
text values are escaped by the eluceo library (backslash, comma, semicolon, newline, control chars), so field
values cannot inject extra iCal lines/properties. The module ships no admin settings page (`configure` is null).

---

- Add an "add to calendar" (.ics) download to event nodes.
- Generate a VEVENT from a node's existing Datetime field.
- Produce multiple VEVENTs from a multi-value date field.
- Populate the event summary from the node title via `[node:title]`.
- Populate the event description from body/other fields via tokens.
- Include an event URL that resolves to the site's absolute URL.
- Store generated .ics files in a custom public subdirectory.
- Let visitors download an .ics without logging in (public files by design).
- Keep the .ics event UID stable across edits so calendar re-imports update the same event.
- Apply the viewing/user timezone when emitting event start times.
- Convert rich HTML descriptions to plain text for calendar clients, while also emitting an HTML alt-description.
- Offer a click-to-insert token list of the entity's fields in the field widget.
- Auto-regenerate the .ics whenever the entity (or its date) is edited.
- Clean up generated files via file_usage tracking when the entity/field is deleted.
- Attach calendar downloads to any fieldable entity type, not just nodes.
- Provide a consistent "iCal Download" link through the default formatter.
- Use a per-field date reference so several date fields on one type can each drive their own calendar.
- Support seminars/webinars/appointments needing calendar exports.
- Regenerate the file directory automatically if the configured folder is missing.
- Keep event data in sync with the entity without a separate calendar system.
