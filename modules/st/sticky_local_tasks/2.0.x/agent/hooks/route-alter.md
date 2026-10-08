# hook_sticky_local_tasks_route_alter

Documented in `sticky_local_tasks.api.php`. Lets other modules add or change the mapping from a task's
route (matched as a substring of the full route name) to an icon CSS-class suffix, so custom or
contrib local tasks get an icon in the sticky widget.

```php
/**
 * Implements hook_sticky_local_tasks_route_alter().
 */
function my_module_sticky_local_tasks_route_alter(array &$route_to_link_name_map) {
  // Key = a substring matched against the task route name.
  // Value = icon name; becomes the CSS class nav-item--<value>.
  $route_to_link_name_map['my_module.custom_tab'] = 'custom-tab';
}
```

## How the mapping is used

`StickyLocalTasksBuilder::getCssClass()` builds a default `$route_to_link_name_map`, invokes
`$moduleHandler->alter('sticky_local_tasks_route', $route_to_link_name_map)`, then for each task does a
`strpos($route_name, $route_part)` substring match and returns `nav-item--<value>` for the first hit.
That class is added to the task `<li>`, and the module's CSS paints the matching icon.

Built-in keys include `canonical => view`, `edit_form => edit`, `delete_form => delete`,
`version_history => revisions`, `content_translation_overview => translate`, `layout_builder => layout`,
plus many webform/devel/entity-clone/book entries (see the source for the full list). Ship an icon for
a new class by overriding the icon background image, e.g.:

```css
.sticky-local-tasks__wrapper .nav-item--custom-tab .nav-link__icon {
  background-image: url('icon--custom-tab.svg');
}
```

## Other hooks the module implements (for reference)

`sticky_local_tasks.module` implements `hook_page_bottom()` (adds the widget in `usage: all` mode),
`hook_theme()` (registers the two theme hooks below), and `hook_help()`. `sticky_local_tasks.theme.inc`
implements `hook_preprocess_menu_local_tasks__sticky_local_tasks()` and
`hook_preprocess_menu_local_task__sticky_local_tasks()`. See [theme/library.md](../theme/library.md).
