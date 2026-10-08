# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/browser_back_button
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/browser_back_button`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en browser_back_button -y
```

Once enabled, place the **"Browser Back Button Block"** through **Structure → Block
layout** and configure its text or image — see [the overview](../index.md).
