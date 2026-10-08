<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# The `drag_and_drop_block` block type

Installed from `config/optional/` when the submodule is enabled (config `enforced` to
`dxpr_builder_block`). Pure configuration — the module ships no PHP.

## Block content type
- `block_content.type.drag_and_drop_block` — id `drag_and_drop_block`, label
  "Drag and Drop Block", `revision: 1`.

## Field & displays
- `field.field.block_content.drag_and_drop_block.body` — the DXPR-editable body field.
- Default **view** display
  (`core.entity_view_display.block_content.drag_and_drop_block.default`): the `body` component's
  `type` is **`dxpr_builder_text`**. Confirm live:
  ```php
  \Drupal::entityTypeManager()->getStorage('entity_view_display')
    ->load('block_content.drag_and_drop_block.default')->getComponent('body')['type']; // dxpr_builder_text
  ```
- A default **form** display ships too.

## Usage
Nothing to configure. Create blocks of this type via *Content → Blocks → Add custom block →
"Drag and Drop Block"*, or programmatically:
```php
\Drupal\block_content\Entity\BlockContent::create([
  'type' => 'drag_and_drop_block', 'info' => 'My hero',
])->save();
```
Then place the block through *Structure → Block layout* like any custom block. The body is
authored with the DXPR Builder drag-and-drop editor.

> Note: the shipped `field.field.block_content.drag_and_drop_block.body` declares
> `field_type: text_with_summary`, so the shared `block_content.body` field **storage** must be
> `text_with_summary` (the Drupal standard-profile default). On a site where that storage is
> `text_long`, saving a `drag_and_drop_block` entity throws "Property summary is unknown" — the
> display config is unaffected either way.
