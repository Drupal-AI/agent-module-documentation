# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Config Update** module (`drupal/config_update`, `^1.5 ||
  ^2.0@alpha`), which provides the config-diff machinery. Composer pulls it in.
- **Drush 12 or newer**, used as the **project-local** Drush
  (`vendor/bin/drush`) — the module conflicts with Drush older than 12.
- Two libraries pulled in automatically by Composer: **symfony/console**
  (`^6.2 || ^7.0`) and **chi-teck/drupal-code-generator** (`^3.0 || ^4.0`), which
  power the `drush generate` command.

## Install with Composer

From the project root:

```bash
composer require drupal/update_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Config Update, the
Symfony console, and the code generator as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/update_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en update_helper -y
```

This also enables `config_update` if it is not already on.

## Optional submodule — Update Helper Checklist

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Update Helper Checklist** | `update_helper_checklist` | Presents a checklist (via the contrib **Checklist API** module) of which configuration updates have been executed, so site owners can see what remains. Requires `drupal/checklistapi`. |

Enable it only if you want that checklist:

```bash
drush en update_helper_checklist -y
```

## Verify it worked

From your project, confirm the generator is available:

```bash
vendor/bin/drush generate | grep update_helper
```

You should see `update_helper:configuration-update` (alias `config-update`) in the
list. See the [overview](../index.md#how-to-use-it) for the generate-and-apply
workflow.
