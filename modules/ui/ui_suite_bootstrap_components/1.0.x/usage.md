<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Suite Bootstrap components ships a set of opinionated Bootstrap 5 Single-Directory Components and an icon definition for use with the UI Suite / UI Patterns ecosystem.

---

The module provides ready-made components under `components/` — `card` (a horizontal/teaser card with image, header, content and footer slots plus attribute props), `hero`, `features` and `comment` — each defined as an SDC `*.component.yml` with a matching `*.twig` template and, for hero, Storybook-style `*.story.yml` examples. Props lean on UI Patterns attribute references (`ui-patterns://attributes`) so slots and wrapper classes can be customized from the layout/site-building UI. It also declares an icon pack (`ui_suite_bootstrap_components.icons.yml`) exposing Drupal core and related icons through the Icon API, and includes `libraryOverrides` hooks so sub-themes can attach their own CSS.

This is a presentational building-block module: there is no PHP, no routes, no services, no permissions and no configuration form — you consume the components in UI Patterns/UI Suite layouts, Layout Builder, or directly in Twig via SDC (`{{ include('ui_suite_bootstrap_components:card') }}`). It is intended to sit under a Bootstrap-based theme in the UI Suite stack.

---
- Add a Bootstrap card component to a layout via UI Patterns.
- Render a horizontal teaser card with an image column and content column.
- Place a hero banner component on a landing page.
- Use the features component to lay out a feature grid.
- Render a styled comment component.
- Include a component directly in Twig with SDC syntax.
- Customize card header/footer/row/column classes via attribute props.
- Reference the shipped Storybook-style hero stories as usage examples.
- Expose core icons through the Icon API pack.
- Override component CSS from a sub-theme via `libraryOverrides`.
- Build pages in Layout Builder using these SDC components.
- Provide consistent Bootstrap 5 markup across a UI Suite site.
- Swap slot content (image/header/content/footer) per placement.
- Use dark-variant hero stories for dark backgrounds.
- Extend the component set in a sub-theme or companion module.
