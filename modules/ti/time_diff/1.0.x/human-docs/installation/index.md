# Installation

## Requirements

Time Diff is deliberately tiny. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules, no PHP libraries, and no third-party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/time_diff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/time_diff -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en time_diff -y
```

That is all it takes. The `time_diff` Twig filter is immediately available in
every template.

## Verify it worked

Add `{{ '2023-01-01'|time_diff }}` to any template (or a test block that renders
Twig) and reload the page. You should see a relative phrase such as "2 years ago"
rather than the raw date.
