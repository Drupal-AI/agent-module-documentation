Block Content Template gives custom (content) block entities their own `block-content.html.twig` template plus per-bundle, per-view-mode and per-id theme-suggestion hooks and helpful CSS classes, so they can be themed like any other entity.

---

Out of the box, Drupal renders a custom block's fields without an entity-level template wrapper, which makes it hard to theme a whole block type. This module registers a `block_content` theme hook (a render-element template backed by `templates/block-content.html.twig`) and, via `hook_ENTITY_TYPE_view_alter()` for `block_content`, points every rendered custom block at it. A `template_preprocess_block_content()` preprocess builds the standard variables — `id`, `bundle`, `view_mode`, `label`, and `content` (it also cooperates with Layout Builder by passing through `_layout_builder` output, and strips the `data-quickedit-entity-id` attribute). `hook_theme_suggestions_HOOK()` adds a cascade of suggestions so a theme can override by view mode, bundle, bundle+view-mode, id, or id+view-mode. The default template outputs a `<div>` with classes like `block-content`, `block-content--type-<bundle>`, `block-content--<id>`, and `block-content--view-mode-<view_mode>`, wrapping the fields in a `block-content__content` div. There is no configuration, no admin UI, no routes and no permissions — enabling the module is all that is needed; the theming happens in your theme's Twig files.

---

- Give a custom "Promo" block type its own `block-content--promo.html.twig` template.
- Add a consistent wrapper `<div>` with entity-style CSS classes around every custom block.
- Theme all custom blocks of one bundle the same way regardless of where they are placed.
- Override a single custom block's markup by its id with `block-content--<id>.html.twig`.
- Provide a view-mode-specific template, e.g. `block-content--full.html.twig`.
- Combine bundle and view mode in one template: `block-content--promo--teaser.html.twig`.
- Target `block-content--type-<bundle>` CSS classes for styling a block type.
- Style a specific block instance via its `block-content--<id>` class.
- Style blocks per view mode with the `block-content--view-mode-<view_mode>` class.
- Wrap custom-block field output in a predictable `block-content__content` container for CSS.
- Make custom blocks themeable like nodes/terms without writing a custom preprocess by hand.
- Keep Layout Builder-rendered custom blocks working while still using the template.
- Access `bundle`, `view_mode`, `label`, and `id` variables directly in a block Twig template.
- Add microdata/ARIA wrappers around a specific block type via its template.
- Build a design-system component for a reusable block type using its own template.
- Remove the `data-quickedit-entity-id` attribute from rendered custom block markup.
- Provide different markup for the same block type across view modes.
- Give editors reusable branded blocks whose markup is controlled centrally in the theme.
- Add a heading/label wrapper around custom blocks using the `label` variable.
- Standardise custom-block markup across a multisite/theme so front-end code is predictable.
- Prototype block variations quickly by adding suggestion-named Twig files, no code changes.
- Migrate from ad-hoc block styling to entity-template-based theming for custom blocks.
