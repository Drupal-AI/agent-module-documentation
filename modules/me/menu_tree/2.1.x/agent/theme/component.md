# SDC component: `menu_tree:menu-tree`

A Single Directory Component under `components/menu-tree/` renders the tree. It is not a block or a
plugin type — it is invoked from a render array with `#type => 'component'` and
`#component => 'menu_tree:menu-tree'` (see `Hooks::nodeFormAlter()`). You can reuse it anywhere a
render array is accepted, or override its Twig/CSS/JS from a theme.

Files: `menu-tree.component.yml` (schema), `menu-tree.twig`, `menu-tree.js`, `menu-tree.css`.

## Props (`menu-tree.component.yml`)

| Prop | Type | Required | Notes |
| --- | --- | --- | --- |
| `menus` | array | yes | List of `{label, id, menu_tree: [...]}` structures, e.g. one per available menu, as returned by `MenuTreeItems::getLinks()`. |
| `exclude` | string | yes | `<menu_name>:<plugin_id>` of the link to render disabled/non-selectable (the node's own link). |
| `attributes` | `Drupal\Core\Template\Attribute` | no | Wrapper attributes. |
| `expand_collapse_state` | string enum `expand`\|`collapse` | no | Initial state of the expand/collapse toggle. Default `expand`. |

`Hooks::nodeFormAlter()` also passes a `selected` value in `#props` (the current parent id); the
Twig template reads `menus`, `exclude`, `expand_collapse_state` and lets the JS apply the selection.

Library dependencies (declared via `libraryOverrides`): `core/jquery`, `core/drupal`, `core/once`.

## Rendering

```php
$build['tree'] = [
  '#type' => 'component',
  '#component' => 'menu_tree:menu-tree',
  '#props' => [
    'menus' => [\Drupal::service('menu_tree.items')->getLinks('main')],
    'exclude' => '',
    'expand_collapse_state' => 'expand',
  ],
];
```

## Markup & behavior

`menu-tree.twig` emits a nested `<ul role="tree">` of `<details>/<summary>` disclosure nodes with a
`<button class="select-item" data-value="<menu>:<plugin_id>">` per link; the excluded link is
rendered `disabled`. Link titles (`{{ menu_item.text }}`, `{{ menu.label }}`) are printed through
Twig auto-escaping. `menu-tree.js` (`Drupal.behaviors.menuTree`) wires selection, the expand/collapse
toggle, and HTML5 drag-and-drop reordering, writing the chosen parent into the hidden
`menu[menu_parent]` input and the drop position into hidden `menu[prev_sibling]` / `menu[next_sibling]`
inputs that the submit handler consumes.

To restyle or restructure the widget, override the component from a theme (place a
`components/menu-tree/` dir or use `hook_theme` component overrides) rather than patching the module.
The visual tree style is adapted from Kate Morley's "Tree views in CSS".
