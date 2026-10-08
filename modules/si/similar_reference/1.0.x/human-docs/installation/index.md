# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Views** module (`views`), which is included with Drupal and enabled by
  default on most sites. Drupal enables it automatically as a dependency if it is
  off.
- No third-party Composer or PHP library requirements.

Note that this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/similar_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/similar_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en similar_reference -y
```

There is no settings form to visit afterwards. You build the "similar content"
listing in the **Views** UI — see the main guide's
[How to use it](../index.md#how-to-use-it) section.
