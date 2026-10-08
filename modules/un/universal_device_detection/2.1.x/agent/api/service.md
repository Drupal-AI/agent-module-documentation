<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Detector service (API)

The module's entire public surface is one service. There is no config, no route, no permission,
no hook, no plugin type — you inject the service and call one method.

## Service — `universal_device_detection.default`

- Class: `Drupal\universal_device_detection\Detector\DefaultDetector`
- Interface: `Drupal\universal_device_detection\Detector\DeviceDetectorInterface`
- Constructor arg: `@request_stack` (`Symfony\Component\HttpFoundation\RequestStack`)
- Wiring: `universal_device_detection.services.yml`

```php
// Quick access.
$device = \Drupal::service('universal_device_detection.default')->detect();

// Preferred: constructor-inject the interface.
public function __construct(\Drupal\universal_device_detection\Detector\DeviceDetectorInterface $detector) {
  $this->detector = $detector;
}
```

## Method — `detect($bot = TRUE): array`

Defined in `src/Detector/DefaultDetector.php:43`. Reads the `User-Agent` header from the current
request (falls back to the literal string `'unknown'` when the header is empty) and parses it with
`matomo/device-detector`.

- `$bot = TRUE` (default) — bots are detected and returned as a distinct result (see bot shape
  below). This is the branch where `DeviceDetector::isBot()` is honoured.
- `$bot = FALSE` — calls `skipBotDetection()`, so a crawler is parsed as if it were a normal
  device/browser rather than reported as a bot.

Note: the interface declares `detect($bot)` (no default) while the implementation is
`detect($bot = TRUE)`. Callers relying on the default `TRUE` must call the concrete service (they
do), but treat the argument as required when typing against the interface.

### Return shape — normal device
```php
[
  'type' => 'desktop',        // DeviceDetector::getDeviceName(): 'desktop'|'smartphone'|'tablet'|'tv'|'console'|... (may be '' when unknown)
  'info' => [
    'client' => [             // DeviceDetector::getClient()
      'type' => 'browser',
      'name' => 'Chromium',
      'short_name' => 'CR',
      'version' => '73.0',
      'engine' => 'Blink',
      'engine_version' => '',
    ],
    'os' => [                 // DeviceDetector::getOs()
      'name' => 'Ubuntu',
      'short_name' => 'UBT',
      'version' => '',
      'platform' => 'x64',
    ],
    'brand' => '',            // DeviceDetector::getBrandName()
    'model' => '',            // DeviceDetector::getModel()
  ],
]
```
`type` is `''` and `client`/`os` may be empty/`NULL` when the UA is empty or unrecognised (verified
at runtime under `drush php:eval`, which has no browser UA).

### Return shape — bot (only when `$bot = TRUE`)
```php
[
  'type' => 'bot',            // literal string added by this module
  'info' => [ /* DeviceDetector::getBot(): name, category, url, producer, ... */ ],
]
```

## Per-request cache

The service keeps a `\SplObjectStorage` keyed by the `Request` object (`src/Detector/DefaultDetector.php:27,49,80`),
so repeated `detect()` calls in the same request parse the UA once. It is not a persistent cache —
each request re-parses.

## Caching / render considerations (integrator's responsibility)

The service adds no cache metadata. Any render array, response or block whose output varies by the
detection result MUST declare a matching cache context (Drupal ships `headers:User-Agent`, or use a
narrower custom context) or the internal page cache will serve one visitor's device variant to the
next. The module cannot do this for you because it does not produce output.

## Runtime edge

`detect()` calls `$this->requestStack->getCurrentRequest()` and immediately dereferences
`$request->headers`. In a context with no current request on the stack that would error — call it
only where a request exists (normal web requests, and drush `php:eval` which provides one).
