# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Content Moderation** (`content_moderation`) and **Field** (`field`)
  modules enabled.
- *Suggested:* **Drush** (`>=10`) if you want to back‑fill or manage the field
  from the command line.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cached_moderation_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cached_moderation_state -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cached_moderation_state -y
```

On install, the module immediately creates its hidden `cached_moderation_state`
field on every bundle that Content Moderation is already moderating. From then on
the field is added and removed automatically as you change which bundles your
workflows moderate — you never create it by hand.

## Back-fill existing content

New and edited entities cache their state automatically, but content that existed
*before* you installed the module has an empty cached value until you back‑fill it
once. Do this from the [Configuration](../configuration/index.md) form, or from the
command line:

```bash
drush cached-moderation-state:update-all
```

## Verify it worked

List the bundles the module is now managing:

```bash
drush cached-moderation-state:list-moderated-bundles
```

You should see entries like `node:article` for each moderated bundle.
