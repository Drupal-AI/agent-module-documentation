# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency (it is on for virtually every site already).

There are no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/file_replace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_replace -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_replace -y
```

After enabling, grant the **Replace files** permission to the roles that should be
able to replace files:

```bash
drush role:perm:add editor 'replace files'
```

## Submodule — optional post-replace shell command

File replace ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **File replace shell exec** | `file_replace_shell_exec` | Runs a configurable shell command after each file replacement — handy for re-optimizing an asset, syncing to a CDN, or invalidating an external cache. |

Enable it only if you need that behavior:

```bash
drush en file_replace_shell_exec -y
```

It requires the base File replace module, which is already present once you have
installed it above.

The base module has no configuration form. See the [overview](../index.md) for the
ways to reach the Replace UI.
