Block Type Templates adds per-block-type Twig template suggestions (and CSS classes) so you can theme content blocks differently by their block type and view mode, which Drupal core does not support out of the box.

---

Drupal core provides block templates keyed by plugin and instance, but not by *content block type*. This module fills that gap with two hooks and no configuration. `hook_theme_suggestions_block_alter()` inserts `block__block_content_<block_type>` and `block__block_content_<block_type>__<view_mode>` into the block theme-suggestion list (placed just after core's generic `block__block_content` so they win), for any block whose rendered content is a `BlockContentInterface`. `template_preprocess_block()` also adds helpful CSS classes to the block wrapper: `block-content` plus `block-type--<bundle>` for block-content blocks, and `inline-block` plus `block-type--<derivative>` for inline blocks placed via Layout Builder. The result: create a Twig file such as `block--block-content-testimonial.html.twig` (or `block--block-content-testimonial--teaser.html.twig` for a view mode) in your theme and all blocks of that type pick it up automatically. It works with standard block placement, Panels, Layout Builder inline blocks, and pairs well with the Components/SDC approach for reusable sub-templates. There are no settings, permissions, services or plugins — it is purely a theming helper.

---

- Give a "Call to action" content block type its own `block--block-content-call-to-action.html.twig`.
- Theme a "Testimonial" block type differently from a "Promo" block type.
- Provide a distinct template per view mode, e.g. `block--block-content-testimonial--teaser.html.twig`.
- Build reusable, consistent design components driven by Drupal's block system.
- Target block-content blocks in CSS via the added `block-type--<bundle>` class.
- Style Layout Builder inline blocks via the `inline-block` and `block-type--<derivative>` classes.
- Keep block markup consistent across standard block layout, Panels and Layout Builder.
- Add a per-type wrapper, heading or field arrangement without a custom module.
- Override only the block types that need special markup, leaving others on core defaults.
- Combine with the Components/SDC module to include granular reusable sub-templates.
- Create a hero block type template with bespoke structure and classes.
- Distinguish editorial "Notice" blocks from "Card" blocks in the theme layer.
- Apply brand design patterns per block type across a multi-site theme.
- Let front-end developers work per block type without touching block config.
- Provide a teaser vs full rendering of the same block type via view-mode suggestions.
- Add a body class hook point (block-type--*) for JS behaviours scoped to a block type.
- Migrate ad-hoc block markup into structured per-type templates.
- Ensure a newly created block type immediately has a themable template suggestion.
