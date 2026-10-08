# Configuration

Easy Datepicker has a **site‑wide settings form** that sets the default behaviour
for every picker. Individual fields can override these defaults (via `data-cdp-*`
attributes or the options‑alter hook), so think of this form as the baseline.

## Open the settings form

1. Log in as a user with the **Administer easy_datepicker settings** permission.
2. Go to **Configuration → Content authoring → Easy Datepicker**
   (`/admin/config/content/easy-datepicker`).

## The settings

- **Default minimum date** — the earliest date pickers allow by default.
- **Default maximum date** — the latest date pickers allow by default.
- **Stop future date selection** — when enabled, dates after today can't be chosen.
  Useful for fields like a birthdate, where a future date is always wrong.
- **Stop past date selection** — when enabled, dates before today can't be chosen.
  Useful for things like future appointments.
- **Default date format** — the display format shown in the field. Five formats are
  available: `mm/dd/yyyy`, `dd/mm/yyyy`, `yyyy-mm-dd`, `dd-mm-yyyy`, and
  `mm-dd-yyyy`. Whatever you pick here only affects how the date is *displayed* — the
  value is always **stored as `Y-m-d`**, so exports and conditional logic elsewhere
  keep working unchanged.

Save the form. These become the defaults for all pickers on the site.

## Overriding the defaults per field

You don't have to change the site defaults for every case:

- On a **Webform Text field**, add `data-cdp-*` attributes to that element to
  override the range, format, or which calendar view opens first, just for that
  field.
- **Developers** can adjust the resolved options per field with
  `hook_easy_datepicker_options_alter()` — for example to localise the display
  format based on the current language.

## A note on validation

Whichever way a date is entered — typed or picked — Easy Datepicker normalises the
submitted value to `Y-m-d` and rejects invalid or rolled‑over dates (like 02/30)
on the server. That keeps stored data clean regardless of the display format you
chose above.
