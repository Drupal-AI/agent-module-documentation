# Hooks

Documented in `breadcrumb_manager.api.php` plus the plugin-manager alter.

## `hook_breadcrumb_manager_path_alter(&$path)`
Invoked in `BreadcrumbManagerBuilder::build()` as `moduleHandler->alter('breadcrumb_manager_path', $path)`
right after reading the current path info and **before** it is split into segments. Rewrite
`$path` (a string) to change which path the breadcrumb is built from.

## `hook_breadcrumb_manager_fake_segments_alter($current_path, &$title, Url &$url)`
Invoked only when `show_fake_segments` is enabled, for a path segment with **no matching route**.
The default `$title` comes from the `raw_path_component` resolver and `$url` is `<none>`. Rewrite
`$title` and/or `$url` to give a route-less segment a meaningful label/link. Example from
`breadcrumb_manager.api.php`:
```php
function hook_breadcrumb_manager_fake_segments_alter($current_path, &$title, Url &$url) {
  $mapping = [
    '/fake-segment-news' => ['title' => 'My amazing news', 'path' => '/news'],
  ];
  if (isset($mapping[$current_path])) {
    $title = $mapping[$current_path]['title'];
    $url = Url::fromUserInput($mapping[$current_path]['path']);
  }
}
```

## `hook_breadcrumb_manager_breadcrumb_title_resolver_info_alter(&$definitions)`
Standard plugin-definitions alter for the `breadcrumb_title_resolver` plugin type (registered via
`alterInfo('breadcrumb_manager_breadcrumb_title_resolver_info')`). Add/modify/remove resolver
definitions. See [../plugins/title-resolver.md](../plugins/title-resolver.md).
