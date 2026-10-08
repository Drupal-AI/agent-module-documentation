<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDC component: `menu_tree:menu-tree`

A Single Directory Component under `components/menu-tree/` renders the tree. It is not a block
or a plugin type — it is invoked from a render array with `#type => 'component'` and
`#component => 'menu_tree:menu-tree'` (from the `menu_tree` form element). You can reuse it
anywhere a render array is accepted, or override its Twig/CSS/JS from a theme.

Files: `menu-tree.component.yml` (schema), `menu-tree.twig`, `menu-tree.js`, `menu-tree.css`.

## Props (`menu-tree.component.yml`)

| Prop | Type | Required | Notes |
| --- | --- | --- | --- |
| `menus` | array | yes | List of `{label, id, menu_tree: [...]}` structures (one per menu), as returned by `MenuTreeItems::getLinks()`. |
| `exclude` | string | yes | `<menu_name>:<plugin_id>` of the link to render disabled/non-selectable (e.g. the item's own link so it can't be its own parent). Default `''`. |
| `attributes` | `Drupal\Core\Template\Attribute` | no | Wrapper attributes (the element sets `id` + `menu-tree` class). |
| `expanded_menu` | string | no | Id of the menu to render `open`. Default `main`. |

Library dependencies (declared via `libraryOverrides`): `core/jquery`, `core/drupal`,
`core/drupalSettings`, `core/once`.

## Rendering

```php
$build['tree'] = [
  '#type' => 'component',
  '#component' => 'menu_tree:menu-tree',
  '#props' => [
    'menus' => [\Drupal::service(\Drupal\menu_tree\MenuTreeItems::class)->getLinks('main')],
    'exclude' => '',
    'expanded_menu' => 'main',
  ],
];
```

## Markup & behavior

`menu-tree.twig` emits, per menu, a nested `<ul role="tree">` of `<details>/<summary>`
disclosure nodes with a `<button class="select-item" data-value="<menu>:<plugin_id>"
data-weight="…">` per link; the excluded link is rendered `disabled`. A search/filter box,
a clear button, an `aria-live` status region and a "no results" message are rendered above the
tree. Link titles (`{{ menu_item.text }}`, `{{ menu.label }}`) are printed through Twig
auto-escaping.

`menu-tree.js` (`Drupal.behaviors.menuTree`, scoped per instance via `once('menu-tree', …)`)
wires: item selection, an expand/collapse-all toggle, HTML5 drag-and-drop with edge auto-scroll
and hover-to-expand of closed branches, a debounced filter, and live mirroring of the menu-link
title into the draggable placeholder. It writes the chosen parent into the hidden `menu_parent`
input and the drop position into hidden `prev_sibling` / `next_sibling` inputs (input names
derived from `drupalSettings.menu_tree.elementName`) that the submit handler consumes. Dynamic
text is written with `textContent` (titles) or hard-coded `Drupal.t()` strings; the one
`innerHTML` assignment uses a fixed static markup string, with the user-controlled title set
separately via `textContent` — so menu titles are not interpolated into HTML.

To restyle or restructure the widget, override the component from a theme (place a
`components/menu-tree/` dir or use component overrides) rather than patching the module. The
visual tree style is adapted from Kate Morley's "Tree views in CSS".
