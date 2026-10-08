# Block template suggestions

`layout_builder_extra_templates_theme_suggestions_block_alter()` (→ `AddExtraThemeSuggestions::add()`)
adds bundle- and theme-aware suggestions for content and inline blocks. It runs only when the block's
`#base_plugin_id` is `block_content` (reusable content blocks) or `inline_block` (Layout Builder one-off
blocks).

## Resolving the bundle

- `inline_block` → bundle = `#derivative_plugin_id`.
- `block_content` → bundle = `$variables['elements']['content']['#block_content']->bundle()`.

Active theme name comes from `\Drupal::theme()->getActiveTheme()->getName()`.

## Suggestions added

Given bundle `<bundle>`, theme `<theme>`, and base plugin `<base_plugin_id>`
(`block_content` | `inline_block`):

| Suggestion | Where inserted | Template file |
|---|---|---|
| `block__<bundle>` | spliced in near the top (index 2) | `block--<bundle>.html.twig` |
| `block__<theme>__<bundle>` | spliced in near the top (index 2) | `block--<theme>--<bundle>.html.twig` |
| `block__<theme>__<base_plugin_id>__<bundle>` | appended (most specific, wins) | `block--<theme>--<base-plugin-id>--<bundle>.html.twig` |

(Drupal picks the last/most-specific matching template; hyphenate underscores in filenames as usual, e.g.
bundle `call_to_action` → `block--call-to-action.html.twig`.)

## Use in a theme

1. Enable the module (`ddev drush en layout_builder_extra_templates -y`).
2. Add a template to your theme's `templates/` dir, e.g. `block--hero.html.twig` for a `hero` block
   bundle, or `block--mytheme--inline-block--hero.html.twig` for a theme + inline-block specific override.
3. Clear caches (`ddev drush cr`). Enable Twig debug to confirm the new suggestions appear in the HTML
   comments for the block.

No configuration is involved — the suggestions exist for every `block_content`/`inline_block` render as
soon as the module is enabled.
