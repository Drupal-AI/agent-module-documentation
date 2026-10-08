# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other module dependencies.
- No separate external library to download — easepick itself is dependency‑free and
  is integrated by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/easepick -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easepick -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easepick -y
```

## Verify it worked

There's no admin page to check. Add the `easepick` value flag to a form element (see
the [overview](../index.md)), then load that form: the date input should render with
the easepick calendar interface instead of the default widget.
