# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`) — the only dependency,
  enabled automatically with this module.
- To get any visible benefit you will also want **Layout Builder** enabled on the
  displays where you use these sections, since the class dropdowns appear in the
  Layout Builder section-configuration UI.

There is no PHP version requirement and there are no third-party Composer
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_section_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_section_classes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_section_classes -y
```

The module does nothing on its own — it only activates for layouts that declare a
`classes:` key in their `*.layouts.yml`. After adding that key (see
[the index page](../index.md)), run `drush cr` so the new layout definition is
picked up. There is no configuration form.

There are no submodules.
