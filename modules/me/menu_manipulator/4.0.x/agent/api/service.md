<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, link language field & hooks

## Tree manipulator service

`menu_manipulator.menu_tree_manipulators` →
`Drupal\menu_manipulator\Menu\MenuLinkTreeManipulators`. Injected: `entity.repository`,
`entity_type.manager`, `language_manager`, `config.factory`, `router.no_access_checks`.

| method | purpose |
|---|---|
| `filterTreeByCurrentLanguage(array $tree)` | return the menu tree with only current-language links |
| `filterItemsByCurrentLanguage(array &$items)` | filter an already-built `items` array (used in preprocess) |
| `checkLinkAccess(MenuLinkBase $link)` | access check preserved during filtering |

Use it directly:

```php
$tree = \Drupal::menuTree()->load('main', new \Drupal\Core\Menu\MenuTreeParameters());
$tree = \Drupal::service('menu_manipulator.menu_tree_manipulators')->filterTreeByCurrentLanguage($tree);
```

## Helper: render a filtered menu

`menu_manipulator_get_multilingual_menu(string $menu_name, ?MenuTreeParameters $parameters = NULL)`
(in `.module`) returns a language-filtered render array for `$menu_name` — handy in a block,
controller, or Twig via a preprocess.

## Menu-link language field

`menu_manipulator_form_menu_link_content_form_alter()` adds a **language** selector to the
menu link edit form; `menu_manipulator_menu_link_content_form_entity_builder()` writes the
chosen language back onto the `menu_link_content` entity. With
`preprocess_menus_language_use_entity`, the filter reads language from the entity a link
points to instead of the link's own langcode.

## Hooks & helpers (in `.module`)

- `hook_preprocess_menu()` — applies language filtering + icons per settings.
- `menu_manipulator_menu_is_filterable_by_language(string $menu_name)` — is a menu in the
  language list.
- `menu_manipulator_prepare_associative_list($string)` — parse the icon-list string.

The module defines **no plugin types, no Drush, no `.api.php` hooks** of its own — extend it
by calling the service or the helper above.
