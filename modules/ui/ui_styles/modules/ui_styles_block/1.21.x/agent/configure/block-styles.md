<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply UI Styles to a block

## Where it lives

Each placed block is a `block.block.<id>` config entity. UI Styles Block stores its
selections in that entity's third-party settings under the `ui_styles` provider, with three
independent parts:

```yaml
# block.block.<id>
third_party_settings:
  ui_styles:
    block:                       # classes for the block wrapper -> attributes
      selected:
        text_color: text-primary
      extra: 'my-block-class'
    title:                       # classes for the block title -> title_attributes
      selected: {}
      extra: 'h4'
    content:                     # classes for the block content -> content_attributes
      selected:
        spacing: p-3
      extra: ''
```

Each part is a `ui_styles.selected_mapping` (`{selected: {style_id: class}, extra: "free classes"}`).
`PreprocessBlock` merges the resulting classes onto `attributes` / `title_attributes` /
`content_attributes` respectively.

## Via the UI

1. Go to *Structure → Block layout* (`/admin/structure/block`).
2. Configure (or place) a block. On its config form you'll see UI Styles selectors for
   **Block**, **Title** and **Content**.
3. Pick options and/or type extra classes; **Save block**.

## Via drush php:eval (scriptable)

```php
$block = \Drupal::entityTypeManager()->getStorage('block')->load('my_block_id');
$block->setThirdPartySetting('ui_styles', 'content', [
  'selected' => ['text_color' => 'text-primary'],
  'extra' => 'ui-styles-eval-content',
]);
$block->save();
```

Note: `BlockPresave` unsets a part whose value is empty, so saving an empty selection
removes the key rather than storing a blank.

## Read it back

```bash
drush cget block.block.my_block_id third_party_settings.ui_styles
```
