# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Date Recur** (`date_recur`) — provides the Recurring Dates field type and
  recurrence rules.
- **Date Recur Modular** (`date_recur_modular`) — provides the modular recurrence
  widgets.
- **Replicate** (`replicate`) — performs the entity cloning that produces each
  instance.
- **Group** (`group`) — only if you use the optional **Entity Repeat Group**
  submodule.

There are no PHP library requirements. Composer will pull in Date Recur, Date
Recur Modular and Replicate for you with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_repeat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Date Recur and Replicate dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_repeat -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_repeat -y
```

## Submodules

- **Entity Repeat Group** (`entity_repeat_group`) — associates each generated
  instance with the original entity's Group. Enable it only if your site uses the
  contributed Group module:

  ```bash
  drush en entity_repeat_group -y
  ```

## Verify it worked

After enabling, add a Recurring Dates field to a bundle and set its widget to
**Entity Repeat** on the Manage form display screen (see the "How to use it"
section of the [overview](../index.md)). Then grant the Entity Repeat permissions
under **People → Permissions**. When a permitted user edits the entity, the
"generate" checkbox next to the Recurring Dates field confirms the setup is live.
