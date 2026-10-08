<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Custom Login Url

There is **no admin form and no config entity**. The only setting is a `settings.php` value.

## The one setting

```php
// settings.php — the trailing slash is required (auto-appended if you omit it).
$settings['custom_login_pattern'] = 'my_login_url/';
```

- Default (unset) is `/user/`, so the site behaves normally until you set this.
- Constant name in code: `RouteSubscriber::CONF_NAME = 'custom_login_pattern'`.
- Read via `\Drupal\Core\Site\Settings::get('custom_login_pattern', '/user/')`.
- Rebuild routes after changing it: `drush cr` (route cache).

## Validation rules (`RouteSubscriber::validCustomPattern`)

| Input | Result |
|---|---|
| empty string or `'/'` | throws `\Exception('The custom login url pattern should not be empty')` |
| no trailing slash (e.g. `'foo'`) | `CustomLoginSlashEndException` caught internally → `'/'` appended → `'foo/'` |
| `'foo/'` | used as-is |

## What moves, exactly

`RouteSubscriber::alterRoutes()` iterates the whole route collection:

1. **Every route whose path starts with `/user/`** (`OLD_PATTERN = '/user/'`) has that leading
   segment `preg_replace`d (once) with your pattern. So `/user/login`, `/user/password`,
   `/user/register`, `/user/{user}/edit`, etc. become `/<pattern>login`, `/<pattern>password`, …
2. **`user.login`** specifically is then repointed to the pattern *without* its trailing slash
   (`substr($pattern, 0, -1)`), so with `my_login_url/` the login form lives at `/my_login_url/login`
   — wait: login route path is set to `my_login_url` (pattern minus slash) — the canonical login is
   reachable at the pattern root; other `/user/...` children keep the full prefix.

Note: routes at the bare path `/user` (no trailing slash) — notably `user.page` — are **not** matched
by the `/user/` prefix. Those are instead handled by the exception subscriber below.

## Old `/user` returns 404

`KernelSubscriber` subscribes to `KernelEvents::EXCEPTION` (priority 100). When the resolved route is
`user.page`, it replaces the throwable with a `NotFoundHttpException`, so the legacy `/user` endpoint
404s instead of redirecting an anonymous visitor to the login page (which would confirm the login exists).

## Theming preserved

`Hook\TemplateSuggestions::keepTemplateSuggestions()` (`#[Hook('theme_suggestions_page_alter')]`)
re-inserts `page__user` on the `entity.user.canonical` route and `page__user`, `page__user__login`
on the `user.login` route, so your `page--user--login.html.twig` etc. still apply at the new path.

## Caveats

- Obscurity only — anyone who discovers the path reaches the standard login form. Add flood/2FA.
- The path is invisible to `drush config:export` (settings.php, not config).
- Third-party links/redirects hardcoded to `/user/login` will now 404.
