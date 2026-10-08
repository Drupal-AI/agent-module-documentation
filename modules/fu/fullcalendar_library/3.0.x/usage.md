Fullcalendar library registers the FullCalendar (v3) JavaScript calendar library and its Scheduler add-on as Drupal asset libraries, so other modules and themes can attach them without bundling the files themselves.

---

The module is a thin asset-library provider: it has no routes, no settings, no permissions, no plugins and no configuration. Its `fullcalendar_library.libraries.yml` declares two libraries, `fullcalendar_library/fullcalendar` (FullCalendar v3 core plus `moment.js` and `locale-all.js`, depending on `core/jquery`) and `fullcalendar_library/fullcalendar-scheduler` (the commercial Scheduler add-on, which depends on the core library). By default the libraries point at local files under the web root's `/libraries/fullcalendar/` and `/libraries/fullcalendar-scheduler/` directories. If those files are missing, `hook_library_info_alter()` in `fullcalendar_library.module` swaps each missing asset for an equivalent jsDelivr CDN URL (FullCalendar 3.10.2, Scheduler 1.10.1, Moment 2.27.0), so the library works out of the box even with nothing downloaded. A `hook_requirements()` reports on the status page whether the local copy or the CDN fallback is in use. To consume it, a module or theme attaches `fullcalendar_library/fullcalendar` to a render array (or lists it as a dependency of its own library) and initializes a calendar in its own JavaScript. Note this ships the legacy FullCalendar v3 API (`$.fullCalendar(...)`), not the modern v5/v6 ES module API.

---

- Attach the FullCalendar v3 library to a custom block or page so your JavaScript can render an interactive calendar.
- Provide the FullCalendar assets for the contrib `fullcalendar` (view style) module or another calendar integration that depends on this library.
- Depend on `fullcalendar_library/fullcalendar` from your own `*.libraries.yml` instead of shipping the calendar JS/CSS in your theme.
- Render a month/week/day event calendar in a custom Drupal module without vendoring FullCalendar yourself.
- Use the bundled `moment.js` for date handling that FullCalendar v3 relies on.
- Add the FullCalendar Scheduler (timeline / resource) views by attaching `fullcalendar_library/fullcalendar-scheduler`.
- Serve FullCalendar from a local `/libraries/fullcalendar/` copy for offline, air-gapped, or CDN-free deployments.
- Fall back automatically to the jsDelivr CDN when no local library files are present, so the calendar still works on a fresh install.
- Pin a specific known-good FullCalendar 3.10.2 / Scheduler 1.10.1 / Moment 2.27.0 combination via the CDN fallback URLs.
- Load all FullCalendar locales at once via `locale-all.js` so calendars can switch languages.
- Include the print stylesheet (`fullcalendar.print.min.css`, `media: print`) for printer-friendly calendar output.
- Check the site status report to confirm whether FullCalendar is served locally or via CDN.
- Standardize on one shared FullCalendar library across several custom modules on a site.
- Build an events booking or scheduling UI on top of the FullCalendar v3 API.
- Display a read-only calendar of nodes/dates by feeding events into FullCalendar from a custom controller (JSON endpoint).
- Reuse the jQuery dependency FullCalendar needs, already declared by the library.
- Keep the calendar library upgrade decoupled from your custom code by swapping the files under `/libraries`.
- Support Drupal 9.4, 10, and 11 sites needing the classic FullCalendar 3 widget.
- Provide the calendar assets required by legacy modules written against FullCalendar v3.
- Add a resource/timeline scheduler view for room or staff booking using the Scheduler add-on.
- Avoid committing large minified vendor JS into your project repository by relying on the CDN fallback.
