# Hooks

## Alter hooks Counter invokes (for integrators)

Both are dispatched from `CounterEventsSubscriber::counterInsert()` and let another module
suppress or modify a count.

### `hook_counter_request_alter(RequestEvent $event, bool &$skip)`
Invoked after Counter's built-in path skips, before the data row is built. Set `$skip = TRUE`
to prevent recording this request.

```php
function mymodule_counter_request_alter($event, &$skip) {
  if (str_starts_with($event->getRequest()->getPathInfo(), '/api/')) {
    $skip = TRUE;
  }
}
```

### `hook_counter_data_alter(array &$data, bool &$skip)`
Invoked with the assembled row (`ip`, `url`, `uid`, `nid`, `type`, `browser_name`,
`browser_version`, `platform`) just before insert. Mutate `$data` to change stored values, or
set `$skip = TRUE` to drop it.

```php
function mymodule_counter_data_alter(array &$data, &$skip) {
  $data['ip'] = '0.0.0.0'; // anonymise before storage
}
```

## Hooks Counter implements

| hook | file | effect |
|------|------|--------|
| `hook_cron` | `counter.module` | `Cache::invalidateTags(['counter_data_refresh'])` — refreshes the cacheable counter blocks. Enable cron for up-to-date counts. |
| `hook_theme` | `counter.module` | Registers theme hooks `counter`, `configure_counter`, `counter_dashboard`, `counter_statistics`. |
| `hook_views_data` | `counter.views.inc` | Exposes the `counter` table to Views — see [../views/views.md](../views/views.md). |
| `hook_help` | `counter.module` | Help text on `help.page.counter`. |
| `hook_schema` / `hook_uninstall` / `hook_update_N` | `counter.install` | Creates/drops the `counter` table; updates `8101`–`8103`. |
