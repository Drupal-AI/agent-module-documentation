<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu tree manipulator service

The domain filter is a reusable menu-link-tree manipulator. Integrators (e.g. a custom menu
block, or the bundled Menu Block submodule) apply it by adding its callable to a
`$menuTree->transform()` manipulator list.

## Service

- Id: `domain_menu_access.default_tree_manipulators`
- Class: `Drupal\domain_menu_access\Menu\DomainMenuLinkTreeManipulators`
- Arguments: `@entity_type.manager`, `@domain.negotiator`, `@language_manager`
- It is a plain service (no `menu.default_tree_manipulators` tag); it runs only where a caller
  explicitly lists it, so it must be added **after** `menu.default_tree_manipulators:checkAccess`.

## `checkDomain(array $tree): array`

Callable form: `'domain_menu_access.default_tree_manipulators:checkDomain'`.

For each element it:

- Skips elements another manipulator already forbade
  (`isset($element->access) && !$element->access->isAllowed()` → left alone).
- Otherwise calls `menuLinkCheckAccess()`. If **forbidden**: sets `$element->access` to the
  forbidden result, wraps `$element->link` in `Core\Menu\InaccessibleMenuLink`, and empties
  `$element->subtree` (children of a hidden link disappear too). If allowed and it has a subtree,
  recurses into the subtree.
- Adds the `url.site` cache context to every element's access result, so a cached tree is correct
  per domain.

### `menuLinkCheckAccess()` rule

- Loads the `menu_link_content` entity behind the link (by
  `pluginDefinition['metadata']['entity_id']`, falling back to the link's UUID / derivative id),
  translating it to the current language when a translation exists.
- If the link is available on all affiliates (`field_domain_all_affiliates` set and `!== '0'`) →
  `AccessResult::allowed()`.
- Else collects the target ids from `field_domain_access`; if the active domain
  (`domain.negotiator->getActiveDomain()`) is **not** among them → `AccessResult::forbidden()`,
  otherwise allowed.
- Result is returned `->cachePerPermissions()`.

## Applying it in a custom block

```php
$tree = $this->menuTree->load($menu_name, $parameters);
$tree = $this->menuTree->transform($tree, [
  ['callable' => 'menu.default_tree_manipulators:checkAccess'],
  ['callable' => 'domain_menu_access.default_tree_manipulators:checkDomain'],
  ['callable' => 'menu.default_tree_manipulators:generateIndexAndSort'],
]);
return $this->menuTree->build($tree);
```

Remember to also add the `url.site` cache context to the rendering block so per-domain output is
cached correctly.
