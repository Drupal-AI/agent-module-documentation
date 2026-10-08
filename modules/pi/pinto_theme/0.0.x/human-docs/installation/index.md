# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- The **Pinto** framework at the code level — Pinto Theme Helper builds on Pinto's
  component system, so install [`pinto`](https://www.drupal.org/project/pinto)
  alongside it. Composer resolves the Pinto library automatically.
- Pinto's PHP 8.2+ requirement applies in practice, since the helper is used together
  with the Pinto component system.

## Install with Composer

From the project root:

```bash
composer require drupal/pinto_theme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Pinto library) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinto_theme -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinto_theme -y
```

## Verify it worked

Pinto Theme Helper has no UI. Confirm success in code: build a theme component with
Pinto, clear the cache (`drush cr`), and confirm it renders as expected in your
theme. See the [official documentation](https://www.drupal.org/project/pinto_theme)
for a worked example of building a full Pinto-based theme.
