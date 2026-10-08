# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Nothing else — no module dependencies, no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/themable_forms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/themable_forms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en themable_forms -y
```

That is all it takes. There is no configuration screen — enabling the module simply
makes the extra form-element and form-element-label theme suggestions available
site-wide, and attaches `#form_id` to every form element.

## Next steps

To actually change any markup, add Twig templates named after the suggestions you
want to your theme, then run `drush cr` so they are discovered. See the
[How to use it](../index.md#how-to-use-it) section for the template names and
workflow. There are no submodules.
