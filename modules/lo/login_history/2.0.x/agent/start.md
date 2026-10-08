# Login History — agent index

Records one row per successful login into a dedicated `login_history` DB table (uid, login
timestamp, hostname/IP, user_agent, one_time flag). Surfaces it via Views, two report routes,
and a "Last login" block. One config value (`keep_user`) bounds rows per user.

- **Settings, reports, permissions, and the block** → [configure/settings.md](configure/settings.md)
- **Data model: the `login_history` table, the hooks that write it, and Views integration** →
  [api/data-model.md](api/data-model.md)

Key facts:
- Config: `login_history.settings` → `keep_user` (int, default 50; `0` = keep all).
- Configure route `login_history.settings` at `/admin/config/people/login-history`.
- Reports: `login_history.report` (`/admin/reports/login-history`, perm *view all login histories*)
  and `login_history.user_report` (`/user/{user}/login-history`, perm *view own login history*).
- Permissions: `view own login history`, `view all login histories`, `administer login history`.
- Block plugin id `last_login_block` (category "User").
- No Drush commands, no plugin types. Data lives only in the `login_history` table + config.
