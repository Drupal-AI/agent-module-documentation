# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`).
- Core's **Block**, **Field**, **Node**, and **Views** modules (enabled
  automatically as dependencies).
- A set of contrib modules that LocalGov Core depends on, installed automatically
  by Composer:
  - `drupal/field_group` (`^4.0`)
  - `drupal/image_widget_crop` (`^2.3 || ^3.0`)
  - `drupal/linkit` (`^6.1 || ^7.0`)
  - `drupal/media_library_edit` (`^3.0`)
  - `drupal/metatag` (`^2.0.2`)
  - `drupal/pathauto` (`^1.8`)
  - `drupal/role_delegation` (`^1.4`)
  - `drupal/token` (`^1.7`)

Composer resolves and installs all of these for you — there is no need to require
them individually.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_core -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in the full dependency set above and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/localgov_core -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_core -y
```

## Optional submodules

LocalGov Core ships four submodules — enable the ones you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **LocalGov Roles** | `localgov_roles` | The standard LocalGov editorial roles, plus the `hook_localgov_roles_default()` mechanism many modules use to grant default permissions. |
| **LocalGov Admin Role** | `localgov_admin_role` | An "is_admin" all-permissions LocalGov Admin role. |
| **LocalGov Media** | `localgov_media` | A media configuration bundle (media types, image styles, crop, Linkit config). |
| **LocalGov Admin Theme Improvements** | `localgov_admin_theme_improvements` | Admin-theme (Gin) CSS/JS tweaks. |

For example:

```bash
drush en localgov_roles localgov_media -y
```

## Next steps

Enabling the module makes its blocks, widgets, and shared fields available. See
[Configuration](../configuration/index.md) to place the Page Header block and use
the provided fields.
