# Hooks — `checklistapi.api.php`

## `hook_checklistapi_checklist_info()` — define checklists

Return an array of definitions keyed by an arbitrary unique checklist ID. Checklist API
registers a menu item, routes, and permissions for each one.

```php
function mymodule_checklistapi_checklist_info() {
  $definitions = [];
  $definitions['my_checklist'] = [
    '#title' => t('My checklist'),
    '#path' => 'my-checklist',                 // becomes the route path
    '#callback' => 'mymodule_checklist_items', // returns the groups/items
    '#callback_arguments' => ['some value'],   // optional, passed to callback
    '#description' => t('Menu item description.'),
    '#help' => t('<p>Shown in the System help block.</p>'),
    '#storage' => 'config',                    // 'config' (default) or 'state'
    '#menu_name' => 'main',                    // optional target menu
    '#weight' => 0,                            // optional sort order
  ];
  return $definitions;
}
```

Definition keys (all prefixed `#`): `#title` and `#path` are required for a route to be
generated; `#callback`, `#callback_arguments`, `#description`, `#help`, `#menu_name`,
`#storage`, `#weight` are optional. Items may also be inlined directly (deprecated) instead
of via `#callback`.

## `callback_checklistapi_checklist_items($argument)` — the items

Returns groups of items (groups render as **vertical tabs**). Structure is a nested array:

```php
function mymodule_checklist_items($argument) {
  return [
    'group_one' => [                    // group key (unique in checklist)
      '#title' => t('Group one'),       // vertical-tab label
      '#description' => t('...'),        // optional
      '#weight' => 0,                    // optional
      'item_a' => [                      // item key (unique in checklist)
        '#title' => t('Item A'),
        '#description' => t('Beneath the title.'),   // optional
        '#default_value' => TRUE,        // optional: auto-checked state (e.g. a module IS enabled)
        '#weight' => 0,                  // optional
        'docs_link' => [                 // any number of links
          '#text' => t('Handbook'),
          '#url' => \Drupal\Core\Url::fromUri('https://example.com/'),
          '#weight' => 0,                // optional
        ],
      ],
    ],
  ];
}
```

`#default_value => TRUE` is the mechanism for pre-checking items you can programmatically
verify (a module is installed, a setting has a value, etc.).

## `hook_checklistapi_checklist_info_alter(array &$definitions)`

Invoked by `checklistapi_get_checklist_info()`. Add, alter, move, or remove checklists,
groups, and items by reference. Note: `#path` **cannot** be altered here (routes are already
built) — use route altering instead.

```php
function mymodule_checklistapi_checklist_info_alter(array &$definitions) {
  $definitions['example_checklist']['new_group']['#title'] = t('New group');
  unset($definitions['example_checklist']['example_group']['example_item_2']);
}
```

See the bundled `checklistapiexample.module` for a complete working implementation.
