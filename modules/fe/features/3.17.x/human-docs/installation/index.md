# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Config** module (enabled automatically).
- The contributed **Config Update** module (`drupal/config_update`, `^2`), used for
  diffing and reverting configuration. Composer installs it for you.

No third‑party Composer packages or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/features -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Config Update and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/features -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en features -y
```

Config Update is enabled automatically as a dependency.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Features UI** | `features_ui` | The admin screens at *Configuration → Development → Features* for creating, editing, and reviewing feature packages. Optional — the base module works from Drush alone. Handy on a build/dev site; you can leave it disabled in production. |

To enable the UI:

```bash
drush en features_ui -y
```

## Verify it worked

Confirm the module is enabled and the Drush commands are available:

```bash
drush features:status
```

This reports the active bundle and enabled assignment methods. If you enabled the
Features UI, you can also visit **Configuration → Development → Features**
(`/admin/config/development/features`) to see the packaging screens.
