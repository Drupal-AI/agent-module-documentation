# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- Core's **Field** system, which is part of the standard install. No third-party
  Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_header_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_header_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_header_field -y
```

The **Advanced Header** field type is then available when you add a field to any
content type or other fieldable entity.

## Optional submodule

Advanced Header Field ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Navigation** | `advanced_header_field_navigation` | Navigation-related integration for the header field. Enable it only if you need that behavior. |

Enable it the same way when needed:

```bash
drush en advanced_header_field_navigation -y
```
