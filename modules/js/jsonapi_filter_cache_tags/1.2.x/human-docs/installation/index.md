# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — enabled automatically as a dependency.

There are no third‑party Composer packages or external libraries to install.

> **Early development.** As the maintainers note, this module is at an early stage.
> It falls back safely to Drupal's default cache tags for anything it doesn't
> support, but test it against your own traffic before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_filter_cache_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_filter_cache_tags -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_filter_cache_tags -y
```

This also enables core JSON:API if it isn't already on. There is no configuration
step.

## Verify it worked

Make a supported filtered request — an entity-reference-by-UUID filter using the
`=` operator, e.g.
`/jsonapi/node/page?filter[field_category.id]=<uuid>` — and inspect the
`X-Drupal-Cache-Tags` response header. Instead of the generic `node_list` tag you
should see a precise `jsonapi_filter:...` tag for that filter value. Requests that
use unsupported filter shapes will still carry the default `node_list` tag, which
is expected.
