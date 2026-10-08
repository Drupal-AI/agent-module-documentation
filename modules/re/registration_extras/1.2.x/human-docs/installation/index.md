# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No modules outside Drupal core, and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/registration_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/registration_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en registration_extras -y
```

## Verify it worked

Enabling the module changes nothing on its own until you set an option. Open the
Registration Extras settings form (see [Configuration](../configuration/index.md)),
change the submit-button label or set a redirect path, and save. Then visit your
site's registration page (`/user/register`) as an anonymous visitor to confirm the
button label and the after-registration redirect behave as you configured.
