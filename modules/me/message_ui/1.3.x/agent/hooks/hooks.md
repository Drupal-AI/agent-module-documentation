# Hooks (message_ui.api.php)

Four hooks let other modules influence message rendering, access and bulk deletion.

```php
// Alter the built render array of a message view.
function hook_message_ui_view_alter(array &$build, \Drupal\message\Entity\Message $message) {}

// Allow/deny an operation ($op: view|update|delete) on an existing message.
// Return an AccessResult (e.g. AccessResult::allowed()/forbidden()).
function hook_message_message_ui_access_control(\Drupal\message\Entity\Message $message, $op, \Drupal\Core\Session\AccountInterface $account) {
  return \Drupal\Core\Access\AccessResult::allowed();
}

// Allow/deny CREATE access for a given template id.
function hook_message_message_ui_create_access_control($template, \Drupal\Core\Session\AccountInterface $account) {
  return \Drupal\Core\Access\AccessResult::allowed();
}

// Alter the entity query used by the multiple-delete form.
function hook_message_ui_multiple_message_delete_query_alter(\Drupal\Core\Entity\Query\QueryInterface $query) {
  $query->condition('field_node_ref.target_id', 22);
}
```

- The two access hooks are invoked by `MessageAccessControlHandler` and combine with the
  static/per-template permissions (see [../permissions/permissions.md](../permissions/permissions.md)).
- There is also a plugin-info alter hook for the contextual-links plugin type:
  `hook_message_ui_message_ui_views_contextual_links_info_alter()` (see
  [../plugins/contextual-links.md](../plugins/contextual-links.md)).
