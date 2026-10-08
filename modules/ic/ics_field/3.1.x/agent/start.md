# iCalendar Field — agent index

A "Calendar download" field type that generates a downloadable `.ics` file from the entity's Summary/Description/
URL + a referenced Datetime field. Depends on core `datetime` and `token`; needs the `eluceo/ical` and
`html2text/html2text` Composer libs (auto-installed). No admin settings page (`configure` null), no permissions.

- **The field type + widget + formatter, storage/instance settings, tokens, where files land** →
  [configure/field.md](configure/field.md)
- **Services and the generation pipeline (`IcsFileManager`, `CalendarPropertyProcessor`, `ICalFactory`)** →
  [api/generation.md](api/generation.md)

Key facts:
- Field type `calendar_download_type` (widget `calendar_download_default_widget`, formatter
  `calendar_download_default_formatter`). Sub-values: `summary`, `description`, `url`, computed `fileref`.
- Storage setting `date_field_reference` = which sibling `datetime` field supplies event dates; files go to
  `uri_scheme://file_directory` (default `public://icsfiles`), named `md5(entityUuid + fieldConfigUuid)_event.ics`.
- Summary/Description support tokens resolved against the host entity; the .ics is (re)built on entity save.
- iCal text is escaped by eluceo/ical (`Property/StringValue`: `\ " , ;` and `\n` escaped, control chars
  stripped) — no line/property injection from field values. Generated file is public/unauthenticated by design.
