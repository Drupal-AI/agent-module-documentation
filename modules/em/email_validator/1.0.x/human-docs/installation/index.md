# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- An account at **e‑va.io** with an **API key** — free to create, and required
  before validation will work.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/email_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Note on versions:** `drupal/email_validator` is a single project with both a
> 1.0.x and a later 3.0.x line. Composer resolves the version that matches your
> Drupal core and any constraint you set in `composer.json`. Pin the constraint if
> you specifically need the 1.0.x release documented here.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_validator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_validator -y
```

## Verify it worked

Log in as an administrator and open the module's settings form under
**Configuration**. If it loads and offers a field for your e‑va.io API key, the
module is installed. Continue with [Configuration](../configuration/index.md) to
enter the key and start validating addresses.
