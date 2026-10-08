<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the redirect works & the alter hook

## The event subscriber

Service `anonymous_login.redirect` = `AnonymousLoginSubscriber`, subscribed to
`KernelEvents::REQUEST` at **priority 100** (`redirect()` method). On each request it returns
early (no redirect) when any of these is true:

- maintenance mode is on,
- running under CLI (`PHP_SAPI === 'cli'`),
- no include paths are configured,
- the current user is **not** anonymous,
- the request is for the login page or a `.php` file.

Otherwise it resolves the current path **and** its alias, converts the front page to `<front>`,
and matches both against the include/exclude lists with `\Drupal\Core\Path\PathMatcher`
(`*` wildcards, newline-joined patterns). If an include matches and no exclude matches, it sets
a `RedirectResponse` to `login_path?destination=<alias>` (preserving query string, stripping any
existing `destination` to avoid double redirects) and shows `message` as a status message.

## paths() — how include/exclude are built

`paths()` reads `anonymous_login.settings.paths` and splits it:
- entry starting with `~` → `exclude` (tilde stripped),
- otherwise → `include`.

It then **always appends** these excludes: `user/reset/*`, `cron/*`, `sites/default/files/*`.
Finally it invokes the alter hook. Returns `['include' => [...], 'exclude' => [...]]`.

## Alter hook

```php
/**
 * Implements hook_anonymous_login_paths_alter().
 */
function mymodule_anonymous_login_paths_alter(array &$paths) {
  // Force login on a path in code (no leading slash needed after normalization):
  $paths['include'][] = '/reports/*';
  // Never redirect node pages:
  $paths['exclude'][] = '/node/*';
}
```

Note the hook array uses keys `include` / `exclude` (the `.api.php` example text shows
`included`/`excluded` in prose, but the real keys the subscriber reads are `include` and
`exclude`). Use this to add always-on rules without editing config.

There is no service method you normally call directly; the subscriber runs automatically. To
inspect the effective lists programmatically you can call
`\Drupal::service('anonymous_login.redirect')->paths()`.
