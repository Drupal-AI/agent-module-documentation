<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "term name (with depth)" contextual filter

This module has **no settings form** (`configure: null`). All configuration is done on a
Views contextual filter. There is nothing to enable beyond turning the module on
(`drush en views_taxonomy_term_name_depth -y`; Pathauto is a required dependency).

## In the Views UI

On a view whose base is **Content** (`node_field_data`):

1. **Advanced → Contextual filters → Add**.
2. Choose **"Has taxonomy term NAME (with depth)"** (category: Content).
3. Configure the options below and save the view.

The visitor then supplies a **term name** in the URL argument position (e.g.
`/my-view/news`), not a numeric term id.

## Options (stored on the argument)

| Option | Type | Default | Meaning |
|---|---|---|---|
| `depth` | int (string in config) | `0` | `0` = exact term only. Positive = also match descendant terms N levels down (e.g. depth 1: filtering "Fruit" also returns nodes tagged "Apple"). Negative = walk upward to ancestors. |
| `vocabularies` | list of vocab machine names | `[]` (all) | Restrict which vocabularies are searched for the name. Useful when the same name exists in several vocabularies. |
| `break_phrase` | bool | `FALSE` | "Allow multiple values": accept `a+b+c` in the argument; multiple values are treated as **OR** (`IN`). |
| `use_taxonomy_term_path` | bool | `FALSE` | Present in schema/defaults; reserved. |

Plus the standard core argument options (what to do when the argument is missing, validation, etc.).

## Config shape (views.view.\* display arguments)

The argument key on the node base table is `term_node_taxonomy_name_depth` and the handler
`plugin_id` is `taxonomy_index_name_depth`:

```yaml
display:
  default:
    display_options:
      arguments:
        term_node_taxonomy_name_depth:
          id: term_node_taxonomy_name_depth
          table: node_field_data
          field: term_node_taxonomy_name_depth
          plugin_id: taxonomy_index_name_depth
          depth: '1'          # the depth setting
          break_phrase: false
          vocabularies: {  }   # or e.g. { tags: tags }
```

## Inspect / set via drush

```bash
# Show the argument config of a view display
drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("MY_VIEW");
  print_r($v->get("display")["default"]["display_options"]["arguments"]);'
```

```php
// Add the argument to an existing view display at depth 2.
$v = \Drupal::entityTypeManager()->getStorage('view')->load('MY_VIEW');
$display = &$v->getDisplay('default');
$display['display_options']['arguments']['term_node_taxonomy_name_depth'] = [
  'id' => 'term_node_taxonomy_name_depth',
  'table' => 'node_field_data',
  'field' => 'term_node_taxonomy_name_depth',
  'plugin_id' => 'taxonomy_index_name_depth',
  'depth' => '2',
  'break_phrase' => FALSE,
  'vocabularies' => [],
];
$v->save();
```

Note: because it lives on the node base table (subquery against `taxonomy_index` and
`taxonomy_term__parent`), this argument offers **fewer** options than the core term-id
filters and drops the "summary" default-action variants.
