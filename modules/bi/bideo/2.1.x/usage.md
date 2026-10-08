<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Batch Video (bideo) shows a video on the batch API progress screen, so users have something to watch during long-running batch operations.

Use it to make imports, migrations or bulk actions feel less tedious.

---

Install with `composer require drupal/bideo` and enable it (`drush en bideo`).

Configure the video to display at `/admin/config/bideo/settings` (permission `administer site configuration`). The module then injects that video into the batch progress page.

---

- Show a video on the batch progress page.
- Entertain users during long batch operations.
- Provide a settings form at `/admin/config/bideo/settings`.
- Gate configuration behind `administer site configuration`.
- Let an admin choose which video to display.
- Integrate with Drupal's Batch API progress screen.
- Support Drupal 8.8, 9 and 10.
- Require no content model changes.
- Add a light, optional bit of polish to admin UX.
- Keep configuration in module config.
- Avoid affecting batch behavior itself.
- Work with any batch-driven operation.
- Add no front-end footprint outside batch pages.
- Require no external services.
- Provide a single, focused feature.
- Improve perceived wait time during processing.
- Serve as a small UX enhancement module.