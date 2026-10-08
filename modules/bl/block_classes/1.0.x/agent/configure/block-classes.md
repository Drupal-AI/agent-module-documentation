<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting block CSS classes

There is **no settings page** (`configure: null`). Classes are per *block placement*
(a `block` config entity), set on the block configure form or directly in config.

## Config location

```yaml
# config: block.block.<block_id>
third_party_settings:
  block_classes:
    block_class: 'card card--wide'      # goes on the block wrapper
    title_class: 'visually-hidden'      # goes on the block title
    content_class: 'grid grid--3col'    # goes on the block content wrapper
```

All three keys are optional strings (`#maxlength` 255). Multiple classes are **separated by
spaces**. `hook_block_presave()` (`block_classes_block_presave()`) **unsets** any of the three
keys whose value is empty, so an unused key simply does not appear in the exported config.

Schema: `block.block.*.third_party.block_classes` (three `string` keys) — see
`config/schema/block_classes.schema.yml`.

## Via the UI

1. *Administration → Structure → Block layout* (`/admin/structure/block`).
2. **Configure** on the block placement you want.
3. Fill in **Title CSS class(es)**, **Content CSS class(es)** and/or **Block CSS class(es)**
   (the last one is described as "Customize the styling of this block by adding CSS classes.
   Separate multiple classes by spaces.").
4. **Save block**.

The three fields are only rendered when the current user has
`administer block css classes` — see [../permissions/permissions.md](../permissions/permissions.md).

## Via PHP (drush php:eval / update hook / deploy script)

```php
$block = \Drupal\block\Entity\Block::load('olivero_powered');
$block->setThirdPartySetting('block_classes', 'block_class', 'card card--wide');
$block->setThirdPartySetting('block_classes', 'title_class', 'visually-hidden');
$block->setThirdPartySetting('block_classes', 'content_class', 'grid');
$block->save();
```

Remove one again with `$block->unsetThirdPartySetting('block_classes', 'title_class');`
(or set it to `''` — presave will drop it).

## Read it back

```bash
drush config:get block.block.<block_id> third_party_settings.block_classes
```

```php
\Drupal\block\Entity\Block::load('<block_id>')
  ->getThirdPartySetting('block_classes', 'block_class');
```

## Gotchas

- The class string is stored **verbatim**; sanitisation happens at render time with
  `Html::cleanCssIdentifier($class, [])`. Because the filter map is empty, `_` and `/` are *not*
  rewritten to `-`; only characters invalid in a CSS identifier are stripped and a leading digit
  or `--` is escaped. So `my_class` stays `my_class`, but `1col` renders as `_col`.
- Setting the value on the *block plugin* configuration (`settings`) does nothing — it must be
  a **third-party setting on the block entity**.
- Blocks rendered without an `#id` (e.g. Page Manager block widgets) get no classes.
