<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery Waypoints (waypoints) — agent index

Packages the **jQuery Waypoints** library (v4.0.1, MIT) as the Drupal asset library
`waypoints/waypoints`. Waypoints fires a callback when an element reaches a scroll position.
Version **2.2.0**. Core `^10.1 || ^11 || ^12`. Package: *User interface*.

## What it actually is
A thin library wrapper with a one-checkbox admin form — not a zero-config declaration.

- **Asset library** (`waypoints.libraries.yml`): library `waypoints`, whose only JS is
  `/libraries/waypoints/lib/jquery.waypoints.min.js`. The file is **loaded locally** from the
  site's `/libraries` directory (installed via Composer package `levmyshkin/waypoints ^4.0`, or
  manually). **No CDN.** The library does **not** declare a `core/jquery` dependency, so jQuery-
  dependent consumers must attach `core/jquery` themselves.
- **Settings form** `src/Form/SettingsForm.php` at `/admin/config/user-interface/waypoints`
  (route `waypoints.settings_form`), a single checkbox `waypoints_always_add_js`
  ("Always include JavaScript file to the site"). Config object `waypoints.settings`
  (schema: integer). Deleted on uninstall.
- **Permission** `configure waypoints module` (`restrict access: true`) — the only permission,
  gates the settings route.
- **Hook** `src/Hook/WaypointsHooks.php` — `hook_page_attachments` attaches
  `waypoints/waypoints` on **every** page **only when** `waypoints_always_add_js` is truthy.
  `waypoints.module` is a `#[LegacyHook]` shim delegating to the class-based hook (autowired
  service in `waypoints.services.yml`).

If the checkbox is off, the module attaches nothing — other themes/modules attach
`waypoints/waypoints` from their own render arrays / `#attached`.

## Pause before adopting it: the platform has replaced this.
**`IntersectionObserver`** is supported everywhere that matters and does the same job better:
- **Waypoints listens to scroll events and measures positions** — running code on the **main
  thread on every scroll frame**;
- **`IntersectionObserver` is asynchronous and computed off the main thread**.

On a phone that is the difference between a page that scrolls smoothly and one that **stutters**.

## Two further points, whichever mechanism is used
1. **Scroll-triggered animation must respect `prefers-reduced-motion`** — content moving on its
   own causes real symptoms for a substantial number of people.
2. **Content revealed on scroll must exist without the script**, or a failed load leaves a
   **blank page**. "Visible by default, enhanced when the script runs" is the safe pattern.

Legitimate patterns: compact header after the hero, count-up statistics, sticky sidebar
releasing at the footer, scrollspy navigation, infinite-scroll trigger (Views Load More
integrates with this module).

See `../usage.md` for the use-case list and `../data.json` for metadata.
