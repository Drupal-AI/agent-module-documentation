# Configure Login History

## Settings

One config object, `login_history.settings`, with a single key:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `keep_user` | integer | `50` | Max login rows kept **per user**. `0` = keep all (no pruning). |

Admin form: `login_history.settings` route at `/admin/config/people/login-history`
(`AdminSettingsForm`, permission *administer login history*). The form field is "Per User".

```bash
drush cget login_history.settings keep_user
drush cset login_history.settings keep_user 10 -y
```

Pruning to `keep_user` happens (a) immediately after each login for that user and (b) on cron
for every user over the limit (`hook_cron()`), deleting the oldest rows (ordered by `login`).

## Reports (routes)

| Route | Path | Permission |
|---|---|---|
| `login_history.report` | `/admin/reports/login-history` | `view all login histories` |
| `login_history.user_report` | `/user/{user}/login-history` | `view own login history` |
| `login_history.settings` | `/admin/config/people/login-history` | `administer login_history` |

The site-wide report is backed by the default `views.view.login_history` config entity (created
on install / by `login_history_update_8002`).

## Permissions (`login_history.permissions.yml`)

- `view own login history` — see your own `/user/{uid}/login-history` and the block's link.
- `view all login histories` — see the site-wide report.
- `administer login history` — access the settings form. (Note: the routing requires
  `administer login_history`; the permission is titled "Administer login history".)

## "Last login" block

Block plugin `last_login_block` (admin label "Last login", category "User"). Only visible to
authenticated users; renders "You last logged in from @hostname using @user_agent." from the
user's *second-most-recent* row (`range(1,1)` ordered by `login DESC`), plus a "View your login
history" link when the user has *view own login history*. Cached per `session`. Place it like any
block via Block layout or a `block` config entity with `plugin: last_login_block`.
