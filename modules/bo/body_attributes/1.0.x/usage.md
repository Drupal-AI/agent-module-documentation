Add CSS classes or named HTML attributes to the html, body, header, main, footer, or any custom CSS selector on Drupal pages using rule-based configuration with per-path and per-node-type visibility conditions.

---

Body Attributes provides a `body_attribute_rule` configuration entity managed at Configuration > User Interface > Body Attributes (`/admin/config/user-interface/body-attributes`). Each rule picks a target zone (`html`, `body`, `header`, `main`, `footer`, or a custom CSS selector), chooses whether it adds a class or a named HTML attribute, supplies the value, and optionally limits itself to certain request paths or node bundles. Rules whose zone is `html` or `body` are merged into core's `html_attributes` / `attributes` render variables during `hook_preprocess_html()` using Drupal's `Attribute` object; rules whose zone is `header`, `main`, `footer`, or a custom selector are shipped to the browser via `drupalSettings` and applied by a lightweight `Drupal.behaviors` script. Rules carry a weight for ordering and an enabled/disabled status. All rule management is gated by the `administer body attributes` permission. The module also always attaches a set of automatic diagnostic `data-*` attributes (role, route, node type/id, path alias) to every page's body tag.

---

- Add a persistent CSS class such as `has-sticky-header` to the `<body>` tag site-wide.
- Add a `data-theme="dark"` attribute to the `<html>` tag to drive a CSS/JS theme switch.
- Tag the `<body>` with a `data-section` attribute only on paths under `/blog/*`.
- Apply an `is-landing` class to `<body>` only on the `landing_page` content type.
- Add an `aria-label` attribute to the `<main>` element for accessibility tooling.
- Add a marketing/AB-test class to `<body>` on a specific campaign path.
- Give the `<footer>` a `data-analytics-zone` attribute consumed by a tracking script.
- Add a `dir` or `lang`-style helper attribute to `<html>` for a section of the site.
- Apply a `print-optimized` class to `<body>` on documentation pages.
- Tag article pages with `data-content-type="article"` for CSS targeting.
- Add a custom class to any element matched by a CSS selector like `.node--type-article`.
- Drive a full-width layout by adding a `layout-fluid` class to `<body>` on selected paths.
- Add `data-*` hooks that a decoupled front-end or third-party widget reads at runtime.
- Toggle a high-contrast class on `<body>` for a specific set of pages.
- Add a `data-node-id`-style attribute for CSS/JS that must know the current node.
- Set an attribute on `<header>` so a sticky-nav script can find its target reliably.
- Order multiple competing rules deterministically by setting each rule's weight.
- Temporarily disable a rule (without deleting it) by toggling its Enabled checkbox.
- Combine a path condition and a node-type condition (rule applies if either matches).
- Apply a body class across an entire URL pattern using wildcard paths (e.g. `/products/*`).
- Add classes that a design system expects on structural wrappers without editing templates.
- Provide per-section theming hooks to a base theme without a subtheme or template override.
- Add attributes to elements outside the theme's Twig control by targeting a CSS selector.
- Roll out a site-wide body class change through configuration instead of a code deploy.
