# Services

Declared in `menu_tree.services.yml`. All are plain PHP services (no tags, no events).

| Service id | Class | FQN alias | Constructor deps |
| --- | --- | --- | --- |
| `menu_tree.items` | `MenuTreeItems` | `Drupal\menu_tree\MenuTreeItems` | `@menu.link_tree`, `@entity_type.manager` |
| `menu_tree.menu_tree_manipulators` | `Menu\MenuTreeManipulator` | — | none |
| `menu_tree.node_form_submit_handler` | `NodeFormSubmitHandler` | `Drupal\menu_tree\NodeFormSubmitHandler` | `@menu.link_tree`, `@plugin.manager.menu.link` |
| — | `Hook\Hooks` | (autowired) | see [hooks/form-integration.md](../hooks/form-integration.md) |

## `menu_tree.items` — MenuTreeItems

Builds a plain nested array of a menu's links, ready to hand to the SDC component.

```php
/** @var \Drupal\menu_tree\MenuTreeItems $items */
$items = \Drupal::service('menu_tree.items');
$data = $items->getLinks('main', 'main:my.excluded.link');
// => ['label' => 'Main navigation', 'id' => 'main', 'menu_tree' => [ ['text','weight','url','id','submenu'=>[...]], ... ]]
```

`getLinks(string $menu_id = 'main', ?string $exclude = NULL): array`

- Loads the tree with `MenuTreeParameters::onlyEnabledLinks()`.
- Runs core manipulators `menu.default_tree_manipulators:checkAccess` then
  `:generateIndexAndSort`; if `$exclude` is set it also runs
  `menu_tree.menu_tree_manipulators:filterExcluded`.
- `transform()` then flattens each `MenuLinkTreeElement` to `text`/`weight`/`url`/`id`
  (`id` = `<menu_name>:<plugin_id>`), recursing into `submenu`.
- **Access-aware:** links whose `$element->access` is not `AccessResultInterface::isAllowed()`
  are skipped (mirrors core `MenuLinkTree::build()`); disabled links are skipped. Returns `[]` if
  the menu entity does not exist.

## `menu_tree.menu_tree_manipulators` — MenuTreeManipulator

A tree-manipulator callable (used by `MenuTreeItems`, but reusable):

`filterExcluded(array $tree, string $exclude): array` — removes the one
`MenuLinkTreeElement` whose `<menu_name>:<plugin_id>` equals `$exclude`, recursing into subtrees.
Used to drop the node's own link so it can't be chosen as its own parent.

## `menu_tree.node_form_submit_handler` — NodeFormSubmitHandler

`handleFormSubmit($form, FormStateInterface $form_state): void` — appended as a node-form submit
handler by `Hooks::nodeFormAlter()`. Reads the chosen parent plus the hidden `prev_sibling` /
`next_sibling` markers the JS writes, loads the target branch via `@menu.link_tree`, inserts the
node's menu link at the requested position, then rewrites the weights of every link in that branch
(starting at `-50`) via `MenuLinkManagerInterface::updateDefinition()`. No-ops when the menu link
is not enabled for the node or the branch is empty.
