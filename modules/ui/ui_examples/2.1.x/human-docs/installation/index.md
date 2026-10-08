# Installation

## Requirements

- **Drupal 11.4 or newer** (`core_version_requirement: ^11.4 || ^12`).
- **PHP 8.3 or newer** (`php: >=8.3`).

There are no other module dependencies and no third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_examples -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ui_examples -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_examples -y
```

The Examples library is then available at **Appearance → UI → Examples**
(`/admin/appearance/ui/examples`).

## Submodule — optional starter examples

UI Examples ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **UI Examples Defaults** | `ui_examples_defaults` | Two ready-made examples — a "Normalize" page of standard HTML elements and a "Status messages" example — so the library is not empty on a fresh install. |

Enable it if you want something to look at straight away:

```bash
drush en ui_examples_defaults -y
```

It requires the base UI Examples module, which is already present once you have
installed it above.
