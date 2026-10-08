# Theming — template suggestions for content blocks

Source: `src/Hook/BlockContentSuggestionsHooks.php`, `src/BlockContentViewBuilder.php`,
`templates/block-content.html.twig`.

## How it enables theming

Core's `block_content` view builder intentionally does **not** add a theme function, so content blocks
are not individually themeable. This module:

1. `hook_entity_type_alter` sets the `block_content` `view_builder` handler to
   `BlockContentViewBuilder`, whose `getBuildDefaults()` calls the generic
   `EntityViewBuilder::getBuildDefaults()` (bypassing the core override that removes the theme hook).
2. `hook_theme` registers a `block_content` theme hook (`render element` = `elements`) with the
   default template `templates/block-content.html.twig`.

## Suggestions emitted (`hook_theme_suggestions_block_content`)

Given a content block with a bundle, id, and current view mode (dots in the view mode → underscores),
these are added in order — Drupal picks the **most specific existing** template file:

| Suggestion (theme hook) | Template file |
|---|---|
| `block_content__{view_mode}` | `block-content--{view-mode}.html.twig` |
| `block_content__{bundle}` | `block-content--{bundle}.html.twig` |
| `block_content__{bundle}__{view_mode}` | `block-content--{bundle}--{view-mode}.html.twig` |
| `block_content__{id}` | `block-content--{id}.html.twig` |
| `block_content__{id}__{view_mode}` | `block-content--{id}--{view-mode}.html.twig` |

(Later entries are more specific and win.) Extend or reorder with the standard
`hook_theme_suggestions_block_content_alter()` in a theme/module.

## Template variables (`preprocess_block_content`)

- `block_content` — the `BlockContent` entity (call getters like `.label()`, `.bundle()`, `.id()`).
- `view_mode` — e.g. `full`, `teaser`.
- `content` — render array of the block's children; print all with `{{ content }}` or a field with
  `{{ content.field_example }}`; suppress with `{{ content|without('field_example') }}`.
- Plus core-provided `attributes`, `logged_in`, `is_admin`.

Default `templates/block-content.html.twig` is just `{{ content }}`; copy it into your theme and rename
per the table above to override a specific block, bundle, or view mode.
