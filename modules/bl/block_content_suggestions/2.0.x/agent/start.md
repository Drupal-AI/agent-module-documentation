# Block content suggestions — agent index

Adds Twig template suggestions for `block_content` (content block) entities — per instance ID, per
bundle, and per view mode — which Drupal core does not provide by default. Zero configuration, no
permissions, no services, no admin UI. Depends on core `block_content`. Requires Drupal 11 / PHP 8.3+.

- **The suggestion cascade, the `block-content.html.twig` template, template variables, and how it
  re-enables theming** → [theming/suggestions.md](theming/suggestions.md)

Key facts:
- Registers theme hook `block_content` (`render element` = `elements`) with default
  `templates/block-content.html.twig` (`{{ content }}`).
- Overrides the `block_content` entity `view_builder` handler with
  `Drupal\block_content_suggestions\BlockContentViewBuilder` to restore the theme function core omits.
- Suggestions (most→least specific): `block_content__{id}__{view_mode}`, `block_content__{id}`,
  `block_content__{bundle}__{view_mode}`, `block_content__{bundle}`, `block_content__{view_mode}`.
- All hooks are in `src/Hook/BlockContentSuggestionsHooks.php` (attribute `#[Hook(...)]`).
