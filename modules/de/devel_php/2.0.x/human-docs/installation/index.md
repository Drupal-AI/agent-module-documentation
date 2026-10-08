# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`).
- The **Devel** module (`drupal/devel` `>=5.2`), which Devel PHP depends on for its
  dumper service. Composer pulls it in automatically, and Drupal enables it as a
  dependency.

There are no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also ensures a compatible version of Devel.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_php -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_php -y
```

This also enables Devel if it is not already on. There is no configuration form and
no submodules.

## Grant the permission (carefully)

The Execute PHP page does nothing until a role holds the **Execute php code**
permission. Because that permission is equivalent to full server access, grant it
only to a single trusted developer role, and only on a development environment —
**never** on production:

```bash
drush role:perm:add developer 'execute php code'
```

Then use the feature as described in the [overview](../index.md).

> **Removing it from production:** the safest posture is to not install Devel PHP on
> production at all. If it is present, make sure no role holds `execute php code`
> there.
