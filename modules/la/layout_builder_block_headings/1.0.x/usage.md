<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout builder block headings lets a block-content type designate one of its fields as the block's heading, then renders that heading (with a configurable HTML level and CSS style class) when the block is placed in a Layout Builder layout, optionally allowing per-placement overrides of the level and style.

On the block-content **type** edit form the module (via `hook_form_alter`) adds third-party settings selecting which field is the `heading_field`, `heading_level_field`, and `heading_style_field`, plus `allow_heading_level_customization` / `allow_heading_style_customization` flags (stored in config, see `config/schema`). On the block form it wires `#states` so the level/style fields appear only when the heading has text. In Layout Builder's add/update-block form it hides the core label controls, and — when customization is allowed — exposes an override for the heading level (validated to `h1`–`h6`, defaulting to `h2`) and heading style (options come from the field's `allowed_values`). Overrides are stored on the layout component and carried into rendering by a `SectionComponentBuildRenderArrayEvent` subscriber.

`hook_preprocess_block()` builds the heading as `#type => processed_text` using the field's stored value and text format (so it is filtered through Drupal's text-format system), applies the resolved level, and adds the style as an `Html::getClass()`-sanitised class on `title_attributes`. The module has **no routes, permissions, or services beyond the render event subscriber**; all configuration is on the standard, admin-gated block-type and Layout Builder forms, and the heading level is constrained to a fixed whitelist. No anonymous or mutating endpoints and no notable injection surface.
---
Config via block-type third-party settings + Layout Builder component overrides (admin-gated forms). Heading level is whitelisted to h1–h6 (defaults h2); style class sanitised with `Html::getClass()`; heading text rendered through a text format. Requires `block_content`, `layout_builder`, `options`, `text`. One event subscriber; no routes/permissions of its own.
---
- Render a block-content field as the block's on-page heading in a layout.
- Map an existing "Title"/"Heading" field to the block heading.
- Let site builders choose the heading level (h2–h4) per block placement.
- Enforce a default heading level while allowing per-placement overrides.
- Provide a heading-style dropdown driven by an Options list field.
- Keep heading text uneditable at placement time (managed on the block).
- Improve page heading hierarchy/accessibility in Layout Builder pages.
- Hide the core block "label" controls in favour of the managed heading.
- Show the level/style controls only when the heading field has content.
- Apply a design-system style class to headings via `Html::getClass()`.
- Restrict which block types get heading behaviour by configuring per bundle.
- Allow editors to override only the level, only the style, or both.
- Render the heading through a text format for safe markup.
- Support inline blocks and reusable block_content in the same way.
- Set consistent default heading levels across a site's components.
- Prevent invalid heading levels (anything outside h1–h6 falls back to h2).
- Add a theme override via the `block__layout_builder_block_headings_block` suggestion.
- Guide editors with built-in level/style guideline links in the UI.
