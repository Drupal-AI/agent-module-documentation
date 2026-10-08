# Installation

## Requirements

Navigation + is a Drupal 11-only foundation module with a small dependency stack:

- **Drupal 11** (`core_version_requirement: ^11`). It will not install on Drupal
  10 or earlier.
- Core's **Navigation** module (`navigation`) enabled.
- Two contrib dependencies: **`twig_events`** and **`tempstore_plus`**. Composer
  pulls these in for you when you require the module.

There are no additional PHP library requirements.

> **Tip:** In most projects Navigation + arrives as a dependency of
> **Layout Builder +** (`lb_plus`) or the wider "+ Suite" recipe. If you are
> setting up the page builder, requiring `lb_plus` (or the + Suite recipe) will
> bring Navigation + along automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed and pull in `twig_events` and `tempstore_plus`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/navigation_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation_plus -y
```

Drupal enables the `navigation`, `twig_events`, and `tempstore_plus` dependencies
at the same time.

## Submodules

The module ships one submodule, **`navigation_plus_entity_workflow`**, which is
**deprecated**. Its functionality has been folded into the main module and it will
be removed, so do **not** enable it on new sites.

## Verify it worked

Log in as a user with the **`use toolbar plus edit mode`** permission and open a
page that has an editing mode enabled. You should see the Navigation + toolbar and
be able to toggle Edit Mode. To confirm the admin surface, visit
**Configuration → Content authoring → Plus Suite**
(`/admin/config/content/plus-suite`) as an administrator.
