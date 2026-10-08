# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **Google Translate account** and a **Google credential JSON file** placed on
  your web server — the module uses Google's translation service to do the actual
  translating, and it authenticates with that credential file. Keep the file
  outside your web root and out of version control; treat it as a secret.
- Drupal's multilingual/content‑translation setup should be in place for the
  languages you plan to translate into.

There are no additional contributed‑module dependencies declared.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_translator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_translator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_translator -y
```

## Set up the Google credentials

Before you can run a translation, register with Google Translate and add your
Google credential JSON file to the web server as described in the module's help
page. Without valid credentials the translation action cannot reach Google and
will fail.

## Grant the permission

The module provides its own permission for running the bulk translation. Go to
**People → Permissions** and grant it to the roles that should be allowed to run
translations, then head to the module's action to translate a vocabulary (see the
[main guide](../index.md#how-to-use-it)).
