# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Views is part of the standard Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alpha_pagination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alpha_pagination -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alpha_pagination -y
```

Once enabled, the **Global: Alpha pagination** area handler becomes available in
the Views UI. See [How to use it](../index.md#how-to-use-it) for adding it to a
View.

## Optional submodule — a sample View

The project bundles one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Alpha Pagination Sample View** | `alpha_pagination_sample_view` | Installs a ready-made example View that demonstrates the paginator in place — handy as a reference when you build your own. |

Enable it only if you want the demo:

```bash
drush en alpha_pagination_sample_view -y
```
