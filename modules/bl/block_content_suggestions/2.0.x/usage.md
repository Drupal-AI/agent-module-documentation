Block content suggestions makes content blocks (`block_content` entities) themeable per-instance, per-bundle and per-view-mode by adding Twig template suggestions that Drupal core deliberately omits.

---

Drupal core renders content blocks without a dedicated `block_content` theme hook, so themers cannot easily override an individual custom block. This module fills that gap: it registers a `block_content` theme hook with a `block-content.html.twig` default template, swaps the `block_content` entity's `view_builder` handler for its own `BlockContentViewBuilder` (which re-enables the theme function core disables), and implements `hook_theme_suggestions_block_content()` to emit a cascade of suggestions from most to least specific. The available suggestions are `block-content--{id}--{view-mode}`, `block-content--{id}`, `block-content--{bundle}--{view-mode}`, `block-content--{bundle}`, `block-content--{view-mode}`, and the base `block-content`. A `preprocess_block_content` hook exposes `block_content`, `view_mode`, and a `content` variable (the rendered children) to the templates. There is no configuration, no permissions, no services and no admin UI — enabling the module is all that is required, and suggestions can be further customized with the standard `hook_theme_suggestions_alter()` hooks. Requires Drupal 11 and PHP 8.3+. The module uses the modern attribute-based hook system (`src/Hook/BlockContentSuggestionsHooks.php`).

---

- Give a specific content block its own Twig template by ID (`block-content--5.html.twig`).
- Theme all content blocks of a given bundle (e.g. `block-content--basic.html.twig`).
- Vary a content block's markup by view mode (`block-content--full.html.twig`, `block-content--teaser.html.twig`).
- Combine bundle and view mode (`block-content--hero--full.html.twig`).
- Combine block ID and view mode (`block-content--5--teaser.html.twig`).
- Override the base content-block wrapper markup via `block-content.html.twig`.
- Enable multiple display modes for content blocks and style each independently.
- Provide a consistent themer experience for content blocks matching node/entity suggestion patterns.
- Add design-system-specific wrappers or classes to particular block bundles.
- Restructure a block's field output in Twig instead of via Layout/preprocess PHP.
- Print a subset of a block's fields with `{{ content.field_name }}` in a custom template.
- Suppress specific fields in a block template with `{{ content|without('field_x') }}`.
- Build reusable card/banner block templates keyed on bundle.
- Support editorial teams that reuse one block bundle with different visual treatments per placement.
- Extend or reorder the generated suggestions with `hook_theme_suggestions_block_content_alter()`.
- Migrate ad-hoc block styling out of CSS-only hacks into proper template overrides.
- Differentiate block markup between full page and Layout Builder contexts by view mode.
- Apply accessibility markup (ARIA roles/landmarks) to specific block bundles via templates.
- Theme reusable blocks placed through Block Layout with per-instance templates.
- Keep block markup in the theme (version-controlled Twig) rather than in configuration.
