# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no contrib‑module or PHP‑library dependencies. Note that this release line
is a **beta** (2.0.0‑beta) and the project is *not* covered by Drupal's security
advisory policy — weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/query -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/query -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en query -y
```

## Verify it worked

There is no admin page to check. Confirm the module is enabled at **Extend**
(`/admin/modules`), or from the command line:

```bash
drush pm:list --status=enabled | grep query
```

Once enabled, the `query` service is available to any module or custom code that
requests it.
