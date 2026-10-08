# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third‑party PHP libraries.
- **Optional:** the [Redirect](https://www.drupal.org/project/redirect) module.
  If you install it and use the path check, set
  `$settings['fast404_respect_redirect'] = TRUE` so path checking honors your
  redirects.

## Install with Composer

From the project root:

```bash
composer require drupal/fast_404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. Note the Composer package is `drupal/fast_404` (with the
underscore), matching the project name.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fast_404 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The machine name is `fast404`, not `fast_404`:

```bash
drush en fast404 -y
```

That alone activates the static‑file **extension check** with safe defaults — no
`settings.php` edits required. There are no submodules.

## Next step

To turn on dynamic‑path checking, custom error pages, `410 Gone` responses, or
whitelisting, add `$settings['fast404_*']` keys to `settings.php` — see
[Configuration](../configuration/index.md).
