<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Oomph Paragraph Bundles ships a set of ready-made, component-style Paragraph bundles for building structured pages.
---
The problem it solves: building a component/page-builder experience with the Paragraphs module means hand-configuring many bundles, fields and displays. This module provides that configuration out of the box — a library of reusable layout and content components editors can drop into paragraph reference fields.

How it works: on install the module imports config for several paragraph bundles (Row, Hero, Accordion, Image, Video, WYSIWYG, Column group) with their fields, form displays and view displays. A `ParagraphBundleDiscovery` service scans the module's `templates/` directory and `hook_theme()` registers a `paragraph__<bundle>` theme hook per discovered bundle (plus field templates), so each component has its own Twig template. "Row" acts as a container with alignment, background colour, an 18-option layout selector, borders, animation and custom CSS class fields; "Hero" is a row-like bundle with a background image and one WYSIWYG; the Video bundle intentionally ships without a video field so sites can add Core Media or another solution. The module has no routes, permissions or runtime configuration UI — it is content-model configuration plus theming.

Setup: enable the module (needs Paragraphs, Field group, Image, Options, Text), add a Paragraphs reference field to your content type allowing these bundles, add a video field to the Video bundle if needed, and style/override the provided templates in your theme.
---
- Add a Row container component with alignment and layout options.
- Choose from 18 layout configurations on a Row.
- Set a background colour class on a Row.
- Add top/bottom borders and inter-component borders on a Row.
- Apply an animation option to a Row.
- Add a Hero component with a background image and one WYSIWYG.
- Add an Accordion paragraph component.
- Add an Image paragraph component.
- Add a Video paragraph component (bring your own video field/solution).
- Add a WYSIWYG rich-text paragraph component.
- Group components with a Column group bundle.
- Provide per-bundle Twig templates for theming.
- Add custom CSS classes to a Row via a text field.
- Hide a Row background image on mobile viewports.
- Bootstrap a component-based page builder without manual bundle setup.
- Extend or override the shipped bundle configuration in a site.
