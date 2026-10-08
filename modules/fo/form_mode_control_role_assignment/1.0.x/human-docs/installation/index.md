# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Form Mode Control** module, which provides the alternate
  user‑registration form modes this module assigns roles for, plus the core
  **User** module (always present).
- At least one **user form mode** created and enabled for the registration form.

This module has no security‑advisory coverage and is described upstream as
minimally maintained with no further development planned — factor that in before
using it on a production site. There are no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/form_mode_control_role_assignment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_mode_control_role_assignment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_mode_control_role_assignment -y
```

Make sure **Form Mode Control** is also enabled and that you have created the
user form modes you intend to map.

## Verify it worked

Log in as an administrator and go to **Configuration → People → Form mode role
mapping** (`/admin/config/people/form-mode-role-mapping`). If you see a list of
your user form modes, each with a role selector, the module is installed. Next,
map each mode to a role — see [Configuration](../configuration/index.md).
