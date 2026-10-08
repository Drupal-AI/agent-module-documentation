# Hooks — how SEO Checklist defines its checklist

SEO Checklist is a consumer of **Checklist API**. It implements one info hook and adds an
augmented item schema on top of the standard Checklist API definition.

## `hook_checklistapi_checklist_info()`

`seo_checklist_checklistapi_checklist_info()` registers a single checklist:

```php
$definitions['seo_checklist'] = [
  '#title'       => t('SEO checklist'),
  '#description' => t('Keep track of your Drupal Search Engine Optimization tasks.'),
  '#path'        => '/admin/config/search/seo-checklist',
  '#callback'    => 'seo_checklist_checklistapi_checklist_items',
  '#help'        => t('<p>Check off each SEO-related task as you complete it…</p>'),
];
```

The `#callback` (`seo_checklist_checklistapi_checklist_items()`) returns the grouped items:
sections like `basic_seo_part_1` (Clean URLs), `basic_seo_part_2` (Meta tags / Schema.org),
`search_engines`, `optimizing_content`, `page_optimization`, `security_and_performance`,
`mobile_and_social`. Each section is a group of items.

## Augmented item schema (SEO Checklist's own convention)

Beyond Checklist API's normal `#title`/`#description` and free-form link children
(`'#text' + '#url'`), item arrays may include these extra keys, expanded by
`_seo_checklist_preprocess_checklist_items()`:

| Key | Meaning |
|---|---|
| `#module` | Project/machine name of a recommended contrib module. Pre-checks the item if installed (`#default_value`), and adds **Download** (project page), **Install** (`system.modules_list`), and **Configure permissions** links. |
| `#configure` | A **route name** for that module's settings page. Adds a **Configure** link when the route exists and the user has access. |
| `#seo_training_camp` | A `Url` to an external learning resource. Adds an **SEO training camp** link. |

These keys are unset after processing, so the array Checklist API finally receives is a plain
checklist definition with rendered link children.

## Altering the SEO checklist

To add, remove, or change SEO items from a custom module, implement Checklist API's alter hook
(provided by the `checklistapi` dependency), not a SEO-Checklist-specific one:

```php
function mymodule_checklistapi_checklist_info_alter(array &$definitions) {
  if (isset($definitions['seo_checklist'])) {
    // e.g. add a custom item to an existing group.
    $definitions['seo_checklist']['optimizing_content']['my_custom_task'] = [
      '#title' => t('Do my custom SEO task'),
      '#description' => t('…'),
    ];
  }
}
```

Note the augmented `#module` / `#configure` / `#seo_training_camp` keys are only interpreted
for items defined by SEO Checklist's own callback; items you add via the alter hook are passed
straight through to Checklist API.
