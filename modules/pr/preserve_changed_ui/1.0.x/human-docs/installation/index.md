# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`), which this module depends on — the checkbox is
  added to node edit forms. (Support for other entity types is tracked upstream but
  not yet available.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/preserve_changed_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/preserve_changed_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preserve_changed_ui -y
```

## Grant the permissions

At **People → Permissions**, assign:

- **`administer preserve_changed_ui configuration`** to whoever should manage the
  settings form.
- **`preserve_changed_ui allow preserve changed time`** to the editors who should
  be able to preserve the timestamp. Both permissions are restricted — grant the
  second one only to trusted editors, since it lets a save go unrecorded by
  everything that keys on the `changed` field.

## Verify it worked

Configure the default behaviour and the content types the checkbox applies to (see
[Configuration](../configuration/index.md)), then edit a node as a user who holds
the "allow preserve changed time" permission. You should see a checkbox near the
bottom of the form controlling whether the "Last saved" timestamp is preserved for
that save.
