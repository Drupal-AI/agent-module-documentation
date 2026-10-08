<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Store and apply styles on a placed block

Enable with `drush en ui_styles_block`. Requires `block` + `ui_styles`. No route,
permission or settings form — every setting lives on the `block.block.<id>` config entity.

## The three parts

`FormBlockFormAlter::blockFormAlter()` adds a `container` `ui_styles` on the block
configuration form (Block layout → Configure block) with three `ui_styles_styles` selectors,
scoped to the block's theme (`#drupal_theme`):

| part id | form title | rendered onto |
|---|---|---|
| `block`   | Block styles   | block `attributes` |
| `title`   | Title styles   | block `title_attributes` (hidden when "Display title" is off) |
| `content` | Content styles | the block's `content` render array |

## Storage

`BlockPresave::setThirdPartySettings()` copies each non-empty part into the block's
third-party settings and unsets empty ones:

```
block.block.<id>:
  third_party_settings:
    ui_styles:
      block:   { selected: { text_color: text-primary }, extra: 'shadow' }
      title:   { selected: {...}, extra: '' }
      content: { selected: {...}, extra: '' }
```

Schema `block.block.*.third_party.ui_styles` (each part is a `ui_styles.selected_mapping`).

## Render

`PreprocessBlock::preprocess()` (a `template_preprocess_block` handler) loads the block by
`#id`, then `addClassesOnBlock()`:

- `block` → merged onto `$variables['attributes']` via `AttributeHelper::mergeCollections`.
- `title` → merged onto `$variables['title_attributes']`.
- `content` → because the default `block.html.twig` ignores `content_attributes`, the
  classes are injected into `$variables['content']` with
  `StylePluginManager::addClasses($content, $selected, $extra)`, which drills to the first
  attribute-accepting element (or wraps it).

## Set from code

```php
$block = \Drupal\block\Entity\Block::load('bartik_search');
$block->setThirdPartySetting('ui_styles', 'block', [
  'selected' => ['background' => 'bg-primary'],
  'extra' => 'rounded shadow',
]);
$block->save();
```
