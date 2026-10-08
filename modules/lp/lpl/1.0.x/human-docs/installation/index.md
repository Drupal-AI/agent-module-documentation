# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- To be useful, a **multilingual** site — more than one installed language. The
  module doesn't declare a hard dependency on the Language or Content Translation
  modules, but with only one language it has nothing to vary.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lpl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lpl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lpl -y
```

There is no configuration step of its own — the per‑language logo fields appear on
the theme settings form (see the [overview](../index.md)).

## Verify it worked

Go to **Appearance → Settings** (`/admin/appearance/settings`). In the logo
settings you should now see a separate logo field for each installed language. Set
a distinct logo for two languages, then switch the site language and confirm the
logo changes accordingly.
