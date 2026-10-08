<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Newsletter Signup Block (newsletter_signup_block) — agent index

**Drop-in blocks for a newsletter signup form: a built-in form block and a Webform-backed block, with configurable heading, description, and image.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Depends:** webform:webform, drupal:media, drupal:image, drupal:responsive_image, drupal:token
- **Configure:** via Block layout (no dedicated admin route).

**Surface:** block plugins `NewsletterSignupFormBlock` (built-in `NewsletterSignupForm`) and `NewsletterSignupWebformBlock` (embeds a chosen Webform); a library. No custom routes or permissions.

**Security:** no custom endpoints; placement/visibility via core Block access; submissions handled by the built-in form or standard Webform pipeline (use Webform's spam/handler features). Delivery to an ESP requires a Webform handler.
