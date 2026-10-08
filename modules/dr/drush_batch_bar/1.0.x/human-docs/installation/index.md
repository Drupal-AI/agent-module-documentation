# Installation

## Requirements

- **PHP 8.4 or higher** (`php: >=8.4`). This is the binding constraint — it is
  why the module needs the core versions below.
- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`), which
  are the core releases that support PHP 8.4.
- **Drush 12 or 13**, depending on your Drupal version.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_batch_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_batch_bar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_batch_bar -y
```

## Submodules

Drush Batch Bar ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Drush Batch Bar Example** | `drush_batch_bar_example` | Runnable implementation examples, including the `drush drush-batch-bar` command (alias `dbb`). Enable it to see the progress bar and output patterns before writing your own command, then use it as a template. |

Enable it with:

```bash
drush en drush_batch_bar_example -y
```

## Verify it worked

Enable the example submodule and run its demo command:

```bash
drush dbb
```

If you see a Symfony Console progress bar advance in your terminal followed by a
concise summary, the module is installed and working. See the
[main guide](../index.md) for how to use it in your own Drush commands.
