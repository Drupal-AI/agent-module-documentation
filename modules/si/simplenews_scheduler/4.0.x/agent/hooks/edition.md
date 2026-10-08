# Hook: alter a cloned edition node

`simplenews_scheduler.api.php` documents one hook.

## `hook_simplenews_scheduler_edition_node_alter(Node $edition_node, Node $scheduler_node)`

Invoked by `simplenews_scheduler_clone_node()` on each cron run **after** the template node is cloned
into a new edition but **before** the edition is saved/sent. Use it to inject schedule-dependent,
dynamic content into every edition (dates, generated body, subject line, etc.). `$edition_node` is
passed by reference (it is an object).

```php
/**
 * Implements hook_simplenews_scheduler_edition_node_alter().
 */
function mymodule_simplenews_scheduler_edition_node_alter(\Drupal\node\Entity\Node $edition_node, \Drupal\node\Entity\Node $scheduler_node) {
  // Give each edition a date-stamped title.
  $edition_node->setTitle('Your newsletter from ' . \Drupal::time()->getRequestTime());
  // Populate a dynamic field on the edition from the template.
  // $edition_node->set('field_body', mymodule_render_digest());
}
```

No other hooks are provided. There is no plugin type, service API, or Drush command; integrate at the
cron/clone boundary via this hook (plus the bundled `simplenews_scheduler_views.inc` for Views).
