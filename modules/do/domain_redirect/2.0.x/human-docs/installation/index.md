# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Domain** module (`domain`), version **3.x**.
- The **Redirect** module (`redirect`), version **1.x** — this module extends it.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, including a compatible Redirect release.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_redirect -y
```

This also enables `domain` and `redirect` if they are not already on.

## Verify it worked

No configuration is required. Go to **Configuration → Search and metadata → URL
redirects** (`/admin/config/search/redirect`) and add or edit a redirect — you
should now see a **Domain** selector on the form and a *Domain* column and filter
on the listing. See [Configuration](../configuration/index.md) for how to use
them.
