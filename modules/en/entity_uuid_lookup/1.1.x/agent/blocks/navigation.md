<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar, navigation block & entry points

The module exposes the lookup form (`entity_uuid_lookup.admin`) through three UI entry points, all gated by the
`lookup entities by uuid` permission.

## Admin toolbar item — `hook_toolbar()` in `entity_uuid_lookup.module`
- Returns nothing unless the current user has `lookup entities by uuid`.
- Adds a `toolbar_item` `entity_uuid_lookup` (weight -5) linking to `entity_uuid_lookup.admin`.
- The link opens the form in a **modal** dialog (`#ajax` → `dialogType: modal`, width 800, no progress).
- Cache context `user.permissions`; attaches library `entity_uuid_lookup/toolbar`.

## Navigation block — `src/Plugin/Block/NavigationEntityUuidLookupBlock.php`
`#[Block(id: 'navigation_entity_uuid_lookup', admin_label: 'Navigation Entity UUID Lookup')]`, extends
`BlockBase` and implements `ContainerFactoryPluginInterface`.
- `blockAccess()` → `AccessResult::allowedIfHasPermission($account, 'lookup entities by uuid')`.
- `build()` renders a `navigation_menu` themed item ("UUID lookup") linking to `entity_uuid_lookup.admin` with
  `use-ajax` / `data-dialog-type=modal` (800px), an icon from the `entity_uuid_lookup` pack, and attaches
  `core/drupal.ajax` + `entity_uuid_lookup/navigation`.

## `hook_block_alter()` in `entity_uuid_lookup.module`
For the `navigation_entity_uuid_lookup` definition it sets `allow_in_navigation = TRUE` and
`_block_ui_hidden = TRUE` — so the block is placeable in the core **Navigation** module but hidden from the
normal Block UI.

## Icons & libraries
- `entity_uuid_lookup.icons.yml` — declares the `entity_uuid_lookup` SVG icon pack (extractor `svg`, source
  `images/*.svg`, default size 20), used by the navigation item.
- `entity_uuid_lookup.libraries.yml` — two CSS-only libraries: `toolbar` (`css/toolbar.css`) and `navigation`
  (`css/navigation.css`).

## Menu link
`entity_uuid_lookup.links.menu.yml` adds the "UUID lookup" link under `system.admin_content` (Content admin).
