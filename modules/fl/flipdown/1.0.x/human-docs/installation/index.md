# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — part of standard installs and enabled
  automatically as a dependency.
- A **Date** or **Datetime** field to format. To use the Views plugin you will also
  want core's Views module.

There are no third-party Composer or PHP library requirements — the FlipDown
front-end is bundled and dependency-free (no jQuery).

## Install with Composer

From the project root:

```bash
composer require drupal/flipdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flipdown -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flipdown -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a date field)* → Manage
display**. Open the **Format** dropdown for the Date/Datetime field — **FlipDown**
should be listed. Select it and view a node with a future date to see the
countdown animate.
