# Hooks (metatag.api.php)

| Hook | Purpose |
|---|---|
| `hook_metatag_route_entity(RouteMatchInterface $route_match)` | Return an entity for a custom route so its meta tags render on that non-canonical page. |
| `hook_metatags_alter(array &$metatags, array &$context)` | Alter the resolved tag values before rendering (e.g. blank all tags on the front page). `$context['entity']` is the current entity. |
| `hook_metatags_attachments_alter(array &$metatag_attachments)` | Last-chance alter of the `#attached['html_head']` array right before page attachment. |
| `hook_metatag_migrate_metatagd7_tags_map_alter(array $tags_map)` | Adjust the D7 Metatag → D8 tag-id map during migration. |
| `hook_metatag_migrate_nodewordsd6_tags_map_alter(array $tags_map)` | Adjust the D6 Nodewords → D8 tag-id map during migration. |

Example — associate a custom route with an entity:
```php
function my_module_metatag_route_entity(RouteMatchInterface $route_match) {
  if ($route_match->getRouteName() === 'my_module.report') {
    return $route_match->getParameter('node');
  }
}
```

Full signatures and docblocks: `metatag.api.php`.
