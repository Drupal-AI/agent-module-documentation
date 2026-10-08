# Using the FullCalendar libraries

The module defines two libraries in `fullcalendar_library.libraries.yml`. There is no PHP
API, service, or configuration — you consume them purely as Drupal asset libraries.

## The two libraries

| Library id | Contains | Depends on |
|---|---|---|
| `fullcalendar_library/fullcalendar` | `moment.min.js`, `fullcalendar.min.js`, `locale-all.js`, `fullcalendar.min.css` (screen), `fullcalendar.print.min.css` (print) | `core/jquery` |
| `fullcalendar_library/fullcalendar-scheduler` | `scheduler.min.js`, `scheduler.min.css` | `fullcalendar_library/fullcalendar` |

This is **FullCalendar v3** — the runtime API is `jQuery`'s `$('#cal').fullCalendar({...})`,
and it needs Moment.js (bundled). It is *not* the FullCalendar v5/v6 ES-module API.

## Attach it

In a render array (module or controller):

```php
$build['calendar'] = [
  '#markup' => '<div id="my-calendar"></div>',
  '#attached' => ['library' => ['fullcalendar_library/fullcalendar']],
];
```

Or declare a dependency from your own `mytheme.libraries.yml`:

```yaml
my-calendar:
  js:
    js/my-calendar.js: {}
  dependencies:
    - fullcalendar_library/fullcalendar
```

Then in your JS: `$('#my-calendar').fullCalendar({ ... });`.

## Local files vs CDN fallback

Default (declared) asset paths are local, under the **web root**:

```
/libraries/fullcalendar/lib/moment.min.js
/libraries/fullcalendar/fullcalendar.min.js
/libraries/fullcalendar/locale-all.js
/libraries/fullcalendar/fullcalendar.min.css
/libraries/fullcalendar/fullcalendar.print.min.css
/libraries/fullcalendar-scheduler/scheduler.min.js
/libraries/fullcalendar-scheduler/scheduler.min.css
```

`fullcalendar_library_library_info_alter()` checks `file_exists(DRUPAL_ROOT . '/libraries/…')`
for **each** asset. For any file that is missing, it unsets the local entry and adds an
`external` jsDelivr CDN URL instead. So:

- Download the library into `/libraries/fullcalendar/` (and `/libraries/fullcalendar-scheduler/`)
  to self-host — from <https://fullcalendar.io/download/> (v3) and the Scheduler download.
- Do nothing, and the assets load from the CDN:
  - `https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.min.js` (+ `.css`, `.print.min.css`, `locale-all.js`)
  - `https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@1.10.1/dist/scheduler.min.js` (+ `.css`)
  - `https://cdn.jsdelivr.net/npm/moment@2.27.0/moment.min.js`

The fallback is per-file, so a partial local install (e.g. only `fullcalendar.min.js`) uses
local for the present files and CDN for the rest.

## Check which source is active

`fullcalendar_library_requirements('runtime')` reports on `/admin/reports/status`:
- `REQUIREMENT_INFO` "…loaded via CDN" when local files are absent, with a download link;
- `REQUIREMENT_OK` when the local FullCalendar, Scheduler and Moment files are all present.

Programmatically, resolve the definition and inspect the asset paths:

```php
$lib = \Drupal::service('library.discovery')->getLibraryByName('fullcalendar_library', 'fullcalendar');
// $lib['js'] entries' 'data' values are either '/libraries/fullcalendar/…' (local)
// or 'https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/…' (CDN fallback).
```

Call `->clearCachedDefinitions()` on `library.discovery` (or `drush cr`) after adding or
removing files, because library definitions are cached.
