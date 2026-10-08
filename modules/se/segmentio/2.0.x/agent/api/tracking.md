<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Segmentio developer API

See `segmentio.api.php` for the full example.

## Register a callback
Implement `hook_segmentio_info()` returning `['{module}:{hook}' => t('Label')]`. Enable the entry in the `segmentio_track` config (admin form). When enabled, `{module}_{hook}(&$variables)` is invoked during `hook_page_attachments()`.

```php
function hook_segmentio_info() {
  return ['example:segmentio_mytrackinginfo' => t("MyModule's MyTrackingInfo")];
}
function example_segmentio_mytrackinginfo(&$variables = []) {
  $variables['identify']['userId'] = 1;
  $variables['identify']['traits']['email'] = 'example@example.com';
  $variables['page']['name'] = 'Cookie policy';
  $variables['track'][] = ['event' => 'Downloaded a PDF', 'properties' => ['pdf_name' => 'x.pdf']];
}
```

Payload keys map to analytics.js calls: `identify`, `page`, `track` (array of events), `group`, `alias`.

## Built-in callbacks
- `segmentio_segmentio_user` — sets `identify.userId` and traits `name`, `email` for the current user.
- `segmentio_segmentio_node` — on node routes, sets `page.category` (type), `page.name` (title), and `page.properties` (nid, uid).

## Queue a track event from code
```php
segmentio_set_track_event($event, $properties = [], $options = [], $callback = NULL);
```
Events are stored in `$_SESSION['segmentio']` and flushed into the next page's `variables['track']` by `segmentio_get_track_events()`. Queuing triggers the `page_cache_kill_switch` so the response is not page-cached.
