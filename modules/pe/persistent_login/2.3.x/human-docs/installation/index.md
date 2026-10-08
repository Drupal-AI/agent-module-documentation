# Installation

## Requirements

Persistent Login needs:

- **Drupal core `^11.2 || ^12`** (`core_version_requirement: ^11.2 || ^12`).
- A **PHP session cookie lifetime of `0`** in your site's `services.yml` (see below). This
  is not optional — the module reports an error on the status page until it is set.

There are no other module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/persistent_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/persistent_login -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en persistent_login -y
```

A **Remember me** checkbox now appears on the login form.

## Set the required session-cookie option

Persistent Login needs Drupal's own session cookies to expire when the browser closes, so
that *only* its own cookie keeps a user signed in long-term. Edit your site's
`services.yml` (typically `web/sites/default/services.yml`) and set:

```yaml
parameters:
  session.storage.options:
    cookie_lifetime: 0
```

Then rebuild caches (`drush cr`). Until this is in place, the site **Status report** at
`/admin/reports/status` shows an error for Persistent Login.

If you sit behind a reverse-proxy cache such as Varnish, also make sure requests carrying
the persistent-login cookie are excluded from cache hits.

## Verify it worked

Check `/admin/reports/status` — the Persistent Login item should be green. Then log in with
**Remember me** ticked; you can confirm the remembered login appears at
`/user/<your-uid>/persistent-logins`.

## Next step

The defaults are sensible, but you can tune lifetime, device limits and wording — see
[Configuration](../configuration/index.md).
