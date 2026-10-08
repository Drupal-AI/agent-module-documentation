<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure anonymous-login paths

All settings live in the config object **`anonymous_login.settings`** (configure route
`anonymous_login.settings` → `/admin/config/user-interface/anonymous-login`, permission
`administer anonymous login settings`).

## Keys

| Key | Type | Meaning |
|---|---|---|
| `paths` | sequence of strings | Each entry is a path. A plain entry **includes** (forces login); an entry prefixed with `~` **excludes**. `*` wildcards allowed. |
| `login_path` | string | Where to send users to log in. Default `/user/login`. Must be a valid path. |
| `message` | string | Optional status message shown when a user is redirected. |

Shipped install default is only `login_path: '/user/login'` (no `paths`, no `message`).

## Via the UI

1. Go to *Configuration → User interface → Anonymous login*.
2. **Page paths** (textarea, one per line): e.g.
   ```
   /members/*
   ~/members/public
   ```
   (include everything under `/members`, but not `/members/public`).
3. **Login page path**: usually `/user/login`.
4. **Login message** (optional).
5. Save. The form trims blank lines and validates `login_path`.

## Via drush (scriptable)

```bash
# Force login on everything under /members except /members/public, keep default login page:
drush cset anonymous_login.settings paths.0 '/members/*' -y
drush cset anonymous_login.settings paths.1 '~/members/public' -y
drush cset anonymous_login.settings login_path '/user/login' -y
drush cset anonymous_login.settings message 'Please log in to continue.' -y
```

Or set the whole sequence in PHP:

```php
\Drupal::configFactory()->getEditable('anonymous_login.settings')
  ->set('paths', ['/members/*', '~/members/public'])
  ->set('login_path', '/user/login')
  ->set('message', 'Please log in to continue.')
  ->save();
```

## Read it back

```bash
drush cget anonymous_login.settings
drush cget anonymous_login.settings paths
```

## Semantics recap

- A plain path = **include** (redirect anonymous users to login). A `~`-prefixed path =
  **exclude** (never redirect). An exclude match is a hard stop for that request.
- `*` is a wildcard (`/node/*`). Both the internal path and its alias are checked.
- Redirect target is `login_path` + `?destination=<requested alias>` so users return after login.
- Always excluded regardless of config: `user/reset/*`, `cron/*`, `sites/default/files/*`; the
  login page, `.php` requests, CLI, maintenance mode, and non-anonymous users are skipped.
