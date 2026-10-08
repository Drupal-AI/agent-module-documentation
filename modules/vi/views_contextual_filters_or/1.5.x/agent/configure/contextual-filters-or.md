<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable "Contextual filters OR" on a view

The module adds exactly one setting: a **Contextual filters OR** checkbox in a view
display's **Query settings**. When on, all contextual filters (arguments) on that display
are combined with OR instead of the default AND. It applies per display, to every
contextual filter at once (no per-argument toggle).

## Where it lives in config

Stored on the display's query plugin options:

```yaml
display:
  default:
    display_options:
      query:
        type: views_query          # or search_api_query for Search API views
        options:
          contextual_filters_or: true
```

Full config key: `display.<display_id>.display_options.query.options.contextual_filters_or`
(boolean, default `false`). A `hook_config_schema_info_alter()` registers this boolean on
both the `views.query.views_query` and `views.query.search_api_query` schemas, so it
validates and exports like any core view setting.

## Enable it in the UI

1. Edit the view at `/admin/structure/views/view/<view_id>`.
2. In the display's **Advanced** column → **Other** → **Query settings** (click the current
   value next to "Query settings").
3. Tick **Contextual filters OR** ("Contextual filters applied to OR logic."), **Apply**,
   then **Save**.

The checkbox only has an effect once the display actually has contextual filters defined
(Advanced → Contextual filters).

## Set it via drush (no UI)

```bash
# Turn the OR option on for the "default" display of view MY_VIEW.
drush php:eval '
  $v = \Drupal\views\Entity\View::load("MY_VIEW");
  $d = $v->get("display");
  $d["default"]["display_options"]["query"]["type"] = "views_query";
  $d["default"]["display_options"]["query"]["options"]["contextual_filters_or"] = TRUE;
  $v->set("display", $d);
  $v->save();
'
drush cr
```

Read it back:

```bash
drush config:get views.view.MY_VIEW display.default.display_options.query.options
```

## Notes / gotchas

- Only the **default filter group (group 0)** is flipped to OR. Exposed/normal Views
  filters you place in *other* groups keep their own AND/OR operator — this setting is
  about the argument-generated conditions, not the Filter criteria UI's own group operators.
- For a Search API view the display's query `type` is `search_api_query`; the same
  `contextual_filters_or` boolean applies (see [../api/query-plugins.md](../api/query-plugins.md)).
- Uninstalling the module runs `drupal_flush_all_caches()`; remove the option from any
  saved views first or it becomes an unschema'd leftover key.
