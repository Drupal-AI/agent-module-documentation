# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- **Drush**, since the module's whole purpose is a pair of Drush commands.

There are no other module, Composer, or PHP library requirements. Note this module
is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/rmkv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rmkv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rmkv -y
```

## Verify it worked

Confirm the Drush commands are available:

```bash
drush list | grep rmkv
```

You should see `rmkv:check` and `rmkv`. From here, see the "How to use it" section
of the [overview](../index.md) — and remember to **back up your database** before
removing any schema entry.

> **Enable it only when you need it.** Because this is a recovery tool rather than a
> site feature, many operators enable it, resolve the orphaned entry, and then
> uninstall it again.
