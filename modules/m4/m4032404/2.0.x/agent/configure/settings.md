# Configure 403 to 404

Config object **`m4032404.settings`**. Form `M4032404Form` at `/admin/config/system/m4032404`
(route `m4032404.config`, permission `administer 403 to 404 settings`). Saving rebuilds the router
so changes apply immediately.

## Settings keys (with shipped defaults)

| Key | Type | Default | Effect |
|---|---|---|---|
| `admin_only` | bool | `false` | If true, only convert 403→404 on **admin** routes (`AdminContext::isAdminRoute()`). |
| `pages` | sequence of strings | `[]` | Path patterns (`*` wildcard, `<front>`). Empty = applies to **all** paths. |
| `negate` | bool | `true` | With `pages`: `false` = redirect **only** the listed paths; `true` = redirect everything **except** the listed paths. |

Form nuance: the radio labelled "Redirect the above paths to 404" stores `negate = false` (index 0),
"Do not redirect the above paths to 404" stores `negate = true` (index 1). The `pages` textarea is
one path per line and is stored as an array (blank lines trimmed).

## Permissions

- **`access 403 page`** — a user with this permission bypasses the redirect and sees the real 403
  (handy for editors/debugging). Everyone else gets the 404.
- **`administer 403 to 404 settings`** — gates the config form (`restrict access: TRUE`).

## How the redirect is decided

`M4032404EventSubscriber::onAccessDeniedException()` (priority 50 on `KernelEvents::EXCEPTION`):
1. Only acts on `AccessDeniedHttpException`.
2. Skips routes that are CSRF-confirm forms (`_csrf_token` requirement + `_csrf_confirm_form_route`) so token flows keep working.
3. Redirects when `(!admin_only || isAdminRoute)` **and** the current user lacks `access 403 page` **and** the path passes `pathIncluded()`.
4. `pathIncluded()`: empty `pages` ⇒ always true; otherwise `(matched && !negate) || (!matched && negate)`.
5. On a match it calls `$event->setThrowable(new NotFoundHttpException())`.

## Drush / scripting

```bash
drush cget m4032404.settings                       # read all keys
drush cset m4032404.settings admin_only 1 -y        # admin routes only
drush cset m4032404.settings negate 0 -y            # 'pages' becomes an include list
```

`pages` is a sequence — set it with `php:eval`:
```php
\Drupal::configFactory()->getEditable('m4032404.settings')
  ->set('pages', ['/reports/*', '/secret/*'])->set('negate', FALSE)->save();
```
(Behaviour is via config only; there is no route/rebuild needed beyond `drush cr` when scripting.)
