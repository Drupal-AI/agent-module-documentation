<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Specific Class adds CSS classes to the `<body>` tag on chosen pages, driven by a simple "path|class" list in one admin settings form — no theme code required.

---

The module implements `hook_preprocess_html()` to append classes to `$variables['attributes']['class']` (the body tag) based on a single configuration value. All configuration lives in the `page_specific_class.settings` config object under the key **`url_with_class`**, a multi-line string where each line is `/<path>|<class(es)>`. The admin form is at `/admin/config/page-class/settings` (route `page_specific_class.settings`, permission `administer site configuration`). For each line it resolves the entered path and the current path through the path-alias manager and, when they match, adds the class(es) (each cleaned via `Html::cleanCssIdentifier()`). It supports multiple space-separated classes per line, a **wildcard** suffix (`/content/article*` matches every path beginning with `/content/article`), the front page via `/<front>`, and every page via `/*`. Enter one mapping per line; each path must start with `/`, and path and class are separated by `|` (the form validates the leading slash). There are no plugins, permissions of its own, or Drush commands; it ships a config schema for the single string setting.

---

- Add a `landing-page` class to the body on a specific marketing page for custom styling.
- Give one node (`/node/1|special-offer`) a unique body class without editing templates.
- Apply several classes at once to a page (`/pricing|pricing dark compact`).
- Add a `home-page` class to the front page body via `/<front>|home-page`.
- Add a site-wide body class to every page via `/*|has-js-enhancements`.
- Style all article pages with one wildcard rule (`/content/article*|article-theme`).
- Tag a whole section of the site (`/products*|products-section`) for section-specific CSS.
- Target a URL alias (the module resolves aliases to internal paths) rather than the raw system path.
- Give a campaign path a temporary body class you can remove later by editing one line.
- Differentiate print/landing/microsite pages by body class for theme overrides.
- Add JS-hook classes to the body so scripts can behave differently per page.
- Provide editors a code-free way to request per-page body classes.
- Apply a `no-sidebar` body class to selected pages to trigger a layout variation.
- Add A/B-test marker classes to specific pages.
- Class the login or user pages distinctly for custom theming.
- Add a `dark` body class to a set of pages under one path prefix.
- Keep per-page styling in configuration (exportable) instead of scattered template logic.
- Add classes to Views pages, custom-route pages, or node pages uniformly.
- Roll out a seasonal/holiday body class to the whole site with a single `/*` line.
- Combine page-specific and global classes by listing multiple lines.
- Quickly prototype page-specific CSS during design without a theme deploy.
- Remove a page's special class by deleting its line and re-saving the form.
