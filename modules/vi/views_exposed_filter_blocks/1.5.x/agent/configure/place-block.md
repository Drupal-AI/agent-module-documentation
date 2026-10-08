<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place & configure a Views exposed filter block

The module has **no admin settings page** (`configure: null`). You configure it entirely by
placing one or more instances of its block plugin and setting two options per instance.

## The two settings

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `view_display` | string `"<view_id>:<display_id>"` | `null` (required) | The view + display whose exposed filters to render, e.g. `content:page_1`. Options come from `Views::getViewsAsOptions(FALSE, 'enabled')` — all enabled displays. |
| `form_state_always_process` | boolean | `true` | When on, the block processes submitted input on build (shows & handles submitted values). Turn **off** if the block should only submit values to the results view, not display them itself. |

## Via the UI

1. Go to *Structure → Block layout* (`/admin/structure/block`).
2. Click **Place block** on the target region; search for **Views exposed filter block**
   (category "Views Exposed Filter Blocks").
3. Select the **View & Display** that holds the exposed filters.
4. Optionally untick **Always process the form state** if the block only feeds a results view.
5. Set block visibility/region as usual and **Save**.
6. On the target view: **disable AJAX**, and keep the block and the results on the **same page**
   so filter GET parameters reach the view.

## Where it is stored

Each placed block is a `block.block.<id>` config entity:

```yaml
# drush cget block.block.<id>
id: <id>
theme: olivero
region: content
plugin: views_exposed_filter_blocks_block
settings:
  id: views_exposed_filter_blocks_block
  label: 'My filters'
  label_display: '0'
  provider: views_exposed_filter_blocks
  view_display: 'content:page_1'
  form_state_always_process: true
visibility: {  }
```

## Via drush php:eval (scriptable)

```php
use Drupal\block\Entity\Block;
Block::create([
  'id' => 'my_filter_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'sidebar',
  'plugin' => 'views_exposed_filter_blocks_block',
  'settings' => [
    'id' => 'views_exposed_filter_blocks_block',
    'label' => 'My filters',
    'label_display' => '0',
    'provider' => 'views_exposed_filter_blocks',
    'view_display' => 'content:page_1',   // "<view_id>:<display_id>"
    'form_state_always_process' => TRUE,
  ],
  'visibility' => [],
])->save();
```

## Read it back

```bash
drush cget block.block.my_filter_block settings.view_display
drush cget block.block.my_filter_block settings.form_state_always_process
```

The config schema (`block.settings.views_exposed_filter_blocks_block`) validates only
`view_display` (string) and `form_state_always_process` (boolean); everything else is core
`block_settings`.
