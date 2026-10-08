<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Text adds a ready-made Text block type — a WYSIWYG body with the Extra Block Types family's shared design options for spacing, background, borders and container width.

---

Install it with `composer require drupal/ebt_text` and enable it; it pulls in **EBT Core** (`ebt_core`), and because the shipped display config also references them, **Field Group** (`field_group`) and core **Text** must be enabled too. Enabling adds a `block_content` type called **EBT Text** with two fields: a **required** WYSIWYG **Body** and a **Block settings** field holding the design options. Create one at **Content » Blocks » Add content block » EBT Text** (or drop an inline *EBT Text* block into a **Layout Builder** section, or place a reusable block under **Structure » Block layout**). The edit form has two tabs: **Content** (block description + Body) and **Settings**, where you set margin, padding, border (width/color/style/radius), background color or a background image/video from the media library, edge-to-edge, and container max width. On the front end the block wraps your text in an `.ebt-container` and applies those choices as an inline `<style>` built by EBT Core (each value HTML-escaped; box values must be numeric and colors valid hex). The Body renders through whatever **text format** the editor chose, so allowed HTML follows your site's format/role setup. Site-wide defaults (primary/secondary colors, breakpoints, container widths) live on the shared EBT Core settings form at **Configuration » Content authoring » Extra Block Types (EBT) settings**. Two things to weigh — the family's standing trade-off: pre-built is quick to adopt but **awkward to diverge from** (an uncovered design means template overrides, at which point a local block type is often cheaper), and it **becomes a dependency of your content** (pages are built from it, so removing the module later leaves blocks with no type — uninstalling deliberately keeps the block type and existing blocks). Remember EBT is the **block**-shaped family and EPT the **paragraph**-shaped one: a block is placeable in a region, droppable into Layout Builder and referenceable from a field, while a paragraph belongs to one page's field.

---

- Add a styled rich-text block to a region.
- Drop a text block into a Layout Builder section.
- Place a reusable text block under Block layout.
- Put body text on a colored background.
- Add padding above and around a block of text.
- Add a border with a chosen width, color and style.
- Round a text block's corners with a border radius.
- Constrain text to a narrower container width.
- Make a text section span edge to edge across the viewport.
- Set a background image behind text (cover, contain, repeat or parallax).
- Add a background video behind an intro section.
- Add an overlay tint over a background image or video.
- Give editors a consistent, form-driven way to style text.
- Build an introduction or lead-in section.
- Add a callout or notice block with background styling.
- Create a footer text area with spacing options.
- Standardize text presentation across a site.
- Add explanatory text to a sidebar.
- Compose a simple content section without custom CSS.
- Apply site-wide color and breakpoint defaults from EBT Core.
- Keep block styling in configuration instead of ad-hoc CSS classes.
