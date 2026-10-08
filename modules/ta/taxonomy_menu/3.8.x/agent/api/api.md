# Programmatic API — service, entity & alter hook

## Sync service — `taxonomy_menu.helper`

`Drupal\taxonomy_menu\TaxonomyMenuHelper` (constructed with `entity_type.manager` and
`plugin.manager.menu.link`). This is what the term entity hooks call to keep menus in sync.

```php
/** @var \Drupal\taxonomy_menu\TaxonomyMenuHelper $helper */
$helper = \Drupal::service('taxonomy_menu.helper');

// All taxonomy_menu entities that target a vocabulary (reverse lookup):
$menus = $helper->getTermMenusByVocabulary('tags');

// Add/update/remove menu links for the vocabulary of $term.
// $rebuild_all = FALSE limits work to just this term's link.
$helper->generateTaxonomyMenuEntries($term, FALSE); // on insert
$helper->updateTaxonomyMenuEntries($term, FALSE);   // on update
$helper->removeTaxonomyMenuEntries($term, FALSE);   // on delete
```

`taxonomy_menu.module` wires these into `hook_taxonomy_term_insert`,
`hook_taxonomy_term_update`, and `hook_taxonomy_term_delete`, so term saves/deletes sync the
menu automatically — you rarely call the helper yourself.

## The `taxonomy_menu` config entity

`Drupal\taxonomy_menu\Entity\TaxonomyMenu` implements `TaxonomyMenuInterface`.

```php
use Drupal\taxonomy_menu\Entity\TaxonomyMenu;

$tm = TaxonomyMenu::create([
  'id' => 'tags_menu',
  'label' => 'Tags menu',
  'vocabulary' => 'tags',      // source vocabulary machine name
  'menu' => 'main',            // target menu machine name
  'depth' => 3,
  'expanded' => TRUE,
  'use_term_weight_order' => TRUE,
]);
$tm->save(); // builds + registers a menu link per term
```

Interface / entity methods:

- `getVocabulary()`, `getMenu()`, `getDepth()`, `getMenuParent()`, `getDescriptionFieldName()`
- `useTermWeightOrder()` — defaults to TRUE.
- `getLinks(array $base_plugin_definition = [], $include_base_plugin_id = FALSE)` — returns
  the menu link plugin definitions keyed by plugin id (one per term).
- `buildMenuPluginId(TermInterface $term, $include_base_plugin_id = TRUE)` — the derived link
  id, form `taxonomy_menu.menu_link.{entity_id}.{term_id}` (optionally prefixed with the base
  plugin id `taxonomy_menu.menu_link:`).
- `save()` adds/updates and `delete()` removes the definitions in the core menu link manager.

## Menu link plugin system (core-based, no new plugin type)

The links use core's menu link plugin type via a deriver:

- Deriver `Plugin\Derivative\TaxonomyMenuMenuLink` — loads every `taxonomy_menu` entity and
  merges its `getLinks()` into derivative definitions.
- Plugin `Plugin\Menu\TaxonomyMenuMenuLink` (extends `MenuLinkBase`) — renders `getTitle()`
  / `getDescription()` dynamically from the term (translation-aware), reports `isEnabled()`
  from the term's published status, and only allows overriding `weight`, `expanded`,
  `enabled`, `parent`.

The base plugin is declared in `taxonomy_menu.links.menu.yml` (`taxonomy_menu.menu_link`).

## Alter hook

`buildMenuDefinition()` invokes an alter on every generated link:

```php
/**
 * Implements hook_taxonomy_menu_link_alter().
 *
 * @param array $link                         The menu link plugin definition.
 * @param \Drupal\taxonomy\TermInterface $term The term the link is generated from.
 */
function mymodule_taxonomy_menu_link_alter(array &$link, $term) {
  // e.g. tweak $link['weight'], $link['expanded'], route, etc.
}
```

(The module ships no `taxonomy_menu.api.php`; the alter is `\Drupal::moduleHandler()->alter('taxonomy_menu_link', $link, $term)`.)
