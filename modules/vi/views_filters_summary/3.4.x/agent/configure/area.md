<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure the summary area

There is **no admin settings page**. You configure it per view by adding the area handler and
setting its options.

## Adding it (UI)

1. Edit a view that has at least one **exposed** filter.
2. In **Header**, **Footer**, or **No results behavior**, click **Add** and choose
   **Views exposed filters summary** ("Global" group).
3. Configure the options (below) and Save.

## Where it lives in config

Inside the view config entity, per display:

```yaml
display_options:
  footer:                 # or header / empty
    views_filters_summary:
      id: views_filters_summary
      table: views
      field: views_filters_summary
      plugin_id: views_filters_summary
      # --- options (schema: views.area.views_filters_summary) ---
      filters: []                       # sequence of exposed filter ids to include; empty = all
      show_labels: false                # prefix each value with its filter label
      group_values: false               # group a multi-value filter under one label
      show_remove_link: true            # per-value remove 'X' link
      show_reset_link: false            # a single reset-all link
      filters_reset_link_title: 'Reset' # shown when show_reset_link is on
      filters_summary_prefix: 'for '     # text before the filter list
      filters_summary_separator: ', '    # between summary items
      filters_result_label:
        singular: 'result'
        plural: 'results'
      content: 'Displaying @total @result_label @exposed_filter_summary'
```

## The `content` string tokens

`content` is rendered with `str_replace` of these tokens (defined in `defineReplacements()`):

- `@total` — total result rows.
- `@result_label` — the singular/plural `filters_result_label`, chosen by count.
- `@exposed_filter_summary` — the rendered summary of active filters (prefix + items + reset link).
- Also available: `@start`, `@end`, `@per_page`, `@current_page`, `@page_count`, `@label`,
  `@current_record_count` (inherited from the Result area). Submodules can add more (e.g. the
  search_api submodule adds `@search_api_fulltext`).

The area renders nothing if the view uses the DefaultSummary style, or if `@total` is 0 and the
Result area's "Count the number 0" (`empty`) option is off.

## drush / programmatic

Options are part of the view config entity — edit the view and set the handler options, e.g.:

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = $view->get('display');
$display['default']['display_options']['footer']['views_filters_summary'] = [
  'id' => 'views_filters_summary', 'table' => 'views', 'field' => 'views_filters_summary',
  'plugin_id' => 'views_filters_summary', 'show_reset_link' => TRUE,
];
$view->set('display', $display)->save();
```

Value resolution: taxonomy (`taxonomy_index_tid`/`_depth`), `bundle`, `user_name`, and list/options
filters are resolved to labels automatically; `user_permissions`/`user_roles` are aliased to
`list_field`. Other filter plugins are handled generically or by a submodule's `plugin_alias`.
