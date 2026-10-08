<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Entity Note Block

`src/Plugin/Block/EntityNoteBlock.php` — class `EntityNoteBlock extends BlockBase implements
ContainerFactoryPluginInterface`.

- Annotation `@Block(id = "entity_note_modal_button_block", admin_label = "Entity Note Block")`.
- DI: `create()` injects `current_route_match` into `$this->routeMatch` (stored but not used by
  `build()`).
- `build()`:
  - Builds `Url::fromRoute('entity_note_block.notes_form')` and sets link attributes
    `class => ['use-ajax','button','button--primary']`, `data-dialog-type => modal`,
    `data-dialog-options => json_encode(['width' => 600])`.
  - Returns `Link::fromTextAndUrl('📝 Add/View Notes', $url)->toRenderable()`.
  - Attaches `core/drupal.dialog.ajax`.

Net effect: the block is only a launcher button. It carries no block settings form, no cache
config beyond defaults, and no per-entity context — it always opens the same global notes modal
regardless of which page/entity the block is placed on.

## Placement

Structure → Block layout → "Place block" → "Entity Note Block" → choose region. Also selectable
in Layout Builder where custom blocks are allowed. Visibility is controlled with the standard
core block visibility conditions plus the modal route's `view entity notes` permission.
