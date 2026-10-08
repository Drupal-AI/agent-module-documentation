# Hooks — `workbench.api.php`

## `hook_workbench_content_alter(array &$output, ?array $context = NULL)`

Alter the Views-driven regions of the Workbench pages (overview, My edits, All recent content)
instead of using `hook_page_alter()`. `$output` is keyed by region; each entry is normally an
array with `#view_id` and `#view_display` strings. `$context` is `overview`, `edits`, or `all`.

Point a region at a different View display, or replace it with any render array:

```php
function mymodule_workbench_content_alter(array &$output, ?array $context = NULL) {
  // Add/replace a Workbench tab region with a custom View display.
  $output['workbench_recent_content']['#view_id'] = 'custom_view';
  $output['workbench_recent_content']['#view_display'] = 'block_2';

  // Or drop in an arbitrary render array instead of a View:
  $output['workbench_current_user'] = [
    '#type' => 'markup',
    '#markup' => t('Welcome to Fantasy Island!'),
  ];
}
```

Workbench renders each region with `views_embed_view()` (see `WorkbenchContentController::renderBlocks()`).

## `hook_workbench_create_alter(array &$output)`

Alter the **Create content** tab (`/admin/workbench/create`), which emulates core's `node/add`
page. `$output` is the node-add render array.

```php
function mymodule_workbench_create_alter(array &$output) {
  $output['#content']['article']->set('description', 'hello world');
}
```

## `hook_workbench_block()`

Return an array of message strings to display in the "Workbench information" block
(`WorkbenchBlock`, plugin id `workbench_block`). Preferred format: `Title: <em>Message</em>`.

```php
function mymodule_workbench_block() {
  if ($node = \Drupal::routeMatch()->getParameter('node')) {
    return [t('My Module: <em>You may edit this content.</em>')];
  }
}
```
