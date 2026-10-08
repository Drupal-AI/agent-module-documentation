# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- An audio file field on the content or media type you want to render as a
  player (for the formatters submodule).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/amplitudejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amplitudejs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amplitudejs -y
```

## Enable the formatters submodule

To render audio fields as players, also enable the formatters submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Formatters** | `amplitudejs_formatters` | Field formatters that render an audio file field as an AmplitudeJS player. |

```bash
drush en amplitudejs_formatters -y
```

It requires the base AmplitudeJS module, which is already present once you have
installed it above. Then assign the AmplitudeJS formatter on your audio field's
**Manage display** screen (see the [overview](../index.md)).
