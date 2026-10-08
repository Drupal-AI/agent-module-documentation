<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Universal Device Detection (universal_device_detection) — agent index

A thin service wrapper around **`matomo/device-detector ~6`**. It exposes one service,
`universal_device_detection.default`, with one method, `detect($bot = TRUE)`, which reads the
current request's `User-Agent` header and returns a structured array describing the device type,
client (browser), operating system, brand and model. That is the module's entire surface — no
routes, no permissions, no config page, no blocks, no hooks, no plugin types. Enabling it alone
does nothing; another module or theme injects the service and queries it.

The parse runs against Matomo's library (maintained alongside Matomo Analytics with a current
device database), and the result is memoised per request in an `\SplObjectStorage` keyed by the
`Request` object. Two things matter when you use it: (1) declare a cache context on anything that
varies by the result, or the page cache leaks one visitor's device variant to the next; (2) for
layout, CSS media queries / responsive images are usually the better tool — server-side UA parsing
earns its place for analytics, app-store redirects, and decisions CSS cannot make.

- Depends on: nothing (no `dependencies:` in info.yml).
- Core: `^9 || ^10 || ^11`.
- Package: `Utility`.
- Library: `matomo/device-detector ~6` (composer.json `require`).
- Settings page / configure route: none. Permissions: none. Drush: none. Plugin types: none.
  Config schema: none.

## What you'd do → where
- Call the detector from PHP / inject it, and read the return shape → [api/service.md](api/service.md)
- Handle bots vs. normal devices (`detect(FALSE)`) → [api/service.md](api/service.md)
- Get the cache-context / caching guidance for device-varying output → [api/service.md](api/service.md)

## Key facts (real machine names)
- Service id: `universal_device_detection.default` → `Drupal\universal_device_detection\Detector\DefaultDetector` (arg `@request_stack`).
- Interface: `Drupal\universal_device_detection\Detector\DeviceDetectorInterface`.
- Method: `detect($bot = TRUE): array` — returns `['type' => …, 'info' => […]]`.
- Wiring: `universal_device_detection.services.yml`. Source: `src/Detector/`.
- Underlying class: `\DeviceDetector\DeviceDetector` from `matomo/device-detector`.
