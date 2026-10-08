# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- Core's **RESTful Web Services** module (`rest`) — this is a dependency and Drupal
  will enable it for you (along with core **Serialization**).
- The contributed **REST UI** module (`restui`) is strongly recommended, since you
  need to enable the resource and add an authentication method, which REST UI makes
  a point-and-click job.

Note this is a `1.0.x` development release and the module is described as minimally
maintained — test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_invalidate_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install REST UI too if you do not already have it:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_invalidate_cache -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_invalidate_cache -y
drush en restui -y
```

## Turn on the REST resource, authenticate it, and grant the permission

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`).
2. Enable the **Invalidate cache** resource. Set the method to **POST**, pick the
   serialisation format(s) you need, and — importantly — choose an **authentication
   method** (for example `basic_auth` or another token-based method) so the endpoint
   is not open.
3. Go to **People → Permissions** (`/admin/people/permissions`) and grant the
   resource's permission **only** to a dedicated, trusted role used by the machine
   account that will call it. Do **not** grant it to *Anonymous* or *Authenticated
   user*.

## Verify it worked

Send an authenticated POST naming a tag to invalidate:

```
POST https://your-site/invalidate_cache/node:1
```

A successful request clears the cache for that tag. A `403` means the resource is
not enabled, authentication failed, or the permission is not granted to the calling
account. Because this endpoint can be abused to force expensive rebuilds, confirm it
is reachable only by the accounts you intend, and consider adding rate-limiting at
your web server or CDN.
