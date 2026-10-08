# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module enabled (the tamper creates media entities).
- The **Tamper**, **Feeds**, and **Feeds Tamper** modules
  (`drupal/tamper`, `drupal/feeds`, `drupal/feeds_tamper`) — this tamper is used
  inside a Feeds import.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper_media_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_tamper_media_url -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_tamper_media_url -y
```

If they aren't already on, enable the modules this tamper relies on:

```bash
drush en media feeds feeds_tamper tamper -y
```

## Verify it worked

Open a Feed type's **Tamper** tab at **Structure → Feed types**
(`/admin/structure/feeds`). When you add a plugin to a source mapped to a media
reference field, **Create Media from URL** should appear in the list of available
tampers.
