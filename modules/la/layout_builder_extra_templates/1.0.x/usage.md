Layout Builder Extra Templates adds extra Twig template suggestions for content blocks (`block_content`) and Layout Builder inline blocks (`inline_block`), keyed by block bundle and active theme, so themers can target a specific block type's markup without writing preprocess code.

---

The module is a single `hook_theme_suggestions_block_alter()` implementation (delegating to
`AddExtraThemeSuggestions::add()`). For blocks whose `#base_plugin_id` is `block_content` or
`inline_block`, it resolves the block bundle (from `#block_content`'s bundle, or the derivative plugin id
for inline blocks) and the active theme name, then injects extra suggestions: `block__<bundle>` and
`block__<theme>__<bundle>` (spliced near the top of the suggestion list), plus
`block__<theme>__<base_plugin_id>__<bundle>` appended at the end. There is no configuration, no
permissions, no schema, and no services — enabling it just makes the new suggestions available to your
theme. Depends only on core `layout_builder`.

---

- Give a specific custom block bundle its own Twig template (`block--<bundle>.html.twig`).
- Theme Layout Builder inline blocks by their derivative bundle.
- Provide theme-specific block templates (`block--<theme>--<bundle>.html.twig`).
- Style a "hero" or "call to action" block type differently from other blocks.
- Avoid writing `hook_theme_suggestions_alter()` in a custom theme for block-bundle targeting.
- Target reusable content blocks and inline (one-off) Layout Builder blocks with the same naming.
- Differentiate markup per block bundle placed via Layout Builder.
- Keep block markup in the theme layer instead of preprocess PHP.
- Support component-driven theming where each block bundle maps to a template.
- Add a base-plugin-scoped template (`block--<theme>--inline_block--<bundle>.html.twig`) for edge cases.
- Provide predictable template names for a design system's block components.
- Let a subtheme override only certain block-bundle templates.
- Simplify migrating custom block markup into distinct template files.
- Theme block types consistently across multiple themes on one site.
- Enable per-bundle block templating on Layout Builder pages without custom code.
