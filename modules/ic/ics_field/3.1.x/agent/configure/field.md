# Configure the Calendar download field

There is no module settings page. You configure everything on the **field** you add to an entity type.

## Prerequisite
The bundle must already have a core **Datetime** field (the event date). The Calendar download field references
it.

## Add the field
1. *Manage fields* on your bundle → add field of type **Calendar download** (`calendar_download_type`).
2. **Storage settings** (`CalendarDownloadType::storageSettings`):
   - `date_field_reference` (required) — select the sibling `datetime` field that defines when events occur.
   - `file_directory` — subdirectory within the scheme (default `icsfiles`; supports tokens).
   - `uri_scheme` — default `public`. (The directory is created/validated on save; the field errors if it can't
     be made writable.)
3. **Widget** `calendar_download_default_widget` (`CalendarDownloadDefaultWidget`) inputs per item:
   - `summary` (textfield, required on content forms), `description` (textarea, required), `url` (textfield).
   - A **Tokens** details element listing `[node:<field>]`-style tokens for the entity's fields (click to insert).
     Summary and Description are token-replaced against the host entity at generation time.
4. **Formatter** `calendar_download_default_formatter` renders an "iCal Download" link to the generated file.

## Field value shape (schema from `CalendarDownloadType::schema`)
| Column | Type | Notes |
|---|---|---|
| `summary` | varchar(255) | VEVENT SUMMARY (tokens allowed). |
| `description` | text big | VEVENT DESCRIPTION / X-ALT-DESC (tokens allowed). |
| `url` | varchar(255) | VEVENT URL, normalized to site scheme+host. |
| `fileref` | varchar_ascii | Computed; managed file id of the generated `.ics`. |

Default storage settings: `is_ascii=false`, `uri_scheme=public`, `file_directory=icsfiles`,
`date_field_reference=null`.

## Generated file
- Written on entity save to `<uri_scheme>://<file_directory>/md5(entityUuid + fieldConfigUuid)_event.ics`
  as a **managed** file, recorded in `file_usage` (usage removed on field/entity delete → cron cleans it up).
- With `public://` (the default) the file is downloadable **without authentication** — this is documented,
  intended behaviour (it's a shareable calendar file). Use a private scheme + your own access if the event
  details must not be public.
- One VEVENT is emitted per value in the referenced datetime field; the event UID is stable across edits so
  re-imported .ics files update the same calendar event.
