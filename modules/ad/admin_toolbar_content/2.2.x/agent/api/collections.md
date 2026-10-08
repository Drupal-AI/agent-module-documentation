# Grouping items: `hook_admin_toolbar_content_collections`

Collections group the per-item links a plugin generates (content types, media types, vocabularies…)
into named, optionally nested sub-menus. Implement `hook_admin_toolbar_content_collections()`
(documented in `admin_toolbar_content.api.php`) to return a hierarchy **keyed by plugin id**.
`AdminToolbarContentPluginBase::getCollections()` collects every module's implementation via
`ModuleHandler::invokeAll()` and folds the result into the generated links.

```php
/**
 * Implements hook_admin_toolbar_content_collections().
 */
function mymodule_admin_toolbar_content_collections(): array {
  return [
    'content' => [                      // plugin id (here: content types)
      'editorial' => [
        'label' => 'Editorial',
        'items' => ['article', 'page'], // machine names of items in this collection
        'collections' => [              // optional nested collections
          'news' => [
            'label' => 'News',
            'items' => ['press_release'],
          ],
        ],
      ],
    ],
  ];
}
```

This yields link ids such as `content.editorial`, `content.editorial.article`,
`content.editorial.news.press_release`, and matching `.add` links. Items not named in any
collection fall back to the plugin's root menu. See `api/collections.md` example block in
`admin_toolbar_content.api.php` for the full id-generation table.

- **Weight/placement:** `common.group_collections` (`top`/`bottom`) pushes collection items to one
  end; `common.hide_empty_collections` drops a collection that ends up with no children.
- **v1 → v2:** the old `hook_content_type_collections`, `hook_vocabularies_collections` and
  `hook_menus_collections` are all replaced by this single hook (routed to the `content`,
  `categories` and `menus` plugin ids respectively).

## Altering the plugin list

The manager exposes the standard plugin-info alter hook
`hook_admin_toolbar_content_plugins_info(array &$definitions)` — use it to change or unset a plugin
definition (e.g. tweak a `name`/`entity_type`) before the toolbar is built. To contribute new
toolbar areas, add an `@AdminToolbarContentPlugin` class instead (see
`plugins/admin_toolbar_content.md`).
