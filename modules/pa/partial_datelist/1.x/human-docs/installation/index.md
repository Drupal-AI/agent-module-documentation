# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`).
- Core's **Datetime** module (`datetime`) — enabled automatically as a dependency,
  since Partial Datelist works on its Select list widget.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/partial_datelist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/partial_datelist -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en partial_datelist -y
```

## Verify it worked

Go to a content type's **Manage form display**, find a Datetime (or Datetime
Range) field set to the **Select list** widget, and open its settings. You should
now see options to hide specific date/time parts. Hide one (say, seconds), save,
and check the node add/edit form — that dropdown should be gone.

> **Upgrading from 1.0.x?** Run `drush updb` (or `update.php`) right after
> deploying 1.1.x, or the site may error out on a cached reference to removed
> functions until the update runs.
