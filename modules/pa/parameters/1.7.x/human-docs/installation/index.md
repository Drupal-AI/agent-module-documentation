# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/parameters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/parameters -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en parameters -y
```

The base module gives you the storage and the API. To actually create and manage
parameters through the admin UI, enable the **Parameters UI** submodule too — most
sites will want it:

```bash
drush en parameters_ui -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Parameters UI** | `parameters_ui` | The administrative interface for creating, editing, and organizing parameters. Enable this unless you plan to define every parameter purely in code/config. |
| **Parameters Content** | `parameters_content` | A content‑side variant of parameters — for values you want to behave like content (survive config imports, edited freely in production) rather than as exportable configuration. |

Enable a submodule the same way, for example:

```bash
drush en parameters_content -y
```

## Verify it worked

Log in as an administrator and, with **Parameters UI** enabled, open the
Parameters admin screen (see [Configuration](../configuration/index.md)). If you
can create a new parameter and read its value back through a Token or in a Twig
template, the module is working.
