# Installation

## Requirements

Hello Contrib has no third‑party or contrib dependencies. It needs only:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hello_contrib -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hello_contrib -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hello_contrib -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/hello-contrib`**. You should see the
greeting page render. That confirms the module installed, enabled, and served its
one route successfully — which is the entire purpose of this example module.
