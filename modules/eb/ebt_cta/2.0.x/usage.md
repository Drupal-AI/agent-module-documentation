<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Call to Action ships a reusable "Call to Action" block content type combining a title, body text, an optional image column, and one or two styled buttons, with the Extra Block Types family's shared design settings.

---

The module installs a `block_content` bundle named `ebt_cta` with a fixed set of fields — a text title (`field_ebt_cta_title`), a body, a Media image reference (`field_ebt_cta_column_image`), a required primary link (`field_ebt_cta_link`) and an optional second link (`field_ebt_cta_second_link`), plus the shared EBT settings field (`field_ebt_settings`). Editors create instances under the custom block library and place them in a region or drop them into a Layout Builder section. A dedicated field widget, `EbtSettingsCtaWidget` (plugin id `ebt_settings_cta`, extending EBT Basic Button's widget), adds CTA-specific layout controls on top of the standard button and design options: a layout style (2 columns, 2 columns fluid image, or one column), content alignment, image position and mobile image order, and a mobile breakpoint. At render time `ebt_cta_preprocess_block()` (via `EbtCtaHooks`) turns those settings into inline `<style>` blocks — button styling from EBT Basic Button's `generate_custom_css` service and CTA layout/responsive rules from this module's own `ebt_cta.generate_cta_css` service (`GenerateCtaCSS`) — and two Twig templates (`block--block-content--ebt-cta` and `block--inline-block--ebt-cta`) render the columns and buttons. The module requires `ebt_basic_button`, `ebt_core`, `paragraphs`, and core `link`/`media`; on install it checks that a Media type "image" exists via `hook_requirements()`. Version 2.0.x, core `^10.1 || ^11 || ^12`.

---

- Add a call-to-action block with a heading, paragraph and button to any page.
- Place a two-column CTA with an image on the left and text plus button on the right.
- Use the "2 Columns fluid image" style so the image bleeds to 50% of the viewport width.
- Add a one-column, centered CTA (image row above the button).
- Render two buttons in one CTA (primary and secondary link).
- Drop a CTA block into a Layout Builder section.
- Place a signup or subscribe prompt in a sidebar region.
- Build a donate block with supporting copy and a donate button.
- Add a campaign conversion block reused across landing pages.
- Style the CTA buttons (colors, shape, size, alignment) via EBT Basic Button settings.
- Mark a button to open in a new tab or carry `rel="nofollow"`.
- Set a custom mobile breakpoint at which the two columns collapse to one.
- Choose whether the image appears first or last after collapsing on mobile.
- Reverse image/text order by setting image position to the right in a two-column layout.
- Add a Media image beside the CTA text using the media library widget.
- Apply the EBT design box (margins, paddings, borders, background) to the whole block.
- Reference a CTA block from an entity reference field.
- Create multiple CTA variants and place a different one per section.
- Add an "apply now" or "book a demo" prompt to a footer region.
- Provide editors a consistent, pre-built CTA component instead of hand-built HTML.
