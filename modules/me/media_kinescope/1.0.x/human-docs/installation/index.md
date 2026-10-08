# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Media** module enabled (Drupal enables it automatically as a
  dependency).

There are no third‑party Composer or PHP library requirements. Videos are embedded
directly from Kinescope by URL, so no Kinescope API key is needed for basic
embedding.

## Install with Composer

From the project root:

```bash
composer require drupal/media_kinescope -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_kinescope -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_kinescope -y
```

## Verify it worked

Add a **Kinescope Video URL** field to a content type (under **Manage fields**),
set its widget to **Kinescope video** on **Manage form display**, and its formatter
on **Manage display**. Create a piece of content, paste in a Kinescope video URL,
and confirm the iframe player renders when you view the content.
