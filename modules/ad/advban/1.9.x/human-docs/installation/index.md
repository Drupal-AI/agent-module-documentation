# Installation

## Requirements

Advanced Ban is lightweight and has no third-party dependencies:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other contrib modules are required. You do **not** need core's Ban module —
  Advanced Ban replaces it, and on install it will import any addresses that
  Ban had already blocked.

There are no additional Composer libraries or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/advban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advban -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advban -y
```

On install, Advanced Ban creates its own `advban_ip` database table and copies
any existing banned addresses from core's Ban module into it, tagged with the
reason "Migrated from Ban". If you were running core Ban, you can safely
uninstall it afterwards.

## Verify it worked

Log in as an administrator and go to **Configuration → People → Advanced Ban**
(`/admin/config/people/advban`). You should see the ban list and the "Add ban"
form. From here, head to [Configuration](../configuration/index.md) to add your
first ban or set your protected IP list.

> **Note:** Advanced Ban ships no default settings file, so immediately after
> enabling it the `advban.settings` config object does not exist yet. It is
> created the first time you save the Settings form (or the first time the
> module needs the default expiry durations). This is normal — you do not need
> to do anything about it.
