<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mobile Detect wraps the `mobiledetect/mobiledetectlib` PHP library as a Drupal service, so themes, Twig templates and block-visibility conditions can react to whether the visitor is on a mobile, tablet, iOS or Android device (based on the User-Agent).

---

The module exposes the library's `Detection\MobileDetect` object as the `mobile_detect` service and adds a Twig extension with `is_mobile()`, `is_tablet()`, `is_device()`, `is_ios()` and `is_android_os()` functions for use directly in templates. It registers three cache contexts — `mobile_detect_is_mobile`, `mobile_detect_device_type` and `mobile_detect_platform` — so pages varying by device are cached separately, and it adds `is-mobile` / `is-tablet` classes to the `<body>` via `hook_preprocess_html()`. For site building it provides two block-visibility **Condition** plugins (`mobile_detect_device_type` and `mobile_detect_platform`) plus a "Mobile Detect Status" block that shows the detected library version/state. A small settings form at `/admin/config/user-interface/mobile-detect` (config object `mobile_detect.settings`) has one experimental toggle, `mobile_detect_is_mobile`, that adds the is-mobile page cache context globally; access is gated by the `administer mobile_detect configuration` permission. Detection is **server-side, User-Agent based** — it is not a substitute for responsive CSS, and User-Agent spoofing or shared caches can affect results; combine it with the provided cache contexts to stay cache-correct.

---

- Show or hide a block only on mobile phones using the `mobile_detect_device_type` condition.
- Restrict a block to a specific platform (iOS/Android) with the `mobile_detect_platform` condition.
- Branch Twig template markup with `{% if is_mobile() %}…{% endif %}`.
- Render a tablet-specific layout via `{% if is_tablet() %}` in a template.
- Serve iOS-only content (e.g. an App Store badge) with `{% if is_ios() %}`.
- Serve Android-only content (e.g. a Play Store badge) with `{% if is_android_os() %}`.
- Detect a specific device model in Twig with `is_device('iPhone')`.
- Style the page differently on mobile using the auto-added `is-mobile` / `is-tablet` body classes.
- Read device state in custom PHP via `\Drupal::service('mobile_detect')->isMobile()`.
- Keep render caching correct across devices with the `mobile_detect_is_mobile` cache context.
- Vary a cached render array by device type using the `mobile_detect_device_type` cache context.
- Vary output by platform using the `mobile_detect_platform` cache context.
- Place the "Mobile Detect Status" block to confirm detection is working on a page.
- Enable the experimental global is-mobile page cache context from the settings form.
- Hide heavy desktop-only widgets (maps, videos) from phone users.
- Show a "download our app" call-to-action only to mobile visitors.
- Simplify navigation for mobile users by swapping a menu block via a visibility condition.
- Provide a mobile-only phone-call link block.
- Gate a full-screen desktop hero image so phones get a lighter block.
- Drive device-specific analytics or messaging from a Twig condition.
- Add per-device body classes for a theme's SCSS to target without JavaScript.
- Combine device conditions with other block visibility rules for fine-grained targeting.
- Detect mobile in a preprocess function to alter a paragraph's render output.
- Confirm which Mobile_Detect library version is active via the status block.
