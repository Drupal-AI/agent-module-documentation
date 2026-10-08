# Blocks, condition, cache context, lookup service, hooks

## Blocks

- **`entity_hierarchy_microsite_menu`** (Microsite menu) — renders the microsite's generated
  menu. Settings (`block.settings.entity_hierarchy_microsite_menu`): `field` (which hierarchy
  field), `level` (starting level), `depth` (max levels), `expand_all_items` (bool).
- **`entity_hierarchy_microsite_branding`** (Microsite branding) — renders the microsite
  `logo`. Setting: `field` (the hierarchy field used to resolve the microsite).

## Block visibility condition

- **`entity_hierarchy_microsite_child`** ("child of a microsite") — a `condition.plugin` that
  is TRUE when the current node is the home node or a hierarchy descendant of some microsite.
  Setting: `field`. Use it in a block's Visibility settings to scope a block to a section.

## Cache context

- `entity_hierarchy_microsite` (`MicrositeCacheContext`) — vary render output by which
  microsite the current page belongs to. The menu/branding blocks and the condition rely on
  it, so section-scoped output caches correctly.

## Lookup service

`ChildOfMicrositeLookup` (interface `ChildOfMicrositeLookupInterface`):

```php
$lookup = \Drupal::service('entity_hierarchy_microsite.microsite_lookup'); // see services.yml
$microsites = $lookup->findMicrositesForNodeAndField($node, 'field_parent');
// returns the Microsite entities whose home node is an ancestor of (or is) $node
```

It walks the parent module's nested-set tree to find, for a node and a given hierarchy field,
the microsite(s) it belongs to.

## Alter hooks (`entity_hierarchy_microsite.api.php`)

- `hook_entity_hierarchy_microsite_menu_item_url_alter(Url $url, MicrositeMenuItemOverrideInterface $override, MicrositeMenuItem $menu_link)`
  — change the URL of a generated menu item (e.g. for a decoupled front end).
- `hook_entity_hierarchy_microsite_links_alter(array $links)` — add/adjust the generated
  microsite links.
