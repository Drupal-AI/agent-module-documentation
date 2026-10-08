# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other modules, PHP libraries, or third-party Composer packages.

This is an **alpha** release (`1.0.0-alpha1`) and is **not** covered by drupal.org's
security advisory policy — test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/timestamp_nullable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/timestamp_nullable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en timestamp_nullable -y
```

## Verify it worked

Go to a content type's **Manage form display** tab, find a timestamp field, and open
the widget dropdown — you should now see **Datetime Timestamp (Nullable)** as an
option. Select it, save, then edit a piece of content and confirm you can leave the
field blank without it defaulting to the current date and time.
