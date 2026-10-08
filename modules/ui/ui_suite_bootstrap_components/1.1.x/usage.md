<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Suite Bootstrap components ships a set of opinionated Bootstrap 5 Single-Directory Components (button, card, features, header, hero, menu) plus an icon pack for use with the UI Suite / UI Patterns / Display Builder ecosystem.

---

The module provides ready-made components under `components/` — `button` (a Bootstrap button/link with an optional icon and a large palette of colour/size/outline variants), `card` (a horizontal or image-overlay card with image, header, content and footer slots), `features` (a Bootstrap-example feature grid), `header` (a full navbar/site-header that reuses UI Suite Bootstrap's `navbar`/`grid_row_1` templates), `hero` (a centered or responsive left-aligned banner with call-to-action buttons), and `menu` (a nav/pills/underline menu that supports dropdowns). Each is defined as an SDC `*.component.yml` with a matching `*.twig` template; `button` and `hero` ship Storybook-style `stories/*.story.yml` examples. Props lean on UI Patterns references (`ui-patterns://attributes`, `ui-patterns://links`, `ui-patterns://url`, `ui-patterns://icon`) so slots, links and wrapper classes can be configured from the layout/site-building UI. The module also declares an Icon API pack (`ui_suite_bootstrap_components.icons.yml`) exposing Drupal core and related logos through the Icon API, and each component includes a `libraryOverrides` hook so sub-themes can attach or override CSS.

This is a presentational building-block module: there is no PHP runtime code, no routes, no services, no permissions and no configuration form (the only PHP is a kernel test). You consume the components in UI Patterns / UI Suite / Display Builder layouts, in Layout Builder, or directly in Twig via SDC (`{{ include('ui_suite_bootstrap_components:card') }}`). The `header` and `menu` components include templates from `ui_suite_bootstrap` (navbar, navbar_nav, dropdown, grid_row_1), so a Bootstrap-based UI Suite theme (`ui_suite_bootstrap` >= 5.1, per the composer `conflict`) should be present for those two to render.

---
- Render a Bootstrap button with a colour variant (primary, secondary, success, danger, etc.).
- Render a small (`__sm`) or large (`__lg`) button variant.
- Render an outline-style button (`outline_primary`, `outline_danger`, …).
- Add an icon before or after a button label via the `icon` prop and `icon_position`.
- Render a button as a link by supplying a `url` prop, or a disabled button/link.
- Visually hide a button label for icon-only buttons while keeping it accessible.
- Add a Bootstrap card component to a layout via UI Patterns / Display Builder.
- Render a horizontal teaser card with an image column and a content column.
- Flip the card image to the right on medium screens with `image_right`.
- Render an image-overlay card with content placed over the image.
- Customize card header/footer/row/column classes via attribute props.
- Lay out a feature grid with the `features` component (columns, hanging or icon_grid variants).
- Control the feature grid column count (1–6) for large screens.
- Place a full site header/navbar with logo, title, subtitle and an inline menu.
- Collapse the header menu into a dropdown, or into an offcanvas drawer, on small screens.
- Wrap the header in a chosen Bootstrap container width (`container`, `container-lg`, `container-fluid`, …).
- Place a centered hero banner with title, lead text and call-to-action buttons on a landing page.
- Place a responsive left-aligned hero with a screenshot/visual beside the text.
- Use dark hero variants (`default__dark`, `horizontal__dark`) on dark backgrounds.
- Add a border and/or shadow to a hero, or switch its two sides.
- Render a nav menu as tabs, pills, filled/justified pills or underline style.
- Render a menu with dropdown sub-items using UI Suite Bootstrap's dropdown component.
- Include any component directly in Twig with SDC syntax.
- Expose Drupal core logos/icons through the Icon API pack for icon-picker fields.
- Override component CSS from a sub-theme via each component's `libraryOverrides` hook.
- Build pages in Layout Builder or Display Builder using these SDC components.
