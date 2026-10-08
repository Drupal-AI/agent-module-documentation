<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decor (decor) — agent index

Client-side accessibility helper: marks images inside opt-in containers as decorative
(empty `alt`, `role="presentation"`, no `title`) so assistive technologies ignore them.
Satisfies WCAG H67 toward SC 1.1.1 (Non-text Content, Level A).

- **Package:** Accessibility. **License:** GPL-2.0-or-later. **Core:** `^10 || ^11 || ^12`.
- **Dependencies:** none (module); the JS library depends on core `core/drupal` and `core/once`.
- **Composer:** `drupal/decor`. **Configuration:** none — no settings route, no config.
- **Permissions:** none. **Routes/controllers:** none. **Services:** none. **Plugins:** none.
- **PHP:** one hook — `decor_page_attachments()` in `decor.module` attaches the `decor/decor`
  library globally on every page.
- **Library:** `decor.libraries.yml` defines `decor` → `js/decor.js`.
- **Behavior:** `Drupal.behaviors.decor` in `js/decor.js`. Selectors: `.js-decor` (recommended),
  `.js-decorative-image` (legacy), `[data-decor="img"]` (optional). For each `<img>` in a matched
  container it adds class `is-decor`, sets `alt=""` and `role="presentation"`, removes `title`.
  Uses `once('decor-image', …)` to run once per element.

## Solution docs
- [Frontend usage & behavior](frontend/decorative-images.md) — how to mark containers, the
  selectors, what the behavior changes, and how to style/extend it.
