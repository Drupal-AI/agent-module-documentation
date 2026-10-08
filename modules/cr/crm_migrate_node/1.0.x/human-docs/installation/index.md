# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drupal CRM** (`drupal/crm`) — the destination for the migrated contacts.
- **Migrate Plus** (`migrate_plus`) — the migration engine this module builds on.

Both dependencies must be installed and enabled. If you want the optional Simpsons
demo recipe (`crm_migrate_node_simpsons`), it additionally needs the **Name**,
**Telephone**, and **Address** modules. **Migrate Tools** is recommended if you
would like to run and manage migrations from the admin UI rather than only Drush.

## Install with Composer

From the project root:

```bash
composer require drupal/crm_migrate_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm_migrate_node -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crm_migrate_node -y
```

If CRM or Migrate Plus are not yet enabled, install them first (for example
`drush en crm migrate_plus -y`) or let Composer and Drush resolve them alongside
this module.

## Verify it worked

Log in as an administrator, grant yourself the **Administer Node to CRM migration**
permission at **People → Permissions**, then visit **Configuration → CRM → Node to
CRM Migration**. You should see the migration builder with an **Add migration**
button. From here, follow the "How to use it" steps in the
[overview](../index.md).
