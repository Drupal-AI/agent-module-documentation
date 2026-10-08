# How the split works (hooks + service)

The whole module is three hooks in `account_field_split.module` delegating to one service,
`Drupal\account_field_split\ExtraFieldManager` (registered via `classResolver`, not a
tagged service; constructed with `module_handler`, `current_route_match`, `current_user`).

## Hooks

- **`hook_entity_extra_field_info()`** → `ExtraFieldManager::extraFieldInfo()`
  Declares the seven pseudo-fields under `['user']['user']['form']` — `mail`, `name`,
  `pass`, `status`, `roles`, `notify`, `current_pass` — each `visible => TRUE`, `weight => 0`.
  This is what makes them show up as rows on Manage form display.

- **`hook_entity_extra_field_info_alter(&$info)`**
  Unsets `$info['user']['user']['form']['account']`, removing the bundled
  "User name and password" element from the form-display list.

- **`hook_form_alter()`** → `ExtraFieldManager::formAlter()`
  Only acts when the form's `base_form_id` (or `form_id`) is `user_form`. It walks
  `Element::children($form['account'])` and promotes each child widget from the core
  `$form['account']` container up to the top level of `$form`, so the per-component weights
  set in the form display are honoured. It early-returns on the anonymous `user.reset` route
  when `simple_pass_reset` is installed.

## Install behaviour (`account_field_split.install`)

- `hook_install()` calls `module_set_weight('account_field_split', 101)` (run alters late)
  and invalidates the `config:core.entity_form_display.user.user.default` and
  `entity_form_display_list` cache tags plus the discovery cache.
- `hook_uninstall()` invalidates the same caches to restore core rendering.
- `account_field_split_update_9001()` re-applies the weight 101.

## Reading it programmatically

```php
// The list of split component keys, straight from the service.
$extra = \Drupal::classResolver(\Drupal\account_field_split\ExtraFieldManager::class)
  ->extraFieldInfo();
$keys = array_keys($extra['user']['user']['form']); // mail, name, pass, status, roles, notify, current_pass
```

There is **no** settings storage, permission, schema, plugin type or Drush command — the
only persistent surface is the form-display config entity described in
[../configure/form-display.md](../configure/form-display.md).
