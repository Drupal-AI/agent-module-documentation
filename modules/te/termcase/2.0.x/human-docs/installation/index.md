# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Taxonomy** (`taxonomy`) module, enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements. Termcase relies on
the standard taxonomy administration permissions and adds none of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/termcase -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/termcase`) matches the
module's machine name (`termcase`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/termcase -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en termcase -y
```

## Verify it worked

Edit any vocabulary under **Structure → Taxonomy** (`/admin/structure/taxonomy`).
On its edit form you should now see a **Term case settings** fieldset. Continue to
[Configuration](../configuration/index.md) to choose a case mode. The module ships
a Drush command for bulk conversion; run `drush list` and look for the `termcase`
command once the module is enabled.
