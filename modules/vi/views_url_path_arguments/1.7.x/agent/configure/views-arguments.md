<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Configure the `views_url_path` argument default / validator

The module registers **one plugin id, `views_url_path`, for two Views plugin types**:

| Plugin type | Title in UI | Class |
|---|---|---|
| `argument_default` | "Entity ID converted from URL path alias" | `Plugin/views/argument_default/UrlPath` |
| `argument_validator` | "Entity ID from URL path alias" | `Plugin/views/argument_validator/UrlPath` |

Both attach to a **contextual filter (argument)** on a view display — typically *Content: ID*
(`node_nid`). There is **no admin settings page** (`configure: null`); you configure it per view.

## Options (identical on both plugins)

| Option | Type | Default (default plugin / validator) | Meaning |
|---|---|---|---|
| `provide_static_segments` | boolean | `FALSE` / `TRUE` | Prepend a fixed URL prefix before looking up the alias. |
| `segments` | string | `''` | The prefix, **without leading/trailing slashes** (validated). E.g. `blog`. |

## Via the Views UI

1. Edit the view, open the contextual filter (e.g. **Content: ID**).
2. **Default plugin:** under *"When the filter value is NOT in the URL"* choose **Provide
   default value → Type: "Entity ID converted from URL path alias"**. Tick *"Provide a static
   URL segment(s) to prefix aliases?"* and fill **Segments** if the alias is under a fixed
   prefix.
3. **Validator plugin:** under *"When the filter value IS in the URL or a default is provided"*
   choose **Specify validation criteria → Validator: "Entity ID from URL path alias"**, and
   set the same segment options.
4. Save the view.

## Where it is stored (view config entity)

Config entity `views.view.<id>` → `display.<display>.display_options.arguments.<arg_id>`:

```yaml
arguments:
  nid:
    id: nid
    table: node_field_data
    field: nid
    plugin_id: node_nid
    default_action: default
    default_argument_type: views_url_path        # the default plugin
    default_argument_options:
      segments: blog
      provide_static_segments: true
    validate:
      type: views_url_path                        # the validator plugin
      fail: 'not found'
      options:
        views_url_path:
          segments: blog
          provide_static_segments: true
```

## Scriptable (drush php:eval)

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = $view->get('display');
$display['default']['display_options']['arguments']['nid']['default_argument_type'] = 'views_url_path';
$display['default']['display_options']['arguments']['nid']['default_argument_options'] = [
  'segments' => 'blog', 'provide_static_segments' => TRUE,
];
$view->set('display', $display)->save();
```

Read back: `drush cget views.view.my_view display.default.display_options.arguments.nid`.

## How resolution works (runtime)

`UrlPath::getArgument()` (default) / `validateArgument()` (validator):

1. Takes the **last raw route parameter** of the current route (empty → returns `''`, so
   Drush/CLI calls are skipped).
2. If it is already numeric (`ctype_digit`), it is returned as-is — numeric IDs pass through.
3. Otherwise it builds `'/' . (segments . '/' if provide_static_segments) . <last-segment>` and
   calls `path_alias.repository`'s `lookupByAlias($alias, $langcode)` for the **current URL
   language**.
4. Returns the trailing segment of the resolved system path (the entity ID). The validator
   additionally sets `$this->argument->argument` and returns `TRUE`/`FALSE` (fail = 404).

Caching (default plugin): `getCacheMaxAge()` = `Cache::PERMANENT`, `getCacheContexts()` =
`['url']`. Both plugins add `views_url_path_arguments` to the view's module dependencies.

## Config schema

`config/schema/views_url_path_arguments.schema.yml` defines
`views.argument_default.views_url_path` and `views.argument_validator.views_url_path`, each a
mapping of `segments` (string) + `provide_static_segments` (boolean).
