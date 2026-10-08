<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks is a shell module (ImageX/IXM) that ships ten ready-made custom block types — accordion, cards, carousel, CTA icons, hero, modal, ping-pong, statistics, table, tabs — as `block_content` bundles with their fields, form/view displays and Bootstrap 5 Twig templates already built, each in its own submodule you enable on demand.

---

The base `ixm_blocks` module carries almost no logic: it depends only on `block_content` and implements one hook, `hook_theme_suggestions_block_alter()`, which injects `block__BUNDLE` and `block__BUNDLE__VIEWMODE` template suggestions so each block type gets its own template. Everything else lives in submodules. Enabling a component submodule (e.g. `drush en ixm_blocks_hero`) installs that component's `config/optional` — a `block_content.type.*`, a Paragraphs `paragraphs_type.*`, the field storages/instances (`field_entity_reference_paragraph`, `field_title`, `field_body`, `field_media_element`, `field_links`, …), the default form and view displays, and registers a `block--ixm-blocks-*.html.twig` template via that submodule's `hook_theme()`. Most components model their repeating rows (accordion items, cards, slides, stats) as referenced Paragraphs; `table` uses only a body field and `modal` uses a body plus a `field_modal_trigger`. Because the components are `block_content` bundles they are revisioned, translatable and reusable through the block library, and they render identically under Layout Builder or the classic block layout. Front-end behaviour is Bootstrap 5 plus a few CDN libraries pulled in per component: Swiper (hero swiper variant), Tablesaw (responsive table), ScrollMagic + jQuery.animate (statistics count-up) and the Vimeo player API. The hero submodule is the only one with real PHP: a preprocess hook that resolves each slide's media into image-style URLs (`hero_banner_desktop`/`hero_banner_mobile`) or a YouTube/Vimeo/local-video player. `ixm_blocks_boilerplate` is a hidden submodule that exists as a copy-paste template for packaging your own eleventh block type the same way.

The templates are the module's real payload and the reason to read it: they are opinionated, Bootstrap-5-markup starting points meant to be overridden in your own theme, not a black-box widget.

---

- Stand up a marketing site's standard component set (hero, cards, CTA, stats) without building each block type from scratch.
- Enable only the components a given build needs (`drush en ixm_blocks_cards ixm_blocks_hero -y`).
- Add a Bootstrap 5 hero banner block with a bootstrap or Swiper carousel of image/video slides.
- Add a responsive card grid backed by Paragraphs or by referenced nodes.
- Place an accordion, tabs, or carousel block built from repeatable Paragraph items.
- Add an alternating image/text "ping-pong" section block.
- Show an animated count-up statistics block (prefix/number/suffix per stat).
- Add a CTA-icons row linking out to key pages.
- Add a Bootstrap modal block triggered by a button.
- Add a responsive (Tablesaw) table block from a rich-text body.
- Get pre-built form displays and view displays for each block type, ready to edit.
- Get a per-block-type icon in the Layout Builder off-canvas tray when the Block Library module is installed.
- Reuse the components across sites as a shared, revisioned, translatable block library.
- Override any component's markup by copying its `block--ixm-blocks-*.html.twig` into your theme.
- Use `ixm_blocks_boilerplate` as a worked example of how to package a new block type (fields + displays + template).
- Study the config layout as a reference for shipping block_content bundles as installable config.
- Scope a component library for a project by checking requirements against the ten shipped types.
- Extend the hero template via its Twig blocks/macros (`hero-extends-bootstrap`, `hero-extends-swiper`).
- Swap the recommended Material Icons set for component icons to keep a consistent admin UI.
- Audit which components a site actually enables before a redesign.
- Migrate an ad-hoc set of custom blocks onto a maintained, config-driven baseline.
