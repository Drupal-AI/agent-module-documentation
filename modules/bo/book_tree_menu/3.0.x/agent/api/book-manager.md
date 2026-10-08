<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `book.manager` service override

Book Tree Menu has no block, route, form or config. Its entire behavior is a container swap of core
Book's `book.manager` service plus a template override. This doc covers the manager swap.

## Wiring (service provider, not services.yml)

`src/BookTreeMenuServiceProvider.php` — `Drupal\book_tree_menu\BookTreeMenuServiceProvider` extends
`ServiceProviderBase`. Its `alter(ContainerBuilder $container)` does exactly:

```php
$definition = $container->getDefinition('book.manager');
$definition->setClass('Drupal\book_tree_menu\oscBookManager');
```

Because the class is named `<Module>ServiceProvider` in the module's top namespace, Drupal picks it up
automatically (no registration needed). It keeps every constructor argument of core `book.manager`;
only the concrete class changes. There is a generated `src/ProxyClass/oscBookManager.php` (a lazy-load
proxy) in the package, but the alter points at the real class, so the proxy is unused.

## What the override changes

`src/oscBookManager.php` — `oscBookManager extends Drupal\book\BookManager` and overrides one method:

```php
public function bookTreeAllData(int $bid, ?array $link = NULL, ?int $max_depth = NULL, ?int $min_depth = NULL): array
```

Signature note: this adds a `$min_depth` parameter beyond core Book 2.x's
`bookTreeAllData($bid, $link, $max_depth)`.

Compared with core Book's implementation, the override:

- Builds `$tree_parameters` with only `min_depth` (defaulting to `1`) — it **omits `max_depth`** and,
  crucially, **never sets `expanded`**.
- Still sets `active_trail` (current page + its ancestors) when a `$link['nid']` is present, so the
  active branch is marked (`in_active_trail`), but that no longer limits which nodes load.

In core, `bookTreeAllData()` sets `expanded => $active_trail`, and
`BookOutlineStorage::getBookMenuTree()` then filters `pid IN (expanded)` — so only the children of the
active trail are loaded and everything else stays collapsed until you navigate to a parent page.
By dropping `expanded`, this override removes that `pid` filter, so `getBookMenuTree()` returns **every
link in the book at every depth**. The result is the complete outline as tree data, which the
replacement template then lets the user expand/collapse client-side without page loads.

It caches per book/link/language/depth in the inherited memory cache via a
`book-links:<bid>:all:<nid>:<langcode>:<max_depth>:<min_depth>` cache id (plus a `drupal_static`
guard), same as core.

## Node access is preserved

The override does not build the query itself — it delegates to the inherited
`BookManager::bookTreeBuild($bid, $tree_parameters)`. That method calls `doBookTreeBuild()` and then
`bookTreeCheckAccess($tree, $node_links)`, which recurses via `doBookTreeCheckAccess()` →
`bookLinkTranslate()`. `bookLinkTranslate()` loads each node and sets
`$link['access'] = $node && $node->access('view')`, and `doBookTreeCheckAccess()` drops any item whose
`access` is false. So even though the full outline is loaded, unpublished nodes and nodes the current
user may not `view` are pruned before rendering. Loading the whole tree changes how much is fetched and
access-checked per request, not what a user is allowed to see.

## Operating notes

- There is nothing to configure. Enabling the module installs the override; disabling/uninstalling it
  restores core's collapse-on-active-trail behavior.
- The tree still surfaces through core Book's own **"Book navigation"** block (block plugin
  `book_navigation`, provided by the `book` module). Place/enable that block to show the tree; this
  module changes how it renders, not where.
- Callers that pass a `$max_depth` to `bookTreeAllData()` will find it ignored (the override does not
  forward it), so the full depth always builds.
