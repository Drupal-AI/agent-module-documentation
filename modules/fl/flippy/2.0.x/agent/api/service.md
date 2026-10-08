# Flippy service & block (programmatic use)

Service id **`flippy.pager`** → `Drupal\flippy\FlippyPager`. Use it to build prev/next data in
custom code, or place the block plugin.

## Public methods

```php
$pager = \Drupal::service('flippy.pager');

// TRUE when the pager should show for this node (it is the page node and
// flippy_<type> is enabled). node_is_page() + config check.
$pager->flippy_use_pager(\Drupal\node\Entity\Node $node): bool

// Returns an associative array of neighbour node ids/titles, keyed by
// 'first','prev','next','last' (and 'random' when enabled). Statically cached
// per node id. Respects flippy_custom_sorting_<type>/flippy_sort_<type>/
// flippy_order_<type>; default order is created ASC. Only published nodes of the
// same type and current language, excluding the current node.
$pager->flippy_build_list(\Drupal\node\Entity\Node $node): array
//   => ['prev' => ['nid' => 12, 'title' => '…'], 'next' => [...], ...]

// Builds a themed link render array to a node id with a (token-replaced,
// optionally truncated) label.
$pager->flippy_generate_link(int $nodeId, string $label): array
```

## Example

```php
$node = \Drupal::routeMatch()->getParameter('node');
$pager = \Drupal::service('flippy.pager');
if ($pager->flippy_use_pager($node)) {
  $list = $pager->flippy_build_list($node);
  if (!empty($list['next']['nid'])) {
    $next_link = $pager->flippy_generate_link($list['next']['nid'], 'Next: [node:title]');
  }
}
```

## The block

`flippy_block` (`Drupal\flippy\Plugin\Block\FlippyBlock`) renders the `flippy` theme for the node
on the current route when `flippy_use_pager()` is true. Cache tags include the node's tags plus
`node_list`; cache context `route`. It also emits the head `rel` links when
`flippy_head_<type>` is on. Place it via *Structure → Block layout* or config.

## How the node view attaches it

`flippy_node_view()` adds a `flippy_pager` render element (`#theme => 'flippy'`) when the node's
display shows the `flippy_pager` component, attaching the `flippy/drupal.flippy` library (and
`hammerjs` + `flippy/flippy.swipe` when swipe is enabled). It does **not** expose a service to
read the log or a settings API beyond `flippy.settings` config.
