<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An ImageKit video provider for the Video style module.

---

Video style: ImageKit registers an `imagekit` video provider for the Video style module, so video-style renditions and delivery URLs are generated through ImageKit's video CDN and transformation service. Drupal-managed source videos are scheduled for asynchronous upload to ImageKit on first delivery request, failed work is retried through cron and Queue API workers, and the original Drupal file is always kept as the last `<source>` fallback. Derived video URLs are built at delivery time via the official ImageKit PHP SDK; delivery reads are network-free and resolve against a shared asset registry.

ImageKit account credentials (public key, private key, URL endpoint) are read from `settings.php` or `settings.local.php`. The admin page at `/admin/config/media/video-styles/imagekit` shows runtime status, setup instructions, and the Drupal-managed upload method (binary, base64, or fetch-from-public-URL). Each video style chooses between H.264, VP9, and AV1 output and ImageKit-native poster controls (crop method, crop mode, focus area, frame timestamp). Version 1.1.1 adds intrinsic source video metadata (width, height, duration) captured from the ImageKit upload response. Requires `video_style` 1.1.1+; supports Drupal 11.3+ and 12.

---

- Provide an `imagekit` video provider plugin.
- Extend the Video style module.
- Generate ImageKit delivery URLs via the PHP SDK.
- Offload video processing to ImageKit.
- Use ImageKit's video CDN and transformations.
- Schedule asynchronous uploads with cron and Queue workers.
- Keep the original Drupal file as a fallback source.
- Read credentials from `settings.php`/`settings.local.php`.
- Choose binary, base64, or public-URL upload.
- Select H.264, VP9, or AV1 output.
- Control poster crop, focus, and frame timestamp.
- Deliver posters as remote URLs or local Drupal files.
- Capture intrinsic source metadata (1.1.1).
- Depend on `video_style` 1.1.1+.
- Support Drupal 11.3+ and 12.
