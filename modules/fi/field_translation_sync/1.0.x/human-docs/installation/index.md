# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Actions** (`action`) and **Content Translation** (`content_translation`)
  modules, which Drupal enables automatically as dependencies.
- A multilingual site (the Language module and configured languages) for the
  feature to be meaningful.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_translation_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_translation_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_translation_sync -y
```

## Verify it worked

Go to **People → Permissions** and confirm the module's synchronize permission is
listed; grant it to the appropriate roles. Then, on a translated entity, confirm
the synchronize action is available. See "How to use it" in the
[overview](../index.md) for the workflow.
