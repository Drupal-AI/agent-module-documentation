# iCalendar Field — services & generation pipeline

Services (`ics_field.services.yml`):
- `ics_field.file_manager` → `IcsFileManager` (request_stack, token, entity_field.manager, file.usage,
  logger.factory, calendar_property_processor_factory, ical_factory, file_system, messenger).
- `ics_field.calendar_property_processor_factory` → `CalendarPropertyProcessorFactory` (creates a
  `CalendarPropertyProcessor` bound to a field config: reads `date_field_reference` + field UUID).
- `ics_field.ical_factory` → `ICalFactory` (url_normalizer).
- `ics_field.url_normalizer` → `UrlNormalizer` (makes the event URL absolute).
- `ics_field.drupal_user_timezone_provider` → `DrupalUserTimezoneProvider`.

## Pipeline (driven from `CalendarDownloadType::preSave()/postSave()`)
1. On a **new** entity, `IcsFileManager::createIcalFile()` writes an empty managed file first (so a `fileref`
   exists before tokens that need the entity id, e.g. url, can resolve). On update / postSave,
   `updateIcalFile()` writes the real content.
2. `CalendarPropertyProcessor::getCalendarProperties($tokens, $entity, $host)`:
   - Sets `timezone` (user timezone), `product_identifier` (request host → iCal PRODID), `uuid`
     (`entity uuid + field uuid`).
   - `Token::replace()` on the `summary`/`url`/`description` templates against `[<entity_type> => $entity]`
     with `clear => TRUE`.
   - Validates essential properties (`timezone`, `product_identifier`, `summary`, `uuid`) — throws
     `CalendarDownloadInvalidPropertiesException` if any is empty.
   - Builds `dates_list` from the referenced datetime field (`Y-m-d\TH:i:s`).
3. `ICalFactory::generate($props, $request, $tsFormat)` — builds a `Calendar` with a timezone component and one
   `Event` per date: `setDtStart` (UTC→user tz), `setSummary`/`setDescription` (via `html2text`),
   `setDescriptionHTML` (raw description → `X-ALT-DESC;FMTTYPE=text/html`), `setUrl` (normalized). Returns the
   rendered ics string.
4. `IcsFileManager::saveManagedCalendarFile()` writes/overwrites the managed file and returns its id
   (stored as `fileref`); `postSave` also adds the `file_usage` record.

## Escaping / injection note
`eluceo/ical`'s `Property/StringValue` escapes `\`, `"`, `,`, `;`, and `\n`, and strips control bytes, so
summary/description/url text (even token-derived from low-priv fields) cannot inject additional iCal lines or
properties. `getText()` from `html2text` also flattens markup. No raw request parameter reaches the file;
inputs are entity field values + tokens resolved server-side on save.

## Rendering the link
`CalendarDownloadDefaultFormatter::viewValue()` loads the `fileref` managed file and renders a `link` render
element ("iCal Download") to `file_url_generator->generate($uri)`.
