# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Query** module (`query`) — Kits depends on it and Drupal will enable it
  automatically as a dependency.

There are no third‑party PHP library requirements. Note that the 2.0.x branch is
a beta release (`2.0.0-beta4`), which is worth bearing in mind for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/kits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Query library
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kits -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kits -y
```

Enabling Kits will also enable the Query module it depends on. In practice, if
you installed Kits because another module (such as one from the Form Factory
family) requires it, that module's own installation will pull Kits in for you.

## Verify it worked

There is no UI to check. Confirm the module is enabled with:

```bash
drush pm:list --status=enabled | grep kits
```

If `kits` (and `query`) appear as enabled, the library is available for other
modules and custom code to use. There is nothing further to configure.
