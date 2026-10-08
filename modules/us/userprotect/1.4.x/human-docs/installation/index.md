# Installation

## Requirements

User Protect depends only on Drupal core:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), enabled automatically as a dependency.

There are no third-party Composer packages or other contributed modules required.
(It integrates with the Role Delegation module if that is present, but does not
require it.)

## Install with Composer

From the project root:

```bash
composer require drupal/userprotect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/userprotect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en userprotect -y
```

## Next steps

After enabling, grant the **Administer user protection rules** permission to your
site administrators, then create your first rule at **Configuration → People →
User protect** — see [Configuration](../configuration/index.md).

There are no submodules.
