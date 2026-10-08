<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blurhash computes BlurHash strings for image attachments and uses them to show a colorful blurred preview in place of an image until it finishes loading.

Use it to improve perceived load performance and avoid layout flashes on image-heavy pages.

---

Install with `composer require drupal/blurhash` and enable it (`drush en blurhash`).

The module exposes a Blurhash service that encodes images into BlurHash placeholders; integrate it into image display so the blurred preview renders first and is replaced by the real image on load.

---

- Generate BlurHash placeholders for images.
- Show a blurred colorful preview before the image loads.
- Reduce perceived load time on image-heavy pages.
- Avoid empty/blank space during image loading.
- Provide a reusable Blurhash encoding service.
- Encode images into compact BlurHash strings.
- Improve visual stability while images stream in.
- Support Drupal 9 and Drupal 10.
- Work as a media/image enhancement.
- Complement lazy-loading strategies.
- Require no content model changes.
- Keep placeholders tiny compared to real images.
- Serve as a progressive image-loading aid.
- Integrate with image rendering pipelines.
- Provide colorful, recognizable previews.
- Add no anonymous routes or permissions.
- Enhance front-end UX for image galleries.