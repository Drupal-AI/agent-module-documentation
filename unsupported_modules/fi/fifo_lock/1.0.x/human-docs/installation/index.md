# Installation

## Requirements

- **Drupal 8.7.7+, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library dependencies. The module manages its own database table automatically.

> **Note:** This project is **not covered by Drupal's security advisory policy**.
> Weigh that before deploying it on a site with strict security requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fifo_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fifo_lock -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fifo_lock -y
```

Enabling the module makes the `fifo_lock` service available. It does **not** change
your site's default locking on its own — you opt in per call site or site-wide as
described in [the overview](../index.md#how-to-use-it).

## Verify it worked

After enabling, the `fifo_lock` service exists and its database table is created on
first use. If you overrode the default `lock` backend in a `services.yml`, rebuild
caches (`drush cr`) so the container picks up the change, then exercise a code path
that takes a lock to confirm ordering behaves as expected.
