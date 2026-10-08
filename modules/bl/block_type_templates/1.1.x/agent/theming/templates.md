# Per-block-type templates & classes

The whole module is two hooks in `block_type_templates.module`. No configuration.

## Template suggestions (`hook_theme_suggestions_block_alter`)

For any block whose `content['#block_content']` is a `BlockContentInterface`, it adds (right
after core's generic `block__block_content`, so they take precedence):

```
block__block_content_<block_type>                 -> block--block-content-<block-type>.html.twig
block__block_content_<block_type>__<view_mode>    -> block--block-content-<block-type>--<view-mode>.html.twig
```

`<block_type>` is the block content bundle machine name. Underscores in the machine name become
hyphens in the filename (Drupal's normal suggestion→filename rule).

### Example

A block content type with machine name `testing_this_out`, rendered in the `teaser` view mode,
can be themed by either of these files in your theme's `templates/` directory:

```
block--block-content-testing-this-out.html.twig
block--block-content-testing-this-out--teaser.html.twig
```

Copy core's `block.html.twig` as a starting point (it keeps the standard block markup and the
block's fields). After adding the file, clear caches (`drush cr`) so the theme registry picks it
up. Confirm the suggestion is offered by enabling Twig debug and reading the `<!-- FILE NAME
SUGGESTIONS -->` comment in the rendered HTML.

## CSS classes (`template_preprocess_block`)

| Block kind | `base_plugin_id` | Classes added |
|---|---|---|
| Content block | `block_content` | `block-content`, `block-type--<bundle>` |
| Inline block (Layout Builder) | `inline_block` | `inline-block`, `block-type--<derivative>` |

`<bundle>` / `<derivative>` is run through `Html::cleanCssIdentifier()`, so it is hyphenated and
CSS-safe. These give you a stable per-type hook for CSS/JS even without a custom template.

## Notes

- No effect on blocks that are not content/inline blocks (the suggestion hook checks for a
  `BlockContentInterface`; the preprocess hook checks `base_plugin_id`).
- Works with standard block layout, Panels and Layout Builder.
- Pairs well with the Components/SDC module for reusable sub-templates included from these files.
