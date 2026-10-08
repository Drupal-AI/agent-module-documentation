# Managing empty-page callbacks

## Admin routes (`empty_page.routing.yml`)

| Route | Path | Purpose |
|---|---|---|
| `empty_page.administration` | `/admin/structure/empty-page` | List callbacks (the `configure` route) |
| `empty_page.add_callback` | `/admin/structure/empty-page/add` | Add callback (`CallbackForm`) |
| `empty_page.edit_callback` | `/admin/structure/empty-page/{cid}/edit` | Edit callback |
| `empty_page.delete_callback` | `/admin/structure/empty-page/{cid}/delete` | Delete callback |

All admin routes require `administer empty pages`. Dynamic per-callback routes
`empty_page.page_<cid>` (path = the callback's internal path) are registered by
`route_callbacks: \Drupal\empty_page\Routing\EmptyPages::routes` and require `view empty pages`;
their controller `EmptyPage::emptyCallback()` returns `[]` (empty) with the configured title.

## Config object: empty_page.settings

```yaml
new_id: 3                      # next id counter (starts at 1)
callback_1:
  cid: 1
  path: 'my-landing'           # internal path (no leading slash), e.g. 'node' to blank the front list
  page_title: 'My Landing'     # optional
  created: 1690000000
  updated: 1690000000
```

`EmptyPageController::emptyPageGetCallbacks()` collects every config key beginning with
`callback_`. The add/edit form (`CallbackForm`) writes `callback_<id>`, bumps `new_id` on
create, then calls `router.builder->rebuild()` so the dynamic route appears immediately.

## Create a callback with Drush/PHP (then rebuild routes)

```php
$config = \Drupal::configFactory()->getEditable('empty_page.settings');
$id = $config->get('new_id') ?: 1;
$now = \Drupal::time()->getRequestTime();
$config->set("callback_$id", [
  'cid' => $id, 'path' => 'my-landing', 'page_title' => 'My Landing',
  'created' => $now, 'updated' => $now,
])->set('new_id', $id + 1)->save();
\Drupal::service('router.builder')->rebuild();   // required for empty_page.page_<id> to exist
```

Verify: `drush cget empty_page.settings` shows the callback; the route
`empty_page.page_<id>` resolves at the configured path.
