# CKEditor 5 "Date iCalendar" button

The module ships a CKEditor 5 plugin that lets editors insert an "Add to calendar" download
link (a `<time class="date-ical">` element) into body text.

## Enable it
1. Ensure core **CKEditor 5** is the text editor for a text format
   (`/admin/config/content/formats`).
2. Drag the **Date iCalendar** button into the toolbar.
3. Configure which event fields the dialog collects (checkboxes): Description, Location,
   Categories, Organizer, URL. Defaults are all off.
4. Allow the `<time class="date-ical">` element in the format's allowed HTML (the plugin
   declares `<time>` and `<time class="date-ical">` as its elements).

## Wiring (for maintainers)
- Definition: `date_ical.ckeditor5.yml` (`date_ical_plugin`) — JS plugin `dateIcal.DateIcal`,
  toolbar item `dateIcal`, PHP class below.
- PHP: `src/Plugin/CKEditor5Plugin/DateICal.php` (`CKEditor5PluginConfigurableInterface`) stores
  the five checkbox settings (schema `ckeditor5.plugin.date_ical_plugin` in
  `config/schema/date_ical.schema.yml`) and, in `getDynamicPluginConfig()`, injects the
  `date_ical.download` route URL so the JS knows where to POST/GET the generated event.
- JS: `js/build/dateIcal.js` (built) with sources under `js/ckeditor5_plugins/dateIcal/src/`;
  library `date_ical/date_ical` (`date_ical.libraries.yml`), plus `date_ical/admin.date_ical`
  CSS for the toolbar icon.

At runtime the inserted link points at `/date-ical/download` with the event details as query
params; that endpoint validates inputs and returns an `event.ics` attachment — see
[../configure/formatter.md](../configure/formatter.md) and [../api/service.md](../api/service.md).
