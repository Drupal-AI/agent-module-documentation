<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layouts (lbl) adds multiple configurable default layouts plus responsive settings to Layout Builder.

---

The module registers a set of layout plugins (via `.layouts.yml`), declares breakpoints, and provides a `CssGenerator` service that emits per-layout CSS driven by the theme's breakpoints so sections respond across viewports. It is a site-building/presentation helper - layouts, templates, and generated CSS only - with no routes or entities; placement is governed by core Layout Builder access.

---

- Add multiple default layouts to Layout Builder.
- Configure per-layout settings and options.
- Generate responsive CSS from theme breakpoints.
- Provide breakpoint-aware section layouts.
- Use a `CssGenerator` service for layout styling.
- Give site builders richer structural choices.
- Compose responsive pages without custom code.
- Extend core Layout Discovery / Layout Builder.
- Ship Twig templates for the provided layouts.
- Reuse consistent layouts across content.
- Adapt column arrangements per breakpoint.
- Support Drupal 9 and 10.
- Rely on core Layout Builder for access control.
- Standardize responsive section structure.
- Reduce bespoke CSS for common layouts.
- Build landing pages from provided layouts.
