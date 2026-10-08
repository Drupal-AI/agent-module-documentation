# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_stream -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_stream -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_stream -y
```

## Verify it worked

Go to a media type that has a **link** field, open its **Manage display** tab, and
confirm the HTML5 audio/video formatters appear in the format dropdown for that
field. Selecting one and viewing a media entity with a valid media URL should render
a working HTML5 player. The rest of the setup is in
[How to use it](../index.md#how-to-use-it).
