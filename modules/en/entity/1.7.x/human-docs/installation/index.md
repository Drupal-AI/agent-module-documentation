# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No module dependencies, third‑party Composer packages, or PHP extensions are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In many cases the module is already present because another
project (such as Drupal Commerce or Profile) requires it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity -y
```

Because this is a pure API module, enabling it makes no visible change to the site.
It simply makes its handlers, route providers, and the Query Access API available
to modules and custom code that build on them.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled --filter=entity
```

Beyond that, there's nothing to click through — the module has no admin page. Its
effects appear only when a custom entity type is wired to use its permission
provider, access handler, or route providers, at which point the generated
permissions show up on **People → Permissions**.
