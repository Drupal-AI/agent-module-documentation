# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third‑party Composer or PHP library requirements.

This is a **developer module** — you install it because your own (or another)
module attaches the `_routing_access_check_headers` requirement to a route. It has
no UI and does nothing until a route uses it.

## Install with Composer

From the project root:

```bash
composer require drupal/routing_access_check_headers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/routing_access_check_headers -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en routing_access_check_headers -y
```

## Verify it worked

There is nothing to see in the admin UI — the module adds no page or settings
form. It's working once a route that carries the `_routing_access_check_headers`
requirement enforces it: a request with the expected header shape is allowed,
while one without it is forbidden (fail‑closed). See "How to use it" on the
[overview page](../index.md) for adding the requirement to a route.

Remember that request headers are client‑controlled and spoofable — use this as
one layer alongside authentication, CSRF tokens, or rate limiting, not as a route's
only protection.
