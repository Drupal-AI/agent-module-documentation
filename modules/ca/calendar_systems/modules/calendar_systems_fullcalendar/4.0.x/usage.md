Calendar Systems FullCalendar swaps the FullCalendar module's JavaScript library for a Jalali-ready FullCalendar build so event calendars render in the Persian/Jalali calendar.

---

This is a thin JS-override glue submodule. Via `hook_js_alter` (`calendar_systems_fullcalendar_js_alter`) it removes the FullCalendar module's default `fullcalendar.library` JS asset from the page, and its own `calendar_systems_fullcalendar` library loads `calendar_systems_fullcalendar.js` in its place. Per the submodule README you install the Jalali-ready FullCalendar library (the `fullcalendar-Jalaali-drupal-ready` build) instead of the upstream one, following the FullCalendar module's library-install instructions. It depends on `calendar_systems` and the contrib `fullcalendar` module and provides no config, permissions, routes, or Drush commands.

---

- Render a FullCalendar-based event calendar in the Persian/Jalali calendar.
- Show Views-driven event calendars with Jalali month/day labels.
- Replace the default FullCalendar JS with a Jalali-aware build site-wide.
- Give Farsi-language sites a localized month grid / agenda view.
- Reuse an existing FullCalendar View without switching calendar plugins manually.
- Keep event calendars consistent with the rest of a Calendar Systems (Jalali) site.
- Support Shamsi date navigation (prev/next month) in the calendar widget.
- Avoid loading the upstream Gregorian FullCalendar library when Jalali is required.
- Provide a drop-in Jalali calendar for event/content-date displays.
- Pair with Calendar Systems' date localization so event dates and the grid match.
- Localize calendar headers and weekday names for Persian audiences.
- Serve the Jalali FullCalendar build from the site's libraries directory.
- Integrate Jalali calendars into dashboards or landing pages via a calendar View block.
- Migrate an existing Gregorian FullCalendar setup to Jalali by enabling this submodule and swapping the library.
- Present recurring or multi-day events on a Shamsi month grid.
