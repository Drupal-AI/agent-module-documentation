# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Google API key** with access to the Google Places API, and one or more
  **Place IDs** (see [Configuration](../configuration/index.md)).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/google_reviews_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note that the Composer package is
`drupal/google_reviews_slider`, but the module's machine name — the name you use
with Drush — is `google_reviews`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_reviews_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_reviews -y
```

## Verify it worked

Go to **Configuration → Web services → Review Settings**. If the settings form
loads, the module is installed — next, add your API key and place IDs as described
in [Configuration](../configuration/index.md).
