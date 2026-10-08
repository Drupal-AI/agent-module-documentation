# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Auto Node Translate** module (`auto_node_translate`) — this is a provider
  plugin for it and does nothing on its own.
- A **Google Cloud** account with a project, the **Cloud Translation API**
  enabled, and a service account that has translation access. You generate a
  JSON key for that service account and upload it in the module's settings.
- The official **Google Cloud PHP SDK**, pulled in automatically when you install
  via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_node_translate_google -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Auto Node Translate and the Google Cloud SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_node_translate_google -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_node_translate_google -y
```

This also enables `auto_node_translate` if it is not already on.

## Before you configure it

- Make sure Drupal's **private filesystem** is configured and protected — the
  module stores the uploaded Google service-account JSON there.
- Have your Google Cloud project id, location (for example `global`), and the
  service-account JSON key file ready.

Then continue to [Configuration](../configuration/index.md).
