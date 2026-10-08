<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blink.net Integration is a wrapper for the Blink.net service, exposing donation and subscription widgets as Drupal blocks configured from a central settings form.

Use it to place Blink.net donation or subscription calls-to-action on your site.

---

Install with `composer require drupal/blinknet` and enable it (`drush en blinknet`).

Enter your Blink.net account details at `/admin/config/services/blinknet` (permission `administer blinknet`). Then place the provided blocks - donation button/container and subscription button/container - through Block Layout.

---

- Integrate the Blink.net advertising/donation service.
- Provide a donation button block.
- Provide a donation container block.
- Provide a subscription button block.
- Provide a subscription container block.
- Configure the Blink.net account at `/admin/config/services/blinknet`.
- Gate configuration behind the `administer blinknet` permission.
- Place widgets anywhere via Block Layout.
- Support Drupal 9.3 and Drupal 10.
- Render Blink.net embeds from admin-supplied settings.
- Group settings under the Services admin section.
- Require no content model changes.
- Offer both button and container widget variants.
- Ship functional tests for blocks and the config form.
- Serve as a focused third-party ad/donation integration.
- Let editors position donation/subscription CTAs.
- Keep configuration centralized in one form.