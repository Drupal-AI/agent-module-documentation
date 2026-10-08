# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **ACL** module (`drupal/acl ^2.0`) — a hard requirement that provides the
  per‑user access‑list primitive Forum Access is built on. Composer pulls it in.
- The **Forum** feature:
  - On **Drupal 10**, forum is included in core.
  - On **Drupal 11 and newer**, forum has left core, so you must install the
    contributed **`drupal/forum`** project separately — otherwise enabling Forum
    Access will fail.

The module is covered by Drupal's security advisory policy. The
**forum_access_migrate** submodule (see below) is available if you are moving
settings from the Drupal 7 version.

## Install with Composer

From the project root:

```bash
composer require drupal/forum_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the **ACL** requirement automatically.

On **Drupal 11+**, also require the contributed forum project:

```bash
composer require drupal/forum -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forum_access -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forum_access -y
```

Make sure **ACL** and the **Forum** module are enabled as well (Drupal enables ACL
as a dependency; on D11+ enable the contributed forum module you required above).

## Submodules

- **Forum Access Migrate** (`forum_access_migrate`) — enable this only if you are
  migrating forum access settings from an older Drupal 7 site. It brings D7 Forum
  Access settings across to this version. New sites do not need it.

  ```bash
  drush en forum_access_migrate -y
  ```

## Verify it worked

Log in as an administrator and go to **Structure → Forums**
(`/admin/structure/forum`). Open a forum and you should now see the per‑forum
access grid where you can set which roles may view/post and who moderates it. If
that grid appears, Forum Access is installed — see
[Configuration](../configuration/index.md) to set it up.
