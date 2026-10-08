# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No other module dependencies and no third‑party Composer libraries — the icon
  assets (including a bundled Font Awesome library) ship with the module.

**Optional:** if you already run the [Font Awesome](https://www.drupal.org/project/fontawesome)
module site‑wide, the block can use that shared library instead of the bundled
icon assets. It is only a suggestion, not a requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/social_media_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/social_media_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_media_links -y
```

Nothing appears on the site until you place the block — see
[Configuration](../configuration/index.md).

## Submodule — the field variant

The module ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Social Media Links Field** | `social_media_links_field` | A *field type* that stores social profiles on any entity (content types, users, taxonomy terms, and so on), using the same platform list and appearance options as the block. Enable it when you want per‑entity social links rather than a single fixed block. |

Enable it only if you need the field:

```bash
drush en social_media_links_field -y
```

It requires the base Social Media Links Block module, which is already present
once you have installed it above.
