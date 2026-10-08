# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- **PHP 8.2 or newer**.
- Contributed dependencies (Composer installs these for you):
  - [Migrate Plus](https://www.drupal.org/project/migrate_plus) (`^6.0.9`)
  - [Pathauto](https://www.drupal.org/project/pathauto) (`^1.13`)
  - [Ctools](https://www.drupal.org/project/ctools) (`^3 || ^4`)
  - [Migrate Tools](https://www.drupal.org/project/migrate_tools) (`~6.0`) — this
    is required to actually **run** the generated migrations.
- Core's **Migrate** module is used under the hood (part of core).
- A WordPress **WXR** export file (produced by WordPress *Tools → Export*).

> **Version note:** WordPress Migrate 3.0.x is an **alpha** release. Test the
> import on a non‑production copy first.

## Install with Composer

Because this module pulls in several contrib dependencies, always install it with
Composer:

```bash
composer require drupal/wordpress_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Migrate Plus,
Pathauto, Ctools, Migrate Tools, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/wordpress_migrate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en wordpress_migrate -y
```

Or enable **WordPress Migrate Support** from **Extend** (`/admin/modules`).

## The wizard submodule

The base module gives you the Drush command and the programmatic generator. If
you want the guided **UI wizard**, also enable the `wordpress_migrate_ui`
submodule:

```bash
drush en wordpress_migrate_ui -y
```

With it enabled, an *Add import from WordPress* button appears on the Migrate
Tools group list under **Structure → Migrations**.

## Next steps

The base module has no settings form. To run an import, generate the migrations
(wizard, Drush, or code) and then execute them with Migrate Tools — see
[How to use it](../index.md#how-to-use-it) on the overview page. (Advanced:
logging verbosity is controlled by keys in the `wordpress_migrate.settings`
config object, adjustable via Drush `config:set` or config sync; there is no
admin form for it.)
