# Block Content Machine Name — agent index

Adds two base fields to the `block_content` (content block) entity and uses them to emit Twig template
suggestions and CSS classes for individual blocks. Zero configuration, no permissions, no services, no
admin UI, no config schema. Depends on core `block_content`. Drupal 8–11.

- **The two fields, the auto-derived machine name, the CSS classes, and the template suggestions** →
  [theming/suggestions.md](theming/suggestions.md)

Key facts:
- `machine_name` base field (string): auto-set on every save in `hook_entity_presave()` to
  `Html::getClass(transliterate($entity->label()))` — e.g. "Copyright Block" → `copyright-block`. NOT
  shown on the form, not hand-edited; tracks the label.
- `template_suggestion` base field (string, max 255): editable text field on the block add/edit form
  (weight -5) for a custom raw suggestion string.
- `hook_preprocess_block()` adds wrapper classes `block-content--<machine_name>` and
  `block-type-block-content`.
- `hook_theme_suggestions_block_alter()` adds `block__block_content__<machine_name>`,
  `block__block_content__<bundle>__<machine_name>`, plus the `template_suggestion` value if set.
- All logic is in `block_content_machine_name.module`; fields installed in `.install`.
