<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Style guide generates a live preview page rendering common theme elements — typography, tables, forms, links, lists, images, menus and more — in each active theme, so front-end developers can proof that everything is styled consistently.

---

Visiting **/admin/appearance/styleguide** (route `styleguide.page`, permission `view style guides`) shows a style guide for the current default theme; the module also generates a route per enabled, non-hidden theme (`styleguide.<theme>` and a matching maintenance-page preview `styleguide.maintenance_page.<theme>`) via a dynamic `route_callbacks` handler (`StyleguideRoutes`), surfaced as tabs. A **theme negotiator** (`theme.negotiator.styleguide`, `StyleguideThemeNegotiator`) forces the page to render in the theme named in the route so you see real, themed output. The set of previewed elements is built by **Styleguide plugins**: a plugin type discovered under `Plugin/Styleguide` (plugin manager `plugin.manager.styleguide`, interface `StyleguideInterface` with a single `items()` method, base class `StyleguidePluginBase`, generic `@Plugin` annotation, alter hook `styleguide_info`). The module ships seven plugins — `default_styleguide`, `comment_styleguide`, `filter_styleguide`, `image_styleguide`, `layout_styleguide`, `search_styleguide`, `views_styleguide` — and a `styleguide.generator` service produces sample content (text, links, images). Other modules add or modify entries by implementing a Styleguide plugin or `hook_styleguide_alter(&$items)`, and themers can override the four theme hooks (`styleguide_header`, `styleguide_links`, `styleguide_item`, `styleguide_content`). It stores no configuration of its own (no settings form, no config schema, no Drush).

---

- Proof a custom theme's typography, headings, and text styles on one page.
- Verify tables, forms, buttons, and inputs are styled consistently.
- Preview list, blockquote, and inline-element styling while theming.
- Compare how the same elements render across multiple enabled themes.
- Catch unstyled or broken elements before launch.
- Review link, menu, and breadcrumb styling in context.
- Check image and image-caption rendering with sample content.
- Preview the maintenance page appearance per theme.
- Give designers a single reference page of themed components.
- Use as a lightweight pattern/component library for a Drupal theme.
- Add your module's own elements to the guide via a Styleguide plugin.
- Alter or remove specific preview items with `hook_styleguide_alter()`.
- QA a theme upgrade by diffing the style guide before and after.
- Onboard new front-end developers to a project's component styles.
- Validate CSS refactors didn't regress common elements.
- Preview Views output styling via the bundled `views_styleguide` plugin.
- Check comment and filter (text-format) element styling.
- Confirm responsive behavior of common elements at different widths.
- Provide stakeholders a themed preview without needing real content.
- Restrict guide access to developers via the `view style guides` permission.
- Render the guide in a specific theme using its dedicated route/tab.
- Use the generator service's sample content to test edge-case lengths.
