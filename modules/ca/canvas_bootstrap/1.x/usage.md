<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Canvas Bootstrap adds 16 ready-made Bootstrap 5 components to the Drupal Canvas visual editor.

---

Install with `composer require drupal/canvas_bootstrap` and enable it (`drush en canvas_bootstrap`); it requires the **Canvas** module (`drupal/canvas`) and Drupal 11.2+ (or 12). It ships no configuration pages, permissions, or Bootstrap CSS of its own — styling comes from your site's active **Bootstrap 5 theme**, so pair it with one (the maintainer suggests the *Bootstrap Forge* theme). Once enabled, open the Canvas editor and find the components under the **"Canvas Bootstrap"** group in the component library, then drag them in and configure each instance's props (variant, size, spacing, layout, slots) in the settings panel — the module reorganises those props into tidy vertical tabs for the richer components. The set covers layout (**Wrapper**, **Row**, **Column**), content (**Heading**, **Paragraph**, **Blockquote**, **Image**, **Link**, **Button**, **Badge**, **Alert**), and interactive blocks (**Card**, **Carousel** + **Carousel Item**, **Accordion Container** + **Accordion item**). Every component is a standard Single Directory Component (`canvas_bootstrap:<name>`), so it also works from Twig/render arrays, and any Bootstrap theme can override a component by shipping an SDC with the same machine name.

---

- Add Bootstrap 5 building blocks to the Canvas visual editor without writing HTML.
- Drag-and-drop a Bootstrap **Button** with variant, size, and outline options.
- Place responsive **Row** / **Column** grids to lay out a page.
- Wrap content in a **Wrapper** with container, width/height, flex, and spacing utilities.
- Add **Heading** (H1–H6) and **Paragraph** blocks with alignment and text-color controls.
- Insert a **Card** with header, image, body, and footer slots and per-breakpoint orientation.
- Build a **Carousel** slideshow with indicators, controls, crossfade, autoplay, and touch swipe.
- Add collapsible content with **Accordion Container** + **Accordion item** (optional flush style).
- Show contextual messages with a dismissible **Alert**.
- Label or count things with a **Badge** (pill style, color variants, screen-reader text).
- Add a responsive **Image** with aspect-ratio cropping, rounding, caption, and optional link.
- Quote sources with a **Blockquote** (footer + citation).
- Add styled **Link** elements, optionally rendered as buttons or stretched links.
- Rapidly prototype Bootstrap-themed pages inside Canvas.
- Give editors consistent, reusable UI pieces without custom Twig or Paragraphs.
- Reuse the same components from code via SDC includes (`canvas_bootstrap:button`, etc.).
- Override any component from your Bootstrap theme by matching its machine name.
- Group a component's many props into vertical tabs for a cleaner editor form.
- Keep front-end and Canvas-preview markup identical by relying on the active theme's Bootstrap.
- Enable only on sites already running Canvas plus a Bootstrap 5 theme.
- Review component fit after Canvas or Bootstrap upgrades.
