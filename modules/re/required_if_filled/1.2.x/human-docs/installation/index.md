# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/required_if_filled -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/required_if_filled -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_if_filled -y
```

## Verify it worked

Go to **Configuration → Content → Required If Field Has Value**
(`/admin/config/content/required-if-filled`) and add a rule. Then open a matching
entity form, fill the source field, and try to save with the required field empty —
you should get a validation error. See the "How to use it" section of the
[overview](../index.md) for the full walkthrough.
