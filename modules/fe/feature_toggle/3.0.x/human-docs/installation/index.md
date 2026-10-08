# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/feature_toggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feature_toggle -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feature_toggle -y
```

There are no submodules. After enabling, head to **Configuration → System → Feature
Toggle** to define your first feature — see
[Configuration](../configuration/index.md).

## Grant the permissions

Before editors can use the toggle screen, grant the relevant permission at **People
→ Permissions**:

- **Administer feature toggle** — create, edit, and delete features (and toggle
  them). Reserve this for site administrators.
- **Modify feature toggle status** — flip existing features on and off only. A safe
  permission to give trusted editors.

See [Configuration](../configuration/index.md#permissions) for more detail.
