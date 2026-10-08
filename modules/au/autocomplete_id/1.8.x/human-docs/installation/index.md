# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`)
  — a single codebase across all four majors.
- No third-party PHP libraries and no dependencies on other modules — it builds
  directly on core's entity autocomplete.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autocomplete_id -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_id -y
```

## Verify it worked

- Go to **Structure → *(a content type)* → Manage form display** and confirm that
  an entity reference field can be switched to the **Autocomplete match ID**
  widget.
- Or open the settings form at **Configuration → Content authoring → Autocomplete
  ID** (`/admin/config/content/autocomplete-id`) and confirm the global toggle is
  present.

Enabling the module alone changes nothing yet — you still need to either select the
widget on a field or turn on the global toggle, and grant the viewing permission.
See [Configuration](../configuration/index.md) for those steps.
