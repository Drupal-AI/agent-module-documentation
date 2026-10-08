# Installation

## Requirements

Viewfield needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Views** (`views`) and **Field** (`field`) modules enabled. These are
  part of Drupal core and are enabled automatically as dependencies.

This is a **beta** release, so test it before relying on it in production. There
are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/viewfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/viewfield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en viewfield -y
```

There is no required configuration and no settings form of its own — you use the
module by adding a Viewfield to a bundle.

## Submodules

Viewfield ships **no submodules**.

## Verify it worked

Go to a content type's **Manage fields** page (*Structure → Content types → (a
type) → Manage fields*) and click **Add field**. You should see **Viewfield** in
the field type list under *Field types*.
