# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`sebastian/diff`** PHP library (`^3 || ^4 || ^5 || ^6`) — Composer pulls
  this in automatically when you require the module.

There are no dependent Drupal modules for the base module. (The optional Git‑host
submodules, if you use them, have their own requirements.)

## Install with Composer

From the project root:

```bash
composer require drupal/config_patch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, and it's what pulls in the `sebastian/diff` library the
module uses to build diffs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_patch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_patch -y
```

## Optional: Git‑host submodules

Config Patch's output is pluggable. If you want to push patches directly to a
hosted Git provider as a pull/merge request rather than copying the diff by hand,
there are separate contrib modules that add output plugins for that — for example
`config_patch_gitlab`, `config_patch_github_api`, `config_patch_gitea`, and
`config_patch_azure_api`. Require and enable whichever matches your host, then pick
it as the output plugin (see [Configuration](../configuration/index.md)).

## Verify it worked

After enabling, visit **Configuration → Development → Configuration
synchronization** — you should see a new **Patch** tab alongside *Synchronize*.
The admin toolbar should also show a small widget with the count of config items
that differ from what's on disk.
