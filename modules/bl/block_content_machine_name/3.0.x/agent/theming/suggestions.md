# Theming — machine name, CSS classes, and template suggestions

Source: `block_content_machine_name.module` (all behavior), `block_content_machine_name.install` (field
install). No admin UI, no config, no permissions, no services.

## The two base fields (`hook_entity_base_field_info` on `block_content`)

| Field | Type | On form? | How it is set |
|---|---|---|---|
| `machine_name` | string | No (`setDisplayConfigurable('form', FALSE)`) | Auto-derived on every save (see below) |
| `template_suggestion` | string (max 255) | Yes, weight -5, `string_textfield` | Typed by the editor on the block add/edit form |

Both are non-translatable. They are installed as entity base-field storage in `hook_install()` (and
kept in sync by update hooks 8001–8003), so no field-config or config schema is created.

## How `machine_name` is derived (`hook_entity_presave`)

On presave of any `BlockContentInterface` entity:

```
$value = transliterate($entity->label(), LANGCODE_DEFAULT, '_');
$entity->set('machine_name', Html::getClass($value));
```

So `machine_name` always mirrors the current label — it is overwritten on every save and cannot be
hand-edited. `Html::getClass()` lowercases and converts spaces/underscores to hyphens; transliteration
folds accents; other characters are dropped. Verified examples:

- "Copyright Block" → `copyright-block`
- "Footer Info!" → `footer-info`
- "Café Ünïcode" → `cafe-unicode`

Rename the block and the machine name (and the suggestions/classes below) follow on the next save.

## CSS classes added to the block wrapper (`hook_preprocess_block`)

For blocks whose `base_plugin_id` is `block_content`, two classes are appended to `attributes.class`:

- `block-content--<machine_name>` (run through `Html::cleanCssIdentifier`)
- `block-type-block-content`

## Template suggestions emitted (`hook_theme_suggestions_block_alter`)

For `block_content` blocks, appended in this order (later = more specific = wins):

| Suggestion (theme hook) | Matching template file |
|---|---|
| `block__block_content__<machine_name>` | `block--block-content--<machine-name>.html.twig` |
| `block__block_content__<bundle>__<machine_name>` | `block--block-content--<bundle>--<machine-name>.html.twig` |
| value of the `template_suggestion` field (only if non-empty) | `<that-value>.html.twig` (single `_` → `-` in the file name) |

Place these `.html.twig` files in your theme's `templates/` directory. The suggestion strings use `__`
(double underscore) between parts; the machine name itself contains hyphens, so in a file name the `__`
becomes `--` and the machine-name hyphens stay as hyphens.

Extend or reorder these with the standard `hook_theme_suggestions_block_alter()` in a theme or module.

Note: the module's README shows the older `block--block_content--<name>` form; the code as shipped in
3.0.x emits the underscore theme-hook names above (rendered file names use `block-content`, with a
hyphen).
