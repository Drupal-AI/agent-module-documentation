<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The tab-relabeling hook (bundle_tabs_menu_local_tasks_alter)

File: `bundle_tabs.module`. This is the module's only functional code.

## Install / enable

`composer require drupal/bundle_tabs` then `drush en bundle_tabs -y`. No config form, no
permissions, no dependencies to add. Effect is immediate; no cache action typically needed for the
alter to apply, though a `drush cr` clears any stale rendered tab cache.

## What it does

Implements `hook_menu_local_tasks_alter(&$data, $route_name, RefinableCacheableDependencyInterface &$cacheability)`.
Drupal calls this while assembling the local-task (tab) render data for the current page. The
module inspects the current route's parameters and rewrites specific first-level tab titles.

### Nodes

```
$node = \Drupal::routeMatch()->getParameter('node');
if ($node instanceof \Drupal\node\NodeInterface) {
  $label = $node->type->entity->label();          // content-type label
  $data['tabs'][0]['entity.node.canonical']['#link']['title']   = t('View @label',   ['@label' => $label]);
  $data['tabs'][0]['entity.node.edit_form']['#link']['title']   = t('Edit @label',   ['@label' => $label]);
  $data['tabs'][0]['entity.node.delete_form']['#link']['title'] = t('Delete @label', ['@label' => $label]);
}
```

### Taxonomy terms

```
$term = \Drupal::routeMatch()->getParameter('taxonomy_term');
if ($term instanceof \Drupal\taxonomy\Entity\Term) {
  $vid   = $term->bundle();
  $label = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load($vid)->label();
  $data['tabs'][0]['entity.taxonomy_term.canonical']['#link']['title']   = t('View @label',   ['@label' => $label]);
  $data['tabs'][0]['entity.taxonomy_term.edit_form']['#link']['title']   = t('Edit @label',   ['@label' => $label]);
  $data['tabs'][0]['entity.taxonomy_term.delete_form']['#link']['title'] = t('Delete @label', ['@label' => $label]);
}
```

## Scope and limits

- Touches **only** `$data['tabs'][0]` (the first tab level) and **only** the six tab keys above.
  Second-level tabs, other tab keys, and non-node/non-term entity types are unchanged.
- It does not add, remove, or reorder tabs and does not alter access — it only overwrites the
  `title` string of tabs core already rendered for the user (core's access/visibility on those
  tabs still applies). It creates no routes and no permissions.
- The `@label` value is the content type / vocabulary label, injected via the `t()` placeholder,
  so it is rendered escaped and is translatable — no raw markup is emitted.
- `$cacheability` is received by reference but not modified; the tab titles vary with the route's
  node/term as core already keys them.

## Translation

The three format strings `View @label`, `Edit @label`, `Delete @label` are `t()` strings.
Translate them at `/admin/config/regional/translate` (User interface translation) by searching for
each string, e.g. to render "Modifier @label" in French. The `hook_help()` on
`help.page.bundle_tabs` states the same.
