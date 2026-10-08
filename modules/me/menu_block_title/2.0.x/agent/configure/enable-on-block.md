# Enable "Block title as menu link parent" on a menu block

There is **no configure route** (`configure: null`) and no settings form. The feature is a single
checkbox on each menu block's configuration form, stored as a third-party setting.

## Where the flag is stored

```yaml
# block.block.<block_id>
third_party_settings:
  menu_block_title:
    modify_title: true
```

The checkbox is added by `menu_block_title_form_block_form_alter()` and only appears when the block
form contains `settings[menu_levels]` — i.e. **menu-based blocks**: core system menu block
derivatives (`system_menu_block:<menu>`, e.g. `system_menu_block:main`) and blocks from the contrib
`menu_block` module. It does nothing on non-menu blocks, and has no effect if the block title is
hidden (`label_display` off).

## Via the UI

1. Go to *Structure → Block layout* and edit (or place) a menu block —
   `/admin/structure/block/manage/<block_id>`.
2. Ensure **Display title** is checked (the title must be visible).
3. At the bottom tick **"Block title as menu link parent"**
   ("If checked the title of this block will display the parent of the active menu item.").
4. **Save block**. For useful output, configure the block to start at menu level 2.

## Via drush php:eval (scriptable)

```php
use Drupal\block\Entity\Block;
$block = Block::load('sidebar_section_nav');       // an existing menu block
$block->setThirdPartySetting('menu_block_title', 'modify_title', TRUE);
$block->save();
```

Create a menu block from scratch and enable it:

```php
use Drupal\block\Entity\Block;
$block = Block::create([
  'id' => 'section_nav',
  'plugin' => 'system_menu_block:main',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'sidebar_first',
  'settings' => [
    'id' => 'system_menu_block:main',
    'label' => 'Main navigation',
    'label_display' => 'visible',
    'level' => 2,
    'depth' => 0,
  ],
]);
$block->setThirdPartySetting('menu_block_title', 'modify_title', TRUE);
$block->save();
```

## Read it back

```bash
drush cget block.block.section_nav third_party_settings.menu_block_title.modify_title
```

Or in PHP: `Block::load('section_nav')->getThirdPartySetting('menu_block_title', 'modify_title')`.
Turn it off by setting the value to `FALSE` (or `unsetThirdPartySetting('menu_block_title', 'modify_title')`).
