# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party libraries — this is a
standalone plugin API.

## Install with Composer

From the project root:

```bash
composer require drupal/date_augmenter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/date_augmenter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_augmenter -y
```

## What to install alongside it

On its own, Date Augmenter adds nothing visible — it needs two other pieces to do
anything:

1. **An augmenter-aware date formatter**, most commonly the contrib **Smart Date**
   module (`drupal/smart_date`), which exposes the augmenter controls on its
   formatter settings.
2. **One or more augmenter plugins** — the actual enhancements (Add to Calendar,
   Link, Content, AP Style) live in separate contrib modules. Install and enable
   whichever ones you want; they will appear in the augmenter list once enabled.

Until at least one augmenter-providing module is installed, the augmenter list is
empty. This module has no submodules of its own.
