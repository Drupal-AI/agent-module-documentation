<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Manipulator settings

One config object, `menu_manipulator.settings`, edited at
*Configuration → User interface → Menu Manipulator*
(`/admin/config/user-interface/menu-manipulator`, route `menu_manipulator.settings`,
permission `administer site configuration`).

## Keys (schema `menu_manipulator.settings`)

| key | type | default | meaning |
|---|---|---|---|
| `preprocess_menus_language` | bool | `true` | master switch for language filtering |
| `preprocess_menus_language_use_entity` | bool | `true` | resolve a link's language from its linked entity (else from the link's own langcode) |
| `preprocess_menus_language_list` | map | `{footer: footer, main: main, account: '', admin: '', links: '', tools: ''}` | which menus are language-filtered |
| `preprocess_menus_icon` | bool | `true` | master switch for per-link icons |
| `preprocess_menus_icon_list` | map | all menus `''` | which menus get icons |
| `menu_link_icon_list` | string | (unset) | newline/comma list of available icon names offered on the link form |

### The menu list maps

`preprocess_menus_language_list` and `preprocess_menus_icon_list` are **sequences keyed by
menu machine name**. A menu is active when its value equals its own machine name
(`main: main`); it is inactive when the value is an empty string (`main: ''`). This mirrors
how core "checkboxes" form elements serialise.

```bash
drush cget menu_manipulator.settings
# enable language filtering on the 'tools' menu:
drush cset menu_manipulator.settings preprocess_menus_language_list.tools tools -y
# disable it again:
drush cset menu_manipulator.settings preprocess_menus_language_list.tools '' -y
```

Or in PHP:

```php
$c = \Drupal::configFactory()->getEditable('menu_manipulator.settings');
$list = $c->get('preprocess_menus_language_list');
$list['tools'] = 'tools';                 // 'tools' => '' turns it off
$c->set('preprocess_menus_language_list', $list)->save();
```

## Effect

When `preprocess_menus_language` is on and a menu is in `preprocess_menus_language_list`,
`hook_preprocess_menu` runs the tree through
`MenuLinkTreeManipulators::filterTreeByCurrentLanguage()`, dropping links whose resolved
language differs from the active language. Icons are attached similarly when
`preprocess_menus_icon` is on and the menu is in `preprocess_menus_icon_list`.
