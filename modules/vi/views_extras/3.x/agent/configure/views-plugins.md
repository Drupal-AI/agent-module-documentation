# Using the plugins in a view

No admin page. You wire these up inside a View (Views UI or the `views.view.*` config entity).

## Contextual filter default arguments (`session` / `cookie` / `tempstore`)

In the Views UI: add a **Contextual filter** → under *When the filter value is NOT available* choose
**Provide default value** → *Type* = **Session variable from session**, **Cookie variable from
cookie**, or **TempStore variable**. Fill the key + fallback.

In config, this lands on the argument:

```yaml
display:
  default:
    display_options:
      arguments:
        <arg_id>:
          # ... standard argument keys (id, table, field, plugin_id) ...
          default_action: default
          default_argument_type: cookie        # or session | tempstore
          default_argument_options:
            cookie_key: my_pref
            fallback_value: '[current-user:uid]'
```

Option keys per type (see [reference/plugins.md](../reference/plugins.md) for full detail):

- `cookie` → `cookie_key`, `fallback_value`. Reads `$_COOKIE['Drupal_visitor_' . cookie_key]`.
- `session` → `session_key` (use `a::b` for nested), `fallback_value`, `cache_time`.
- `tempstore` → `tempStore_unique_name`, `tempStore_key`, `fallback_value`, `cache_time`.

`fallback_value` is run through the token service with the current user as the `user` token type.

### Set programmatically

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['arguments']['nid']['default_action'] = 'default';
$display['display_options']['arguments']['nid']['default_argument_type'] = 'cookie';
$display['display_options']['arguments']['nid']['default_argument_options'] = [
  'cookie_key' => 'my_pref',
  'fallback_value' => '[current-user:uid]',
];
$view->save();
```

## The `extra_result` area (result summary)

In the Views UI: add to the **Header** or **Footer** → **Extra Result summary** (Global group). Set
the **Display** string using the supported tokens.

In config it appears under a display's `header` or `footer`:

```yaml
footer:
  extra_result:
    id: extra_result
    table: views
    field: extra_result
    plugin_id: extra_result
    content: 'Displaying @start - @end of @total'
```

Tokens: `@start @end @total @label @per_page @current_page @current_record_count @page_count @more`
(`@more` = `@total - @current_record_count`, hidden when 0). Requesting `@total`/`@more` forces the
view to compute total rows.
