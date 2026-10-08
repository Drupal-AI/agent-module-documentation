# Configuration

Out of the box, 403 to 404 converts **every** access-denied response to a
not-found. Everything on this page is about **narrowing that scope**. The settings
form is at **Configuration → System → 403 to 404**
(`/admin/config/system/m4032404`), reached with the **Administer 403 to 404
settings** permission. Saving the form rebuilds the router, so changes apply
immediately.

## Settings, field by field

**Admin routes only** *(off by default)* — when on, the 403→404 conversion happens
only on **admin** routes. Turn this on if you want to hide the admin area from
anonymous visitors while leaving front-end 403s as ordinary access-denied pages.

**Pages** — a list of path patterns, one per line. Supports the `*` wildcard and
the `<front>` token (for example `/reports/*`). Leave it **empty** to apply the
behaviour to all paths.

**Redirect / do not redirect the above paths** — a pair of radio options that
decide what the **Pages** list means:

- **Redirect the above paths to 404** — only the listed paths are converted; every
  other 403 is left as a real 403.
- **Do not redirect the above paths to 404** *(the default)* — everything is
  converted **except** the listed paths, which keep showing the real 403.

So the Pages list can act as either an **include** list or an **exclude** list,
depending on which radio you choose.

## The per-user escape hatch

Regardless of the scope above, any user with the **Access 403 page** permission
always sees the real 403 instead of the 404. Grant it to editors or to yourself
while debugging an access problem, so you can tell a genuine permission issue apart
from a missing page. Everyone else gets the 404.

## What is always left alone

CSRF confirmation routes (the token-protected confirm steps some actions use) are
never converted, so those flows keep working normally.

## Setting values by script

The simple toggles can be set with Drush:

```bash
drush cset m4032404.settings admin_only 1 -y     # admin routes only
drush cset m4032404.settings negate 0 -y          # make 'pages' an include list
```

The **pages** list is an array, so set it with `php:eval`:

```php
\Drupal::configFactory()->getEditable('m4032404.settings')
  ->set('pages', ['/reports/*', '/secret/*'])
  ->set('negate', FALSE)
  ->save();
```

(Here `negate: FALSE` means "redirect only these paths".) The full list of keys and
their defaults is in the [agent configuration doc](../agent/configure/settings.md).
