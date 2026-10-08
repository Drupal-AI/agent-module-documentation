<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing a role-restricted Navigation menu block

There is no settings form. You configure the module by placing one of its **block plugins**
and choosing roles on the block.

## Plugin ids

One derivative per site menu, id `navigation_menu_role:<menu_machine_name>`:
`navigation_menu_role:main`, `navigation_menu_role:admin`, `navigation_menu_role:account`,
`navigation_menu_role:footer`, `navigation_menu_role:tools`, … (one per menu that exists).

## Block settings

Stored in the `block.block.<id>` config entity under `settings` (schema
`block.settings.navigation_menu_role:*`):

| Key | Type | Meaning |
|---|---|---|
| `level` | integer | Starting menu level (default `1`). |
| `depth` | integer | Max number of levels to show, `0`–`3` (Navigation cap; default `0` = unlimited within cap). |
| `roles` | array of role ids | Roles allowed to see the block. **Empty = visible to everyone.** |

`blockAccess()` allows the block when `roles` is empty **or** the current user has at least
one listed role. The block's `label`/`label_display` come from the standard block settings;
`expand_all_items` is removed from the form.

## UI flow

The block is flagged `allow_in_navigation` and hidden from the generic Block layout UI, so
you place it through the **Navigation** editing UI (the left sidebar's menu management), pick
the menu derivative, set level/depth, and tick the **Roles** under the "Roles" details.

## Programmatic placement

```php
use Drupal\block\Entity\Block;
$theme = \Drupal::config('system.theme')->get('default');
Block::create([
  'id' => 'nmr_editor_main',
  'plugin' => 'navigation_menu_role:main',
  'theme' => $theme,
  'region' => 'content',            // region is irrelevant to role gating; navigation places it
  'settings' => [
    'id' => 'navigation_menu_role:main',
    'label' => 'Main (editors)',
    'label_display' => '0',
    'level' => 1,
    'depth' => 0,
    'roles' => ['content_editor'],  // only this role sees it; [] = everyone
  ],
])->save();
```

Read a placed block's role restriction with
`\Drupal\block\Entity\Block::load($id)->get('settings')['roles']`.
