<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Applying a style to a block

There is **no admin settings page** (`configure: null`). You configure Block Styles per block, on the
block's own configuration form, or directly in the `block_styles` config entity.

## Via the UI

1. Edit a placed block (e.g. *Structure → Block layout → Configure* on any block).
2. Open the **Block Styles Template** fieldset (collapsed by default).
3. **Select block style** — the options are Styles API styles of `type: block` (e.g. "Clean Wrapper",
   or the Bootstrap styles). "None" leaves the block unstyled.
4. **Text for button label** — only enabled for styles whose definition sets `extras.label` (the
   interactive Bootstrap styles); it becomes the button text.
5. **Add classes to block wrapper** — space-separated CSS classes added to the block's wrapper.
6. Save the block. A log message records the saved style.

## Where it is stored

A `block_styles` config entity, whose **id is the block's id** and whose config name is
**`block_styles.blocks.<block_id>`** (the entity's `config_prefix` is `blocks`). Fields:

| Key | Meaning |
|---|---|
| `id` | the block id this style applies to |
| `theme` | the selected style / template-suggestion id, e.g. `block__clean` |
| `classes` | space-separated wrapper CSS classes |
| `text` | button label (interactive styles only) |

```yaml
# config: block_styles.blocks.mysite_promo
id: mysite_promo
theme: block__clean
classes: 'is-featured border'
text: ''
```

## Via drush / code (scriptable)

```php
$storage = \Drupal::entityTypeManager()->getStorage('block_styles');
// Create or update the style for a block whose id is 'mysite_promo':
$entity = $storage->load('mysite_promo') ?: $storage->create(['id' => 'mysite_promo']);
$entity->set('theme', 'block__clean');       // a registered style id (type: block)
$entity->set('classes', 'is-featured border');
$entity->set('text', '');
$entity->save();
```

Read it back:

```php
$style = \Drupal::entityTypeManager()->getStorage('block_styles')->load('mysite_promo')->getStyle();
// => ['theme' => 'block__clean', 'classes' => 'is-featured border', 'text' => '']
```

or `drush cget block_styles.blocks.mysite_promo`.

> The `theme` value must be a real style id registered through the Styles API (see
> [../theming/styles.md](../theming/styles.md) — e.g. `block__clean`, `block__bootstrap__card`). If
> the style's provider is a **theme**, the styling only applies when that theme is active.
