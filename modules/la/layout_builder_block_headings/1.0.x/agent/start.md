<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout builder block headings (layout_builder_block_headings) — agent index

**Renders a designated block_content field as the block's heading in Layout Builder, with optional per-placement heading-level and style overrides.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Depends on:** `block_content`, `layout_builder`, `options`, `text`
- **Config:** block-type third-party settings `heading_field`, `heading_level_field`, `heading_style_field`, `allow_heading_level_customization`, `allow_heading_style_customization` (`config/schema/...schema.yml`)
- **Overrides:** stored on the Layout Builder component; carried into render by `LayoutBuilderComponentRenderArray` (subscribes `SECTION_COMPONENT_BUILD_RENDER_ARRAY`)
- **Render:** `hook_preprocess_block()` → `#type: processed_text` heading, level whitelisted h1–h6 (default h2), style class via `Html::getClass()`; theme suggestion `block__layout_builder_block_headings_block`
- **Routes / permissions:** none of its own

**Security:** All configuration is on admin-gated block-type and Layout Builder forms; heading text is rendered through a text format, the level is whitelisted to h1–h6, and the style class is sanitised (`Html::getClass()`). Only one render event subscriber; no routes/permissions, no anonymous or mutating endpoints.

See [configure/headings.md](configure/headings.md)
