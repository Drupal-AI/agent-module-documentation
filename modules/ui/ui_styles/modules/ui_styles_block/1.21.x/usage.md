<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Block adds the UI Styles selector to the block-layout block configuration form, letting you attach curated CSS classes to a placed block's wrapper, its title, and its content.

---

This submodule integrates UI Styles with core's Block module (block-layout placed blocks, `block.block.*` config entities). It alters the block configuration form (`FormBlockFormAlter`) to add three `ui_styles_styles` selectors — **block**, **title** and **content** — so a site builder can pick styles for each part of the rendered block. On save, `BlockPresave` copies the submitted `{selected, extra}` values into the block's `third_party_settings.ui_styles.{block,title,content}` (config schema `block.block.*.third_party.ui_styles`). At render time `PreprocessBlock` reads those third-party settings and merges the resulting classes onto the block's `attributes`, `title_attributes` and `content_attributes` respectively (using `AttributeHelper::mergeCollections`). It adds no routes, permissions or settings form of its own; all state lives in each block's config entity.

---

- Add a background or border utility class to a specific placed block.
- Apply spacing (padding/margin) classes to a block without editing templates.
- Style a block's title separately from its body (e.g. an accent colour on the heading).
- Add classes only to a block's content wrapper, leaving the outer wrapper untouched.
- Give a "Powered by Drupal" or menu block a card-style treatment.
- Apply a theme's utility classes to sidebar blocks per region placement.
- Add an `extra` one-off class to a single block instance via the free-text field.
- Highlight an important block with a coloured wrapper class.
- Keep block styling in exported config (`third_party_settings.ui_styles`) for deployment.
- Consistently style all blocks of a type by applying the same styles to each placement.
- Add responsive utility classes (e.g. `d-none d-md-block`) to a block.
- Apply rounded-corner or shadow utilities to a call-to-action block.
- Attach a text-alignment class to a block's content.
- Differentiate blocks visually in the same region using distinct style sets.
- Wrap a search or newsletter block in branded colours.
- Add ARIA-friendly visual states via curated classes on the block wrapper.
- Style branding/site-name blocks in the header region.
- Apply classes to a views block placed through block layout.
- Give social-links blocks a horizontal-flex utility layout.
- Reuse the same design-system styles across blocks that themes already ship.
- Remove per-block custom templates by moving class logic into configurable styles.
- Quickly A/B different visual treatments on a block by switching selected styles.
