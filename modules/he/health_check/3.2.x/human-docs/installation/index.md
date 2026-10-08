# Installation

## Requirements

- **PHP 8.0 or newer** (`php: ^8.0`).
- **Drupal 9.4, 10, 11, or 12** (`core_version_requirement: ^9.4 || ^10 || ^11 ||
  ^12`).

That's it — the module has **no other module dependencies** and no third‑party
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/health_check -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/health_check -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en health_check -y
```

The `/health` endpoint is live immediately. There are **no submodules** and
nothing to configure inside Drupal.

## Verify it worked

```bash
curl -i https://your-site/health
```

You should see `HTTP/… 200`, a `Content-Type: text/plain` header, and a numeric
UNIX timestamp as the body. Next, see [Configuration](../configuration/index.md)
to wire it into your load balancer or monitoring.
