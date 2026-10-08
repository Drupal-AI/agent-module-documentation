# Building an iCal feed with Views iCal

No admin settings page exists — everything is configured inside a View.

## Recommended: the Wizard

1. Create a View of the content that has dates (e.g. Article/Event nodes).
2. Add an **"iCal Display"** to the view (this is the `ical` display plugin).
3. Format → set the style to **"iCal Style Wizard"** (`ical_wizard`).
4. Show → set the row plugin to **"iCal fields row wizard"** (`ical_fields_wizard`).
5. Add the Views **fields** you need — at minimum a start date, an end date (date-range
   fields are supported), and a title.
6. Open the style (Format) settings and map each iCal property (DTSTART/DTEND/SUMMARY/UID/…)
   to the field you added. See https://icalendar.org for property meanings.
7. Give the display a path; optionally set a **filename** (e.g. `events.ics`) in the iCal
   settings so the download is named nicely (adds a `Content-Disposition` header).

## Legacy (manual, RFC 5545 labelling)

1. Add a **Feed** display, set the style to **"iCal Feed"** (`ical`) and Show to
   **"iCal Fields"** (`ical_fields`); un-check "Provide default field wrapper elements".
2. Add fields and set each field's **Label** to the RFC 5545 name: `DTSTAMP`, `DTSTART`,
   `DTEND`, `SUMMARY`, `UID`.
3. For date fields use the **"Views iCal date"** field formatter, or a Custom format of
   `Ymd\THis\Z` with the **UTC** timezone override (the trailing `Z` means UTC).
4. Un-check "place colon after label" and "Link to content" on each field.

The wizard is recommended for all new feeds; the legacy path is fiddly.

## The shipped date format

The module installs a locked core date format:

- id: `views_ical`, label "Views iCal date", pattern **`Ymd\THis\Z`** (UTC iCal timestamp).
- Read it: `drush config:get core.date_format.views_ical`.
- It is deleted on `views_ical` uninstall.

## Output

- Response header: `Content-Type: text/calendar; charset=utf-8` (set in preprocess).
- With a display `filename`, also `Content-Disposition: attachment; filename="<name>"`.
- Calendar title = the view title, unless the display's `sitename_title` option is on, in
  which case it is the site name (+ slogan).

## Inspecting a configured feed

```bash
drush config:get views.view.<view_id>
# look under display.<id>.display_options for: display_plugin: ical,
# style.type: ical_wizard (or ical), row.type: ical_fields_wizard (or ical_fields)
```
