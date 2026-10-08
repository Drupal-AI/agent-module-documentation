# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no third‑party Composer packages, PHP library requirements, or module
dependencies beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/video_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/video_filter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en video_filter -y
```

Enabling the module makes the **Video Filter** filter available, but does not turn it on
anywhere by itself — you enable it per text format (see
[Configuration](../configuration/index.md)).

## Submodule — Video Filter Example

The project bundles one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Video Filter Example** | `video_filter_example` | A worked example of a custom provider "codec", for developers who want to add support for a video service that isn't built in. |

Enable it only if you want to study or copy the example:

```bash
drush en video_filter_example -y
```

## Next step

Head to [Configuration](../configuration/index.md) to enable the filter on a text format
and choose which providers to allow.
