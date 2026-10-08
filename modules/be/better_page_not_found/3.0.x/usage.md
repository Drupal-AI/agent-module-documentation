<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Page Not Found swaps the content region of Drupal's core 401, 403 and 404 error pages for a small themed message and a homepage/login button, without touching the rest of the theme.

---

Better Page Not Found is a presentation-only module for Drupal's built-in error pages. Using a `hook_preprocess_page` implementation it detects the `system.401`, `system.403` and `system.404` routes and replaces `$variables['page']['content']` with a `better_system_message` theme element that renders a fixed, translatable message plus a call-to-action button. The 404 page shows "The requested page could not be found."; the 401 and 403 pages show "Sorry, you are not authorized to access this page." The button links to the homepage by default; a single settings form (`/admin/config/user-interface/better-page-not-found`, gated by `administer site configuration`) lets an administrator switch the 401/403 button to point at the user login page instead. A CSS library is attached only on those error routes, exposing `.c-system-message`, `.c-system-message__text` and `.c-system-message__button` classes for theme overrides. It has no dependencies beyond core, ships no entities, permissions, services or plugins, and does not change any access decision — a 403 is still a 403, only its rendering changes.

---

- Give core 404 "page not found" pages a branded, styled message instead of plain output.
- Style 403 "access denied" pages consistently with the site theme.
- Style 401 "unauthorized" pages the same way.
- Keep the site header, footer and theme intact on error pages (only the content region is replaced).
- Show visitors a clear "The requested page could not be found." message on 404s.
- Show a "Sorry, you are not authorized to access this page." message on 401/403s.
- Offer a "Go to homepage" button beneath the error message to help users recover.
- Switch the access-denied button to a "Go to login page" link so anonymous users can authenticate.
- Point unauthorized visitors straight at `/user/login` after they hit a protected page.
- Configure the access-denied button target from a simple admin radios form.
- Override error-page look by targeting `.c-system-message` and its child classes in a custom theme.
- Restyle the message text size/color via `.c-system-message__text`.
- Restyle the recovery button via `.c-system-message__button`.
- Provide branded error pages on Drupal 8, 9, 10 or 11 with one module.
- Improve the UX of error pages without writing a custom preprocess hook.
- Ship error-page styling that only loads CSS on the error routes, not site-wide.
- Standardize error-page messaging across a multisite or multi-theme install.
- Replace core's terse error output during a site relaunch or rebrand.
- Provide a lightweight alternative to full custom error-page node routing.
- Keep error handling dependency-free (core only, no external services).
