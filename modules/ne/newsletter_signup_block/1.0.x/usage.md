<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Newsletter Signup Block gives you drop-in blocks for a newsletter signup form, either a built-in form or one backed by a chosen Webform.

---

The module defines two block plugins: `NewsletterSignupFormBlock` (renders the module's own `NewsletterSignupForm`) and `NewsletterSignupWebformBlock` (embeds a selected Webform). Blocks are configured through the standard Block layout UI with options such as heading text, description, and an image (leveraging the `media`, `image`, `responsive_image`, and `token` dependencies), and styled via the module's library. Webform is a hard dependency.

There are no custom routes or permissions; placement and visibility use core Block access, and submissions are handled either by the built-in form or by the standard Webform submission pipeline (including its own handlers, confirmations, and spam controls). To actually deliver addresses to an email service, pair the Webform variant with a Webform handler for your provider.

---
- Drop a newsletter signup form into any region via Block layout.
- Use a Webform-backed variant to reuse existing form handlers.
- Add a heading and description above the signup field.
- Include a (responsive) image alongside the form.
- Place the signup block in a footer or sidebar sitewide.
- Restrict the block to specific pages with core visibility rules.
- Collect subscribers into Webform submissions.
- Connect to an ESP by attaching a Webform handler.
- Offer a lightweight built-in form when Webform config is overkill.
- Theme the signup block with the bundled library.
- Token-personalise the block's text.
- Show the signup only to anonymous visitors via block visibility.
- Reuse one configured Webform across multiple placements.
- A/B different copy by placing multiple configured blocks.
- Keep signup UI consistent across the site.
- Gather leads without building a form from scratch.
