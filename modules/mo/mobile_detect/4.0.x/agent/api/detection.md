<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Detection API — service, Twig, cache contexts, body classes

## The `mobile_detect` service

`services.yml` registers `mobile_detect` as the library class `Detection\MobileDetect`
(from `mobiledetect/mobiledetectlib`). Call any library method:

```php
$detect = \Drupal::service('mobile_detect');
if ($detect->isMobile()) { … }
if ($detect->isTablet()) { … }
$isIphone = $detect->is('iPhone');
```

Detection reads the current request's **User-Agent** (server-side). Always pair
device-varying output with the cache contexts below, or caching will serve the wrong variant.

## Twig functions

Twig extension `mobile_detect.twig.extension` (`MobileDetectTwig`) exposes:

| Function | Returns |
|---|---|
| `is_mobile()` | TRUE on phones (and other mobile). |
| `is_tablet()` | TRUE on tablets. |
| `is_device('Name')` | TRUE if the named device matches (e.g. `iPhone`). |
| `is_ios()` | TRUE on iOS. |
| `is_android_os()` | TRUE on Android. |

```twig
{% if is_mobile() and not is_tablet() %}
  <a href="tel:…">Call us</a>
{% endif %}
{% if is_ios() %}{{ 'App Store'|t }}{% endif %}
```

## Cache contexts

Three contexts (services tagged `cache.context`) let render arrays vary by device:

- `mobile_detect_is_mobile` — split cache by mobile vs not.
- `mobile_detect_device_type` — split by device type (mobile/tablet/computer).
- `mobile_detect_platform` — split by platform (iOS/Android/…).

Add to a render array: `$build['#cache']['contexts'][] = 'mobile_detect_is_mobile';`.

## Automatic body classes

`hook_preprocess_html()` adds the `mobile_detect_is_mobile` cache context and, when detected,
the classes `is-mobile` and `is-tablet` to `<body>` — target them in theme CSS without JS.
`hook_preprocess_paragraph()` likewise adds the is-mobile cache context to paragraphs.
