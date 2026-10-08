# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher**.
- Core's **User** module (`user`), which is part of a standard Drupal install and is
  pulled in automatically as a dependency.

There are no third-party Composer or PHP library requirements. Note that the
project's security advisory coverage is marked **not covered** at this version, so
review your own risk posture before using it on a high-value production site.

## Install with Composer

From the project root:

```bash
composer require drupal/pinterest_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinterest_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinterest_widget -y
```

## Verify it worked

Go to **Configuration → Services → Pinterest Widget**
(`/admin/config/services/pinterest-widget`) and confirm the settings form loads.
Then head to **Structure → Block layout** and confirm the four Pinterest block
types (Pin, Board, Profile, Follow) appear in the "Place block" list. Both are good
signs the module is installed and ready to configure.
