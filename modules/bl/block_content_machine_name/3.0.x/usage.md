Block Content Machine Name gives every content block (`block_content` entity) a stable, auto-derived machine name plus an optional custom template-suggestion string, so themers can target individual blocks with dedicated Twig templates and CSS classes instead of unstable numeric IDs.

---

Drupal core does not expose a per-block identifier that themers can rely on: content blocks are addressed only by numeric `id`, which changes between environments. This module adds two base fields to the `block_content` entity type. `machine_name` is auto-populated on every save from the block's label — `Html::getClass(transliterate(label))`, e.g. label "Copyright Block" becomes `copyright-block` (lowercased, spaces and underscores to hyphens, accents transliterated, other characters dropped). It is not shown on the block form and is not hand-edited; it simply tracks the label. `template_suggestion` is an editable text field that appears on the content-block add/edit form (weight -5) for a fully custom suggestion string. On render, `hook_preprocess_block()` adds the CSS classes `block-content--<machine_name>` and `block-type-block-content` to the block wrapper, and `hook_theme_suggestions_block_alter()` emits the Twig suggestions `block__block_content__<machine_name>` and `block__block_content__<bundle>__<machine_name>`, plus the raw `template_suggestion` value when set. There is no admin page, no permission, no service and no config — enabling the module and providing the templates is all that is needed. Works on Drupal 8 through 11.

---

- Give one specific content block its own Twig template keyed on the label-derived name (`block--block-content--copyright-block.html.twig`).
- Target a block by both bundle and machine name (`block--block-content--basic--copyright-block.html.twig`).
- Reuse a single shared template across several blocks by typing the same value into the template-suggestion field.
- Style an individual block in CSS via the auto-added `block-content--<machine-name>` wrapper class.
- Select all content blocks at once with the `block-type-block-content` wrapper class.
- Keep block template targeting stable across dev/stage/prod where numeric block IDs differ.
- Build a reusable "card" or "banner" template and point multiple blocks at it through the template-suggestion field.
- Rename a block (change its label) and have its machine name and suggestions follow automatically on save.
- Move block markup out of CSS-only overrides into proper Twig template overrides.
- Print or reorder specific fields of a block in its dedicated template with `{{ content.field_name }}`.
- Suppress a field in a block's template with `{{ content|without('field_name') }}`.
- Apply per-block accessibility markup (ARIA roles, landmarks) in a targeted template.
- Give editorial teams predictable, label-based hooks so they can theme blocks without touching numeric IDs.
- Differentiate visual treatments of blocks that share one bundle by using machine-name suggestions.
- Add design-system wrappers or utility classes scoped to one named block.
- Combine with theme-level `hook_theme_suggestions_block_alter()` to further reorder the generated suggestions.
- Identify a block programmatically by reading its `machine_name` field value instead of its ID.
- Provide a consistent, node-like suggestion pattern for content blocks placed through Block Layout.
- Theme the same logical block differently per bundle by supplying bundle-scoped templates.
- Migrate legacy per-block styling hacks to maintainable, version-controlled Twig templates.
