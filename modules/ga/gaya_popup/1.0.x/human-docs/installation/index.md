# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- Core modules **Field**, **User**, and **System** — all part of core and enabled
  automatically as dependencies.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gaya_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gaya_popup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gaya_popup -y
```

## Verify it worked

Log in as an administrator and confirm **Gaya Popup Module** appears as enabled on
the **Extend** page (`/admin/modules`). You can then author your popup content and
display options, and visit a front‑end page to confirm the modal appears.
