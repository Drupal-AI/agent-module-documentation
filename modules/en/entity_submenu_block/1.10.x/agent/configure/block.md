# Entity Submenu Block — block config & behavior

No settings page. Add the block at **Structure → Block layout → Place block**, pick the derivative
for the menu you want (labelled `"<Menu> (Entity Submenu Block)"`), and set the options below.

## Plugin & derivatives
- Block plugin `entity_submenu_block` (`Plugin/Block/EntitySubmenuBlock`, extends
  `system\Plugin\Block\SystemMenuBlock`).
- Deriver `Plugin/Derivative/EntitySubmenuBlock` (extends core `SystemMenuBlock` deriver) creates
  one derivative per menu entity, e.g. `entity_submenu_block:main`.

## Settings (`block.settings.entity_submenu_block:*`)
Extends `block.settings.system_menu_block:*` (so core menu-block keys exist) and adds:

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `view_modes` | map (entity_type → view_mode id) | `[]` | View mode used to render each entity type's child links. Empty/"- None -" disables that type. Legacy `view_mode_<type>` keys are read as a fallback (see update 10001). |
| `display_non_entities` | bool | `false` | Also render non-entity / external menu links as plain `<a>` (via `entity_submenu_item`). |
| `only_current_language` | bool | `false` | Skip entities not translated in the current content language. |
| `show_if_empty` | bool | `false` | Render the (empty) wrapper even with no items; otherwise `build()` returns `[]` and the block is hidden. |

The block form (`blockForm`) removes the parent's `menu_levels` control and lists a view-mode
`select` for every eligible entity type. Eligible types = `node` plus any entity type that has a
`field_ui_base_route` and a view-builder handler (`isValidEntity`).

## Build logic (`prepareBuild`)
1. Uses the block's derivative id as the menu name; if the active trail isn't in that menu → empty.
2. Loads enabled links at the level at the end of the active trail (min/max depth = current level;
   for start levels > 1 it re-roots on the active trail parent).
3. Applies `checkAccess` + `generateIndexAndSort` tree manipulators; skips `InaccessibleMenuLink`.
4. For each link with a routed URL: takes the first route parameter as the entity type; if that
   type has a non-empty configured view mode and is eligible, loads the entity and renders it with
   `getViewBuilder($type)->view($entity, $view_mode)`. With `only_current_language`, entities lacking
   the current language translation are skipped.
5. Non-entity/external links render as `entity_submenu_item` **only if** `display_non_entities`.
6. Adds cache context `route.menu_active_trails:<menu>` (plus `route` from `getCacheContexts`).

## Theming
- `entity_submenu` (vars `menu_name`, `menu_items`) → `templates/entity-submenu.html.twig`
  (wrapper `<div class="entity-submenu">`; empty variant `entity-submenu--empty`).
- `entity_submenu_item` (vars `url`, `title`) → `templates/entity-submenu-item.html.twig` (`<a>`).
- Template suggestion `entity_submenu__<menu_name>` (dashes → underscores).

## Place with Drush (example)
```php
// drush php:eval — place an Entity Submenu Block for the 'main' menu, node→teaser.
\Drupal::entityTypeManager()->getStorage('block')->create([
  'id' => 'olivero_section_submenu',
  'theme' => 'olivero',
  'region' => 'sidebar',
  'plugin' => 'entity_submenu_block:main',
  'settings' => [
    'id' => 'entity_submenu_block:main',
    'label' => 'In this section',
    'view_modes' => ['node' => 'teaser'],
    'display_non_entities' => TRUE,
    'only_current_language' => FALSE,
    'show_if_empty' => FALSE,
  ],
])->save();
```
