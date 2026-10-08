<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Blocks adds a visual **Style** tab to every block you add or edit in Layout Builder, letting editors apply Bootstrap Styles (background color, text color/alignment, padding, margin, border, box-shadow, scroll animation) to individual blocks without writing CSS.

---

The module hooks the core `layout_builder_add_block` and `layout_builder_update_block` forms and reorganizes them into a two-tab UI: a **Content** tab holding the block's original fields (moved there by a small jQuery behavior) and a **Style** tab built from the Bootstrap Styles plugin manager. The chosen styles are stored on the Layout Builder `SectionComponent` under a `bootstrap_styles.block_style` key, and a `SectionComponentBuildRenderArrayEvent` subscriber re-applies those styles (as CSS classes / wrapper markup) to the block's render array on the front end. An admin form at `/admin/config/content` → *Layout Builder Blocks* (route `layout_builder_blocks.styles`, permission `configure bootstrap layout builder` from Bootstrap Styles) controls which Bootstrap Styles plugins are enabled and can optionally restrict styling to a chosen set of block plugins or custom block types via a `block_restrictions` list. Dashboard/dashboards routes are deliberately skipped so the Style tab does not appear there, and the skip logic is overridable through `hook_layout_builder_blocks__is_dashboard_type_route_alter()`. It requires the Bootstrap Styles module (declared dependency) and operates on top of core Layout Builder (a functional requirement, not an info.yml dependency). It ships no config schema of its own — its settings live in the reused `layout_builder_blocks.styles` config object.

---

- Give editors a no-code way to set a block's background color in a Layout Builder layout.
- Add top/bottom padding to a specific block inside a section.
- Apply margins to space a block apart from its neighbors.
- Set text color or text alignment on an individual block.
- Add a border or box-shadow to a call-to-action block.
- Attach a scroll/appear animation to a block.
- Provide a clean two-tab (Content / Style) editing experience for Layout Builder blocks.
- Style reusable ("custom") blocks placed via Layout Builder.
- Style inline blocks created inside a layout.
- Style core blocks (e.g. Powered by, Site branding) with utility classes.
- Restrict which blocks can be styled by selecting specific block plugins.
- Restrict styling to specific custom block *types* (applies to both inline and reusable blocks of that bundle).
- Limit editors to only the Bootstrap Styles plugins you enable site-wide.
- Keep block styling out of Dashboard layouts while allowing it elsewhere.
- Programmatically read a block component's stored styles from a saved layout.
- Programmatically apply a background/spacing class to a block component in code.
- Migrate ad-hoc per-block CSS into managed, reusable utility classes.
- Standardize spacing and color choices across a site's landing pages.
- Let content teams build styled landing pages without theme deploys.
- Override the dashboard-route detection to also skip (or allow) custom routes.
- Reuse the same Bootstrap Styles definitions already used by Bootstrap Layout Builder sections, now on blocks too.
- Audit which blocks in a layout carry custom styling.
