# Installation

> **Before you install:** the AddThis service this module depends on was
> discontinued on 31 May 2023 and the module is marked unsupported/obsolete. For a
> new site, install
> [AddToAny Share Buttons](https://www.drupal.org/project/addtoany) instead. The
> steps below are mainly useful for maintaining or removing an existing install.

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`). Note
  this release does not declare Drupal 11 support.
- No module dependencies beyond Drupal core.
- Built for the [YMCA Website Services / Open Y](https://www.drupal.org/project/openy)
  distribution, but runs standalone.

## Install with Composer

From the project root:

```bash
composer require drupal/openy_addthis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openy_addthis -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openy_addthis -y
```

Then place the **Open Y AddThis Block** from **Structure → Block layout**
(`/admin/structure/block`).

## Uninstalling cleanly

Because the module guards against uninstalling while share blocks are still in use
(via an uninstall validator), you must remove the placed block instances first:

1. Go to the prepare-uninstall form at **`/admin/modules/uninstall/openy-addthis`**
   (requires the *administer modules* permission) and use it to clean up the block
   instances.
2. Then uninstall the module:

```bash
drush pmu openy_addthis -y
```

Auditing where the block appears before you start makes this quicker — check the
placed block instances in Block layout.

## Verify it worked

After enabling, confirm the **Open Y AddThis Block** is available in **Structure →
Block layout**. (Remember that, with the AddThis service discontinued, the widget
itself will no longer render live share controls.)
