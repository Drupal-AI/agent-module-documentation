# CRM Migrate CRM Core — manual setup guide

**CRM Migrate CRM Core** (`crm_migrate_crm_core`) provides the migration path from the
old Drupal 7 **CRM Core** system into the modern Drupal
[CRM](https://www.drupal.org/project/crm) module on Drupal 10 or 11. If you are
upgrading a Drupal 7 site that ran CRM Core, this module brings your **contacts** and
**relationships** forward — reading them from the legacy database and recreating them as
`crm_contact` and `crm_relationship` entities on your new site.

It is built on Drupal's Migrate API together with Migrate Plus. Under the hood it ships
source plugins that read the D7 `crm_core_contact`, contact-name, and relationship tables
using safe, parameterized queries, and process plugins that translate CRM Core contact
types and relationship types into their Drupal CRM equivalents. It also includes a Drush
command set — including a fixture generator that can build CRM Core–style test data from
the same CSV files the CRM project uses (such as the Simpsons demo data), which is handy
for testing the migration before you run it for real.

The workflow has three parts: point the site at your Drupal 7 database as a migrate
source, map your CRM Core contact types to Drupal CRM bundles on the module's admin form,
then run the migrations with Drush. Contacts migrate first; relationships depend on the
contacts and migrate second.

The module requires the **CRM** module, core **Migrate**, and **Migrate Plus**, plus
read access to the Drupal 7 database. It supports Drupal 10 and 11 and provides an
admin-gated configuration form. This module does not replace CRM Core — it is purely the
bridge from CRM Core to the CRM module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, and connect the
   Drupal 7 source database.
2. [Configuration](configuration/index.md) — map CRM Core contact types to Drupal CRM
   bundles before running the migration.

## Where it lives in the admin menu

The bundle-mapping form is at **Configuration → Development → CRM Migrate CRM Core bundle
mapping** (`/admin/config/development/crm-migrate`), available to users with the
**Administer CRM Migrate CRM Core** permission. The migrations themselves are run from
the command line with Drush.

## How to use it

Once the module is installed, the source database is connected
([Installation](installation/index.md)), and the bundle mapping is set
([Configuration](configuration/index.md)), run the migrations with Drush:

```bash
drush migrate:import crm_core_contact
drush migrate:import crm_core_relationship
```

Migrate contacts first, then relationships (relationships depend on the contacts). If the
migrations do not appear in `drush migrate:status`, import the migration config first:

```bash
drush config:import --partial --source=web/modules/contrib/crm_migrate_crm_core/config/install
```

The **Migrate Tools** module (with Drush) is recommended for running and managing the
migrations. Because it re-keys records by their original contact id, the migration can be
re-run idempotently.
