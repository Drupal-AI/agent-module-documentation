# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

That's the only requirement — Flexible permissions has **no other module
dependencies** and no third‑party libraries.

## Install with Composer

Most of the time you won't install this module by hand: a consumer module (such
as **Group**) declares it as a dependency, and Composer brings it in
automatically. If you do need to add it directly, from the project root:

```bash
composer require drupal/flexible_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flexible_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexible_permissions -y
```

There is nothing to configure afterward — no settings form, no permissions, and
no submodules. The module simply provides the permission‑calculation services
that a consumer module builds on.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep flexible_permissions
```

Beyond that there's no visible change to check — Flexible permissions only takes
effect through the modules that consume its API.
