# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies, and no third‑party PHP or JavaScript libraries.
- Core's text‑format system (part of the Filter module, which ships with Drupal)
  — this is where you switch the filter on.

## Install with Composer

From the project root:

```bash
composer require drupal/current_year -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/current_year -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en current_year -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a text format, and confirm **Display
Current Year** appears in the list of filters. Enable it, then type `&year;` in
some content using that format and view it — the token should render as the current
year.
