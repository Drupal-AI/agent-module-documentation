# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 ||
  ^11`).
- The **AJAX Dependency** module (`ajax_dependency`) — a hard dependency that lets
  the offered options react to other form values. Composer pulls it in
  automatically.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ersv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will also fetch the required `ajax_dependency`
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ersv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ersv -y
```

Drupal will enable `ajax_dependency` at the same time as a dependency.

## Verify it worked

Edit any **entity reference** field's settings (for example on a content type under
**Manage fields**). In the **Reference method** dropdown you should now see the
option provided by ERSV, with nested **selection** and **validation** handler
settings appearing once you choose it. If it's there, the module is installed and
ready to configure per field.
