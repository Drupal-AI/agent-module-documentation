# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **Media** (`media`).
- The **Media Entity Download** module
  ([`media_entity_download`](https://www.drupal.org/project/media_entity_download)),
  which provides the downloadable‑media links the feed uses.

Composer resolves the contributed dependency for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/eplikt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Media Entity Download alongside e-Plikt.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eplikt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eplikt -y
```

Drupal will enable Media and Media Entity Download too if they aren't already on.

## Verify it worked

Go to **Configuration → Web services → e-Plikt**
(`/admin/config/services/eplikt`) and confirm the settings page loads. Once you have
entered a publisher identifier and enabled at least one source (see
[Configuration](../configuration/index.md)), the RSS feed becomes available for the
receiving institution to harvest.
