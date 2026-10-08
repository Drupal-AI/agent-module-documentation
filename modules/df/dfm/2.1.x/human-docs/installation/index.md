# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **DFM Lite Library** — a small JavaScript library (around 100 KB) that ships
  with the module. If your build does not already include it, download it and
  place it where the module expects (see the module's README for the exact
  location). DFM's file-operation engine lives in this bundled library.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dfm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dfm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dfm -y
```

## Verify it worked

1. Log in as user 1 (the superuser), who always has the built-in **admin**
   profile.
2. Go to **Configuration → Media → Drupella File Manager**
   (`/admin/config/media/dfm`). You should see the settings form and the list of
   configuration profiles (DFM ships with `member` and `admin` profiles).
3. Visit `/dfm/public` to open the file manager against the public filesystem.

Remember that, by default, **only user 1 can reach the file manager**. To let
other roles in, create or adjust a profile and map it to a role — see
[Configuration](../configuration/index.md).
