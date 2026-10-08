<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading display tags — `views_tag_view_display.tags`

## Service
`views_tag_view_display.tags` → `\Drupal\views_tag_view_display\ViewsTagViewDisplayTagsService`
implements `ViewsTagViewDisplayTagsServiceInterface`.

### `getList(string $view_name, $display_id): array`
- `$view_name` — the view config id (machine name).
- `$display_id` — the display id (e.g. `default`, `page_1`, `block_1`).
- Returns an array of tags (the stored comma-separated string, `explode`d).
- Returns `[]` if the view does not exist, is not a `View`, the executable is
  unavailable, or the display has no extenders.

## Example
```php
$tags = \Drupal::service('views_tag_view_display.tags')
  ->getList('frontpage', 'page_1');
if (in_array('featured', $tags, TRUE)) {
  // ... treat this display as featured.
}
```

## Setting tags
Tags are authored in the Views UI: edit a view, open a display's **Advanced**
settings, find **Display view Tags**, enter comma-separated tags, and save.
The value is stored in the display's `display_options` under the
`views_tag_view_display` key.
