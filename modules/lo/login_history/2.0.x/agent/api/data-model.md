# Login History — data model & Views

## The `login_history` table (`hook_schema` in `login_history.install`)

Base table, one row per successful login:

| Column | Type | Notes |
|---|---|---|
| `login_id` | serial | primary key |
| `uid` | int | the user who logged in |
| `login` | int | login timestamp (from `$account->getLastLoginTime()`) |
| `hostname` | varchar(128) | client IP at login (`$request->getClientIP()`) |
| `one_time` | tinyint | `1` if login came from a one-time login link (route `user.reset.login`) |
| `user_agent` | varchar(256), nullable | browser UA string, truncated to 255 chars |

Indexes: `uid`, `one_time`, and composite `uid, hostname`.

## Hooks that write it (`login_history.module`)

- `hook_user_login($account)` — inserts the row on every successful login; sets `one_time`
  from the current route; truncates the UA to 255 chars; then prunes that user to `keep_user`.
- `hook_cron()` — finds users whose row count exceeds `keep_user` and prunes them via
  `_login_history_remove_user_events()` (deletes oldest rows by `login`).
- `hook_user_delete($account)` — deletes all rows for the removed uid.

There is **no entity** here — it is a plain schema table. Read it with `\Drupal::database()`
or SQL, not the entity API:

```php
$rows = \Drupal::database()->select('login_history', 'lh')
  ->fields('lh', ['login', 'hostname', 'one_time', 'user_agent'])
  ->condition('uid', $uid)
  ->orderBy('login', 'DESC')
  ->execute()->fetchAll();
```

```bash
drush sqlq "SELECT uid, login, hostname, one_time FROM login_history ORDER BY login DESC LIMIT 5"
```

## Views integration (`login_history.views.inc`)

- `hook_views_data()` declares `login_history` as a **base table** (`base.field = uid`), joined
  to `users_field_data` on `uid`, with fields: `uid` (User relationship), `login` (Date field,
  sort, filter, `date_fulldate` argument), `hostname` (IP Address, string filter), `one_time`
  (boolean yes/no filter), `user_agent` (string).
- `hook_views_data_alter()` adds a `Logins` relationship on the `users` table so a user View can
  pull in its historical logins.

Build custom reports by adding a View on the `login_history` base table, or extend the shipped
`login_history` view. There are no services or Drush commands to call.
