# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Discovery** (`layout_discovery`) and **Field UI** (`field_ui`)
  modules — both ship with Drupal and are pulled in automatically as dependencies.
- No third‑party Composer packages or PHP libraries.

> **Do not use alongside Display Suite.** Display Layout is a fresh, minimalist
> reimplementation of the same idea; its configuration does not map to Display
> Suite, so a single site should use one or the other, not both.

## Install with Composer

From the project root:

```bash
composer require drupal/display_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/display_layout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en display_layout -y
```

Layout Discovery and Field UI will be enabled as dependencies if they are not
already.

## Verify it worked

Go to any content entity's **Manage display** form (for example **Structure →
Content types → *(type)* → Manage display**) and look for the **Display layout
settings** section at the bottom. If it is there, the module is working — choose a
layout and start sorting fields into its regions.
