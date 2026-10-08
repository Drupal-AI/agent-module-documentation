<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Callout ships a single ready-made `bp_callout` Paragraph bundle — a coloured Bootstrap "callout" box with a header, a contextual style, and a nested-paragraph body — plus the Twig template and CSS that render it.

---

The module is **config plus one Twig template**: no PHP classes, no services, no plugins, no permissions, no settings form and no configure route. Installing it imports `paragraphs.paragraphs_type.bp_callout` and five field instances onto that bundle: `bp_callout_style` (a `list_string` with nine Bootstrap contextual values from `callout-style--primary` through `callout-style--white`), `bp_callout_content` (an unlimited-cardinality `entity_reference_revisions` field that nests thirteen other `bp_*` paragraph bundles inside the callout), plus `bp_header`, `bp_width` and `bp_background`, whose field *storages* are owned by the parent `bootstrap_paragraphs` module and shared across every bundle in the suite. Only `bp_callout_style` and `bp_callout_content` have storages of their own. The default form display uses `options_select` for the three list fields, a `string_textfield` for the header and the Paragraphs `entity_reference_paragraphs` widget (closed edit mode, dropdown add mode) for the nested content. `bp_callout.module` does just two things: `hook_theme()` registers `paragraph__bp_callout` with `base hook: paragraph`, and `hook_help()` prints the README on `/admin/help/bp_callout`. The `templates/paragraph--bp-callout.html.twig` template maps the three list fields to CSS classes, attaches the `bp_callout/bp-callout` and `bootstrap_paragraphs/bootstrap-paragraphs` libraries, sets a per-paragraph `id` of `callout-<pid>`, and wraps the body in `.callout-header` / `.callout-body`. Because all field values are literal CSS class strings, styling changes are made by editing the allowed values of the list storages, not by writing code.

---

- Add a Bootstrap-styled "info" or "warning" callout box to a landing page without writing a paragraph type by hand.
- Give editors nine ready contextual colours (primary, secondary, success, danger, warning, info, dark, light, white) for highlighted content.
- Build a "Did you know?" panel whose body is composed of other Bootstrap Paragraphs bundles.
- Nest a `bp_simple` rich-text paragraph inside a callout to get formatted body copy in a coloured box.
- Nest a `bp_image` paragraph inside a callout to produce an image-plus-notice block.
- Nest a `bp_columns` paragraph inside a callout to lay out a multi-column highlighted region.
- Nest a `bp_view` paragraph inside a callout to surface a listing inside a promoted box.
- Restrict which bundles editors may nest by editing the `target_bundles` handler settings on `paragraph.bp_callout.bp_callout_content`.
- Enable the Callout bundle on an existing node paragraphs field by ticking it in the field's target-bundle settings.
- Set section width per callout (`paragraph--width--tiny` … `paragraph--width--full`) using the shared `bp_width` field.
- Apply one of 58 shared background classes to a callout using the shared `bp_background` field.
- Give a callout an `<h2>` heading via the shared `bp_header` string field.
- Add a new brand colour to the callout palette by appending an allowed value to `field.storage.paragraph.bp_callout_style`.
- Override `paragraph--bp-callout.html.twig` in a custom theme to change the callout markup.
- Attach extra CSS to callouts by overriding the `bp_callout/bp-callout` library in a theme's `libraries-override`.
- Target a single callout instance in CSS or JS via its generated `id="callout-<paragraph id>"`.
- Programmatically create callout paragraphs during a content migration with `Paragraph::create(['type' => 'bp_callout', …])`.
- Audit which nodes use callouts by querying paragraphs of type `bp_callout`.
- Ship a site's callout styling as exported config so it deploys identically across environments.
- Use the callout as a reusable "promo strip" bundle inside a Layout Builder paragraph field.
- Standardise alert boxes across a site instead of letting editors hand-code alert markup in a WYSIWYG.
- Provide a nestable container so a callout can hold an accordion, tabs, or a carousel.
- Swap the default `options_select` widget for radio buttons on `bp_callout_style` for a friendlier editor UI.
- Hide `bp_background` from the callout form display when a site only wants the callout-style palette.
- Rename the bundle's label from "Callout" to a site-specific term without touching its machine name.
