<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Universal Device Detection wraps Matomo's device-detector library as a Drupal service, so your code can ask what device, browser, operating system, brand and model a request came from.

---

The module is a pure service wrapper: `src/Detector/` plus `universal_device_detection.services.yml`, with `matomo/device-detector ~6` doing the parsing. There is no configuration page, permission, route or block — you install it, then another module or theme injects the service and asks its questions.

**Install** with Composer (this also pulls the required library):

```
composer require drupal/universal_device_detection
drush en universal_device_detection
```

**Configure**: nothing to configure — the module has no settings.

**Use** it from PHP. `detect()` returns an array with a `type` and an `info` sub-array (client, os, brand, model):

```php
$device = \Drupal::service('universal_device_detection.default')->detect();
if ($device['type'] === 'smartphone') {
  // ...
}

// Treat bots as normal devices instead of reporting them as 'bot':
$device = \Drupal::service('universal_device_detection.default')->detect(FALSE);
```

Prefer constructor injection of `Drupal\universal_device_detection\Detector\DeviceDetectorInterface` in real services. Two things to keep in mind: Matomo's library is the serious option in this space (maintained alongside Matomo Analytics, large and current device database), so keep it updated or detection quality decays; and any response that **varies** by the detection result must declare a matching cache context, or Drupal's page cache will serve one device's variant to another visitor. For layout, CSS media queries and responsive images are usually the better tool because they respond to the actual viewport rather than a guess from a user-agent string that browsers increasingly freeze or reduce. Core range is `^9 || ^10 || ^11`.

---

Typical uses:

- Detect whether a request came from a mobile device.
- Identify the browser and version server-side.
- Distinguish tablet from phone traffic.
- Redirect to an app store by platform.
- Log a device breakdown for analytics.
- Detect a TV or console browser.
- Identify device brand and model.
- Serve a different template to bots.
- Report on operating-system usage.
- Detect a crawler in custom code.
- Feed device data into a personalisation rule.
- Replace a hand-rolled user-agent regex.
- Branch business logic on smartphone vs desktop.
- Detect the OS to tailor download instructions.
- Gate a feature that only makes sense on desktop.
- Enrich a log or audit entry with device metadata.
- Segment A/B test buckets by device class.
