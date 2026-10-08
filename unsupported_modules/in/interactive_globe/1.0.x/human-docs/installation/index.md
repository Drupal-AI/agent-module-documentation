# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root — note the Composer package name is `drupal/iglobeblock`
(the project is *iglobeblock*), even though the module's machine name is
`interactive_globe`:

```bash
composer require drupal/iglobeblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iglobeblock -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `interactive_globe`:

```bash
drush en interactive_globe -y
```

## Verify it worked

Go to **Structure → Block Layout**, click **Place block** on any region, and
search for **Interactive Globe**. If it appears in the list, the module is
installed — place it, add your images and labels in the block settings, and save
to see the globe.
