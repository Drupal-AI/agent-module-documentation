# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2** or newer.
- An **AddEvent account** with an API token — the module talks to AddEvent's
  hosted service, so you need credentials from https://www.addevent.com/.

There are no additional Composer library requirements beyond the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/addevent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addevent -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addevent -y
```

## Next steps

Nothing works until you enter your AddEvent API token. Head to
[Configuration](../configuration/index.md) to add the token and then place a block
or add the AddEvent field to a content type. Grant the **Administer addevent
settings** permission only to trusted administrators, since it controls the API
token.
