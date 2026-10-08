# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Text** module (`text`) — enabled automatically as a dependency.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/substr_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/substr_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en substr_formatter -y
```

## Verify it worked

Go to a content type's **Manage display** tab (**Structure → Content types → *your
type* → Manage display**) and, on a string field, open the format drop-down. The
**Substr** formatter should now be listed. See the [main guide](../index.md) for how
to set its offset and length.
