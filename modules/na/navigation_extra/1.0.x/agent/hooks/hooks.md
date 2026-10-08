<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation Extra hooks

## `hook_navigation_extra_collections()`

Declared in `navigation_extra.api.php`. Return a hierarchical collection definition keyed by plugin id
so a plugin's navigation links are grouped into (optionally nested) collections.

```php
function hook_navigation_extra_collections(): array {
  return [
    'plugin_a' => [
      'collection_a' => [
        'label' => 'COLLECTION A',
        'items' => ['item a', 'item b'],
        'collections' => [
          'collection_a_1' => [
            'label' => 'COLLECTION A.1',
            'items' => ['item c'],
          ],
        ],
      ],
    ],
  ];
}
```

Resulting link keys:
- Root: `$links['plugin_a']`
- Collections: `$links['plugin_a.collection_a']`, `$links['plugin_a.collection_a.collection_a_1']`
- Items: `$links['plugin_a.collection_a.item_a']`, `$links['plugin_a.collection_a.collection_a_1.item_c']`
- Add links: `$links['plugin_a.collection_a.item_a.add']`, etc.

Each collection needs a `label`; `items` is a flat list of item ids; nested groups go under
`collections`. See `NavigationExtraPluginBase` for how collections are consumed when altering the
discovered menu links.
