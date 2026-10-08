<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Suite DSFR Feature adds extra ready-made blocks and helpers on top of the UI Suite DSFR theme (the French State Design System / DSFR implemented with UI Patterns).
---
The module ships four UI Patterns-backed blocks — a display button, a display modal, a consent banner, and a footer-top block — that site builders can place through Drupal's block layout, letting them compose DSFR components without hand-writing Twig. It also provides an admin-only SVG picker: an autocomplete route that recursively scans the theme's SVG icon directory so editors can search and select icon file paths when configuring the modal/button blocks. A `hook_requirements` check enforces that the `ui_suite_dsfr` theme is enabled and at a recent enough version (newer than 1.0.0-rc3), surfacing an error on the status report otherwise.

The security surface is small and admin-scoped. The single route, `/admin/ui-suite-dsfr-fr/autocomplete/svg`, is gated by `administer site configuration`, returns JSON, and passes the search term through `Xss::filter` before matching filenames under a fixed base directory (no user-controlled path). The module defines no permissions of its own and performs no data mutation or external requests; it depends on `ui_patterns` and expects the `ui_suite_dsfr` theme. Typical setup: enable the theme, enable this module, then place the desired blocks and pick icons via the autocomplete.
---
- Place a DSFR display button block via Block layout.
- Place a DSFR modal block and select its icon with the SVG autocomplete.
- Add a DSFR consent banner block to the site.
- Add a DSFR footer-top block region content.
- Search available DSFR SVG icons by filename through the autocomplete endpoint.
- Compose DSFR components without writing custom Twig templates.
- Verify the required `ui_suite_dsfr` theme is enabled via the status report check.
- Enforce a minimum DSFR theme version (newer than 1.0.0-rc3).
- Configure modal content and trigger button through block settings.
- Reuse UI Patterns components provided by the DSFR suite in block form.
- Restrict icon-picker access to site administrators.
- Extend a DSFR-themed French public-sector site with prebuilt interactive blocks.
- Place multiple DSFR blocks across different regions of a page.
- Return JSON icon suggestions for a modal/button configuration form.
- Sanitize the icon search term with `Xss::filter` before matching.
- Build GDPR-style consent messaging with the consent banner block.