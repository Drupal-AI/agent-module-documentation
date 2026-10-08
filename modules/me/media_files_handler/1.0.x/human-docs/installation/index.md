# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Drupal core's **File** (`file`) and **Media** (`media`) modules, which Drupal
  enables automatically as dependencies.

There are no contributed‑module dependencies and no third‑party PHP libraries to
install. Note the module is under active development, so test its file‑handling
behaviour on a non‑production copy before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_files_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_files_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_files_handler -y
```

Core's File and Media modules are enabled automatically if they are not already
on.

## Verify it worked

There is no settings page to check — the module works automatically. To confirm the
behaviour, update a media entity by replacing its source file and verify that the
previously attached file is cleaned up (set to temporary, deleted, or moved to
private storage) rather than left behind as an orphan. See the
[main guide](../index.md) for the full lifecycle it manages.
