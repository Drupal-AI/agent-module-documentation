# API: ExpandBookManager (book.manager override)

The module replaces core's `book.manager` service **class** so the block can request a
min-depth / always-expanded book tree. Any integrator that resolves `book.manager` receives this
subclass (or its lazy proxy) instead of core's `BookManager`.

## How the swap happens

`Drupal\custom_book_block\CustomBookBlockServiceProvider::alter(ContainerBuilder $container)`
does:

```php
$definition = $container->getDefinition('book.manager');
$definition->setClass(ExpandBookManager::class);
```

Because `book.manager` is a lazy service, a generated proxy
`Drupal\custom_book_block\ProxyClass\ExpandBookManager` (implements `book\BookManagerInterface`)
is what most callers actually hold; it lazy-loads the real `ExpandBookManager`. The block's
`build()` accepts either the real class or the proxy and bails out (`return []`) if neither is
active — so a second module that reclasses `book.manager` to something else disables this block.

## Class: `Drupal\custom_book_block\ExpandBookManager` (extends `Drupal\book\BookManager`)

Overrides two methods:

### `bookTreeAllData($bid, $link = NULL, $max_depth = NULL, $start_level = NULL, int $always_expand = 0): array`

Adds two parameters beyond core's `bookTreeAllData($bid, $link, $max_depth)`:

- `$start_level` → used as `min_depth` in the tree parameters (defaults to 1 when null). When
  `$start_level > 1`, it loads the current book link and, if `p{start_level}` is set, adds
  `conditions['p{start_level}']` so only the active branch from that depth is returned.
- `$always_expand` → when truthy, sets `expanded => []` (render the entire tree expanded); when
  falsy, sets `expanded` to the active trail ids (core-equivalent "expand in context").
  `active_trail` is always populated from `getActiveTrailIds()` plus the current nid.

Results are statically cached per cid `book-links:{bid}:all:{nid}:{langcode}:{max_depth}`.
The extra parameters are optional and default to core-compatible values, so existing core callers
of `bookTreeAllData()` keep working.

### `buildItems(array $tree): array` (protected)

Rebuilds render items from a tree: skips links without `access`, sets `is_expanded`/`is_collapsed`
(based on `has_children` and whether `below` is populated), `in_active_trail`, and `is_active`
(link nid equals the current route node id), builds each `url` via
`Url::fromUri('entity:node/{nid}', ['langcode' => …])`, and recurses into `below`. Items are keyed
by the link's `nid`.

## Using it

```php
/** @var \Drupal\book\BookManagerInterface $bm */
$bm = \Drupal::service('book.manager');
// With this module enabled, $bm is ExpandBookManager (via its proxy):
$tree = $bm->bookTreeAllData($bid, $link, $max_depth = 3, $start_level = 2, $always_expand = 1);
$render = $bm->bookTreeOutput($tree);
```

Note: overriding `book.manager` is site-global. Enabling another module that also reclasses
`book.manager` (or that itself is a `BookManager` subclass) will conflict — only one class can win,
and if it is not `ExpandBookManager` this module's block renders nothing.
