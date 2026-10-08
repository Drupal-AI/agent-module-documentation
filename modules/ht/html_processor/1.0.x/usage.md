<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Processor offers shared services for processing and sanitizing HTML.

---

HTML Processor provides reusable services for processing and sanitizing HTML — a common building block for modules that need to clean, transform, or normalize HTML markup consistently (e.g. before storage or display). It centralizes HTML handling so other modules don't reimplement sanitization.

Administration is gated by `administer html_processor settings`. It's a developer/service module; correct sanitization configuration matters for XSS safety, so review its settings. Supports Drupal 10.4+ and 11.

---

- Provide HTML processing services.
- Offer HTML sanitizer services.
- Clean and normalize markup.
- Centralize HTML handling.
- Let modules reuse sanitization.
- Transform HTML consistently.
- Gate settings with `administer html_processor settings`.
- Matter for XSS safety.
- Review sanitization settings.
- Support Drupal 10.4+ and 11.
- Act as a service module.
- Underpin document_loader_html_processor.
- Normalize HTML before storage/display.
- Provide reusable plumbing.
- Configure processing rules.
- Sanitize untrusted HTML.
- Support HTML pipelines.
- Reduce reimplementation.
