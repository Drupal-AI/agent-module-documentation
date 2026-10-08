# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed modules are required, and there are no third‑party
  Composer or PHP library dependencies.
- A working **site mail** setup so Drupal can actually send the one-time-code
  emails (the module sends through the standard mail system).
- A non-empty **`hash_salt`** in your `settings.php`. Standard Drupal installs
  already set this; if it's empty the settings form will warn you, and the
  module cannot generate the code hash without it.

## Install with Composer

From the project root:

```bash
composer require drupal/email_tfa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/email_tfa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_tfa -y
```

The module ships **off** — enabling it does not challenge anyone yet. Grant the
administration permission to whoever will manage it:

```bash
drush role:perm:add administrator 'administer email tfa'
```

Then head to [Configuration](../configuration/index.md) to turn the master
switch on and choose who gets challenged.

## Confirm the hash_salt prerequisite

Before turning 2FA on, make sure `settings.php` defines a non-empty
`$settings['hash_salt']`. The one-time code is hashed with this value, so without
it the flow cannot work. The settings form displays a warning if it is missing.

There are **no submodules**.
