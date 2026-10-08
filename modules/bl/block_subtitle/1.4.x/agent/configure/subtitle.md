<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: set a block's subtitle

There is **no settings page**. The subtitle is a per-block value stored as a third-party setting on
the `block` config entity (provider `block_subtitle`, key `subtitle`). It is set on the standard
block configuration form and can also be set programmatically or via drush.

## Via the UI

Structure › Block layout (`admin/structure/block`) › **Configure** on any block. A **Subtitle**
textfield (`#weight: 10`) appears — but only if the current user has the `administer block subtitle`
permission (see permissions/permissions.md). Enter text and save; leave blank for no subtitle.

Mechanics (`block_subtitle.module`):
- `block_subtitle_form_block_form_alter()` adds `$form['settings']['block_subtitle_text']`
  (a `textfield`) with `#parents => ['block_subtitle_text']`, default from the existing setting.
  It also registers the entity builder `block_subtitle_block_form_builder`.
- `block_subtitle_block_form_builder()` calls
  `$block->setThirdPartySetting('block_subtitle', 'subtitle', $form_state->getValue('block_subtitle_text'))`.
- `block_subtitle_block_presave()` calls `unsetThirdPartySetting('block_subtitle', 'subtitle')`
  when the value is empty, so blank subtitles are removed from config rather than stored as `''`.

## Via PHP / drush

```php
use Drupal\block\Entity\Block;

$block = Block::load('olivero_powered');           // the block config entity ID
$block->setThirdPartySetting('block_subtitle', 'subtitle', 'Updates from across the org');
$block->save();

// Read it back:
$subtitle = $block->getThirdPartySetting('block_subtitle', 'subtitle');
```

Run with `drush php:eval "..."`. Or set the exported config value directly:

```
drush config:set block.block.olivero_powered \
  third_party_settings.block_subtitle.subtitle 'Updates from across the org'
```

The value exports with the block under
`third_party_settings.block_subtitle.subtitle` in `drush config:export`.

## Config schema

`config/schema/block_subtitle.schema.yml` defines
`block.block.*.third_party.block_subtitle` as a mapping with one key `subtitle` (`type: text`,
label "Add subtitle for the block"). No `config/install` — nothing is created on enable.
