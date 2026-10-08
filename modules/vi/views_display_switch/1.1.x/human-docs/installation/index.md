# Installation

## Requirements

Views Display Switch is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Views is part of Drupal core.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_display_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_display_switch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_display_switch -y
```

That's all it takes. There is no required configuration and no admin settings
page. Everything is configured per view — see the [overview](../index.md) for how
to add the *Display switch* area to a view's header or footer.
