<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Quote adds a ready-made Quote / testimonial block type — quote text, author, and a persona photo or company logo — with five predefined looks and the Extra Block Types family's shared design options.

---

Install it with `composer require drupal/ebt_quote` and enable it; it pulls in **EBT Core** (`ebt_core`), and because the shipped display config also references them, **Field Group** (`field_group`), **Media Library** (`media_library`), core **Media** and **Text** must be enabled too — and a **Media type "image"** must already exist (install is blocked with an error until it does). Enabling adds a `block_content` type called **EBT Quote** with four fields: a **required** WYSIWYG **Quote** body, a **Quote Author** (company/persona name and role), a **Quote Image** referencing an image media entity (shown through the built-in `quote_image` image style, scaled to 530px wide), and a **Block settings** field. Create one at **Content » Blocks » Add content block » EBT Quote** (or drop an inline *EBT Quote* block into a **Layout Builder** section, or place a reusable block under **Structure » Block layout**). The edit form has two tabs: **Content** (description, quote, author, image) and **Settings**, where a **Quote styles** selector picks one of five looks — *Persona*, *Company*, *Persona with small icon*, *Width square image*, *With frame and background image* — and the shared design options set margin, padding, border (width/color/style/radius), background color or a background image/video, edge-to-edge and container width. On the front end the chosen style loads its own CSS component and wraps the image/quote/author accordingly, plus an inline `<style>` built by EBT Core (each value HTML-escaped; box values must be numeric and colors valid hex). The Quote and Author render through whatever **text format** the editor chose, so allowed HTML follows your site's format/role setup. Site-wide defaults (primary/secondary colors, breakpoints, container widths) live on the shared EBT Core settings form at **Configuration » Content authoring » Extra Block Types (EBT) settings**. Two things to weigh — the family's standing trade-off: pre-built is quick to adopt but **awkward to diverge from** (an uncovered look means template/CSS overrides, at which point a local block type is often cheaper), and it **becomes a dependency of your content** (pages are built from it, so uninstalling deliberately keeps the block type and existing blocks rather than orphaning them). Remember EBT is the **block**-shaped family and EPT the **paragraph**-shaped one: a block is placeable in a region, droppable into Layout Builder and referenceable from a field, while a paragraph belongs to one page's field.

---

- Add a styled pull-quote block to a region.
- Drop a testimonial block into a Layout Builder section.
- Place a reusable quote block under Block layout.
- Show a client testimonial with a persona photo.
- Show a company quote with a logo.
- Use the round-persona "Persona" style.
- Use the "Company" style for corporate quotes.
- Use the "Persona with small icon" compact style.
- Use the "Width square image" side-by-side style.
- Use the "With frame and background image" style.
- Attribute a quote to an author with name and job title.
- Constrain the quote to a narrower container width.
- Put the quote on a colored background.
- Add padding and a border around a quote block.
- Set a background image or video behind a quote.
- Add an overlay tint over a background image.
- Scale the quote image consistently via the quote_image image style.
- Give editors a consistent, form-driven way to present testimonials.
- Build a testimonials section from several quote blocks.
- Apply site-wide color and breakpoint defaults from EBT Core.
- Keep quote styling in configuration instead of ad-hoc CSS.
