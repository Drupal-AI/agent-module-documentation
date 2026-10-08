# Installation

> **Development sites only.** PingMe is example/tutorial code with an intentionally
> insecure access model (anonymous visitors can create, edit, and delete records
> and read stored email addresses). Do not install it on a public or production
> site. See the [overview](../index.md).

## Requirements

PingMe needs:

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8.0 || ^9 || ^10`).

There are no third‑party Composer library requirements and no module dependencies
beyond core. On enable it creates its own `pingme` database table.

## Install with Composer

From the project root:

```bash
composer require drupal/pingme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pingme -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pingme -y
```

Enabling the module runs `pingme.install`, which creates the `pingme` table.

## Verify it worked

Visit **`/ping-me/records`** and confirm the record list loads. Try adding a
record via the form, then viewing it in the modal popup — the CRUD and AJAX
patterns the module demonstrates should all work. When you're done studying it,
uninstall it (`drush pmu pingme -y`) to drop the `pingme` table, especially on any
site that is not purely local.
