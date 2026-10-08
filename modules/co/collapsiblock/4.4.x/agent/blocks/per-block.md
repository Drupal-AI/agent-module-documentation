# Per-block collapse behavior

Every block can override the global default with its own collapse behavior, stored as a
Collapsiblock third-party setting on the block. There is no separate block type — Collapsiblock
alters the existing block config forms.

## Classic block layout (`block` module)

`collapsiblock_form_block_form_alter()` (hook_form_FORM_ID_alter for `BlockForm`) adds a
`Collapsible` details element with a `collapse_action` radios field. Options are the standard
[action codes](../configure/settings.md) plus a leading `0 = "Global default, currently set to: …"`.

Saved by the entity builder `collapsiblock_block_form_form_builder()` into the block's third-party
settings:
- `collapse_action == 0` → `unsetThirdPartySetting('collapsiblock', 'collapse_action')` (falls back to global default).
- otherwise → `setThirdPartySetting('collapsiblock', 'collapse_action', <int>)`.

Config path: `block.block.<id>.third_party.collapsiblock.collapse_action` (schema
`block.block.*.third_party.collapsiblock`).

At render time `collapsiblock_block_view_alter()` reads the block's `collapse_action` (defaulting to
`0` → global `default_action`) and, when the effective action `!= 1`, injects the wrapper markup
(see [theme/markup.md](../theme/markup.md)).

### Set it in code

```php
$block = \Drupal\block\Entity\Block::load('bartik_powered');
$block->setThirdPartySetting('collapsiblock', 'collapse_action', 3); // collapsed by default
$block->save();
// Or clear to inherit the global default:
$block->unsetThirdPartySetting('collapsiblock', 'collapse_action');
$block->save();
```

## Layout Builder blocks

`collapsiblock_form_alter()` adds the same `Collapsible` radios to the
`layout_builder_add_block` and `layout_builder_update_block` forms. The submit handler
`collapsiblock_form_layout_builder_submit()` (unshifted onto `#submit`) stores the value on the
`SectionComponent`'s `additional` array: `additional.collapsiblock.collapse_action` (action `0`
unsets it so the component inherits the global default).

Rendering for Layout Builder is handled by the event subscriber
`Drupal\collapsiblock\EventSubscriber\LayoutBuilderBlockComponentRender` (service
`collapsiblock.layout_builder_block_component_render`, event `section_component.build.render_array`),
not by `hook_block_view_alter`. It reads `additional.collapsiblock.collapse_action` (→ global
default when `0`) and, when the effective action `!= 1`, adds the same `#collapsiblock` prefix/suffix
markup (with an `Html::getId()`-sanitised id including the component UUID) and registers
`collapsiblock.settings` as a cacheable dependency. The subscriber avoids the
`layout_builder` constant directly so it is safe when Layout Builder is disabled.
