# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** (`language`) and **Content Translation**
  (`content_translation`) modules — enabled automatically as dependencies.
- The **stichoza/google-translate-php** library, installed automatically when you
  require the module with Composer.
- No modules outside Drupal core are required.

## Install with Composer

From the project root:

```bash
composer require drupal/global_node_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`stichoza/google-translate-php` library and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/global_node_translation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en global_node_translation -y
```

Drupal will enable the core Language and Content Translation modules automatically.

## Verify it worked

Go to **Administration → Extend**, find **Global Node Translation**, and confirm it
has a **Configure** link. Opening it should show the settings form where you select
target languages — continue with [Configuration](../configuration/index.md).
