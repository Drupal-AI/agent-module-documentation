# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** module (`link`) — the only dependency, enabled automatically.

There are no third‑party libraries or extra dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/link_field_display_mode_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_field_display_mode_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_field_display_mode_formatter -y
```

## Verify it worked

On a bundle with a Link field, open **Manage display** and confirm the **Link Field
Display Mode Formatter** appears in the format list. Choose it, pick a view mode,
save, and view a piece of content to see the entity rendered inside the link.
