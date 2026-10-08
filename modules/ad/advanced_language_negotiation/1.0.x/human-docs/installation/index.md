# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's multilingual modules — in particular **Language** and, for translated
  content, the other core language modules. You need more than one language
  configured for this to be meaningful.
- No third-party Composer or PHP library requirements.

> **Note:** the current release is a **beta** (`1.0.0-beta3`). Test it against
> your domain/path setup before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_language_negotiation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_language_negotiation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_language_negotiation -y
```

After enabling, turn on and order the negotiation method under **Configuration →
Regional and language → Languages → Detection and selection** — see
[Configuration](../configuration/index.md).
