# Setting a block's ID and classes

## Where

*Structure › Block layout* (`/admin/structure/block`) → **Configure** on any block. With the
**`administer block id`** permission, the block config form gains these fields (added by
`block_id_form_block_form_alter`, only when the current user has that permission):

| Form field | Third-party setting key (namespace `block_id`) | Effect |
|---|---|---|
| Block ID | `id` | Replaces the block wrapper's HTML `id`. |
| Title CSS class(es) | `title_class` | Classes added to the block **title** element. |
| Content CSS class(es) | `content_class` | Classes added to the block **content** wrapper. |
| Block CSS class(es) | `class_block` | Classes added to the block **wrapper**. |

Class fields are space-separated (multiple classes allowed), `#maxlength` 255. There is no dedicated
settings page and no config schema; values are stored on the `block` config entity's
`third_party_settings.block_id.*` and export with normal config.

## Save-time behavior

- `block_id_block_presave()` unsets any of the four settings that are empty, so blank fields leave no
  residue in the block config.
- `block_id_form_block_form_validate()` enforces **uniqueness of `id`**: it loads all block config
  entities, excludes the current one, and sets a form error if another block already uses the same
  `id` ("@block_id is already used by another block."). Empty `id` skips the check.

## Render-time mapping (`block_id_preprocess_block`)

For the block being rendered (looked up via `Block::load($elements['#id'])`):

- `id` → `$variables['attributes']['id'] = explode(' ', $ids)` — applied **verbatim** (not passed
  through `Html::cleanCssIdentifier()`); Drupal's attribute rendering escapes the value on output.
- `title_class` → each space-split part → `Html::cleanCssIdentifier()` → `title_attributes['class'][]`.
- `content_class` → same, into `content_attributes['class'][]`.
- `class_block` → same, into `attributes['class'][]`.

## Notes

- The `id`/class values are author-controlled markup set by users holding `administer block id`
  (a trusted, admin-level permission); grant it accordingly. Classes are sanitized as CSS
  identifiers; the `id` is emitted as-is and relies on core attribute escaping.
- Because IDs must be unique, reusing the same custom ID on two blocks is blocked at save time — plan
  distinct IDs per block instance.
