# Fullcalendar library — manual setup guide

**Fullcalendar library** (`fullcalendar_library`) registers the classic
**FullCalendar v3** JavaScript calendar — and its optional **Scheduler** add‑on —
as Drupal asset libraries, so other modules and themes can attach them without
bundling the calendar files themselves. It is a developer/site‑builder building
block, not something with a visible interface of its own.

The problem it solves is duplication: several contrib modules (and plenty of
custom code) want to render an interactive FullCalendar, but none of them should
have to ship the calendar's JavaScript and CSS. This module provides those assets
once, as two named libraries, and everything else depends on them. It even works
with nothing downloaded — if the local library files are absent it automatically
falls back to a pinned jsDelivr **CDN** copy, so a calendar renders on a fresh
install.

There is essentially nothing to configure: the module has **no routes, settings,
permissions, plugins, or Drush commands**. Enabling it simply makes the libraries
available to attach. It has no other module dependencies and ships no submodules.
One important caveat: this is the **legacy FullCalendar v3 API**
(`$('#cal').fullCalendar({…})` with Moment.js), *not* the modern v5/v6 ES‑module
API — reach for it only when you specifically need FullCalendar 3.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) self‑host the library files.

## Where it lives in the admin menu

The module has no admin page. The only place it surfaces is **Reports → Status
report** (`/admin/reports/status`), which tells you whether the calendar assets
are being served from a local `/libraries/…` copy or from the CDN fallback.

## How to use it

This is a library provider, so you consume it from code. There are two libraries:

- **`fullcalendar_library/fullcalendar`** — FullCalendar v3 core plus Moment.js and
  all locales (depends on `core/jquery`).
- **`fullcalendar_library/fullcalendar-scheduler`** — the Scheduler (timeline /
  resource) add‑on, which depends on the core library above.

Attach one from a render array:

```php
$build['calendar'] = [
  '#markup' => '<div id="my-calendar"></div>',
  '#attached' => ['library' => ['fullcalendar_library/fullcalendar']],
];
```

Or declare it as a dependency in your own `*.libraries.yml`:

```yaml
my-calendar:
  js:
    js/my-calendar.js: {}
  dependencies:
    - fullcalendar_library/fullcalendar
```

Then initialise the calendar in your JavaScript with the v3 API:
`$('#my-calendar').fullCalendar({ ... });`.

### Local files vs the CDN fallback

By default the module looks for the library files under your web root at
`/libraries/fullcalendar/` and `/libraries/fullcalendar-scheduler/`. For any file
that is missing, it substitutes an equivalent jsDelivr CDN URL (FullCalendar
3.10.2, Scheduler 1.10.1, Moment 2.27.0), file by file. So you can either
self‑host by downloading the library into those folders (good for offline or
CDN‑free deployments) or do nothing and let the assets load from the CDN. The
status report confirms which source is active. See
[Installation](installation/index.md) for the download details.
