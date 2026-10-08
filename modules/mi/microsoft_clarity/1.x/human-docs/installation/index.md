# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- A **Microsoft Clarity account** and a project set up at
  [clarity.microsoft.com](https://clarity.microsoft.com/), which gives you a
  **project ID**.

There are no other Drupal module or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/microsoft_clarity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/microsoft_clarity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en microsoft_clarity -y
```

## Verify it worked

Set your project ID at **Configuration → Web services → Microsoft Clarity** (see
[Configuration](../configuration/index.md)). Then load a public page and check the
page source or your browser's network tab for the Clarity script; after a short
while, data should begin appearing in your Clarity dashboard.
