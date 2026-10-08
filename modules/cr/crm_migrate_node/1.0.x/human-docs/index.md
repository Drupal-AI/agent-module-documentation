# Node Migration to CRM — manual setup guide

**Node Migration to CRM** (`crm_migrate_node`) moves your existing node content
into **Drupal CRM** contact entities. If your site has been collecting people's
details as nodes — members, applicants, event registrants, and so on — and you
have adopted Drupal CRM to manage them properly, this module bridges the two: it
reads a chosen content type and creates matching CRM contacts, mapping each node
field onto the corresponding contact field.

It builds on **Migrate Plus**, so the migrations it creates are ordinary Drupal
migrations. They appear in the standard Migrate tooling and you run them the usual
way — from the admin UI or with Drush (`drush migrate:status`,
`drush migrate:import`). What this module adds on top is a friendly web UI for
*defining* those migrations and mapping fields (including name components,
addresses, and contact methods such as emails and telephones) without hand-writing
migration YAML.

This module needs configuration before it does anything — enabling it simply makes
the migration-builder UI available. You then create one or more migrations, map the
fields, and run them. It depends on **Drupal CRM** (`crm`) and **Migrate Plus**
(`migrate_plus`), and it defines a permission, *Administer Node to CRM migration*,
that controls who may use the builder.

A word of caution: node content often contains **personal data**, and this module
turns that data into CRM contact records. Make sure each mapping is intentional and
that you handle the resulting personal data in line with your privacy policy —
migrations are powerful, so run and review them carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm CRM and Migrate Plus are present.

There is no traditional settings form to fill in. Setup happens in the
migration-builder UI described under "How to use it" below.

## Where it lives in the admin menu

Once enabled, the builder lives at **Configuration → CRM → Node to CRM Migration**.
You need the *Administer Node to CRM migration* permission to reach it (grant it at
**People → Permissions**).

## How to use it

1. Make sure **CRM** and **Migrate Plus** are installed and enabled (see
   [Installation](installation/index.md)). For full name and contact-method support
   on your nodes and CRM contacts, the CRM ecosystem modules (Name, Telephone,
   Address) are recommended, and Migrate Tools is handy if you want to run
   migrations from the admin UI.
2. Grant the **Administer Node to CRM migration** permission to the roles that
   should build migrations.
3. Go to **Configuration → CRM → Node to CRM Migration** and click **Add
   migration**. Choose the source node (content) type and the destination CRM
   contact type, then save to create the migration.
4. Open the new migration's tab to edit it and map node fields onto CRM contact
   fields — name components, addresses, and contact methods (emails, telephones,
   addresses).
5. Run the migration from **Manage → Migrate**, or with Drush:
   `drush migrate:status` to check it, then `drush migrate:import <migration_id>`
   to run it. Review the results carefully before relying on them.

> **Sample data:** the module ships an optional Drush command
> (`crm-migrate-node:generate-simpsons-recipe`, alias `cmnsr`) and a demo recipe
> (`crm_migrate_node_simpsons`) that generate Simpsons sample content, useful for
> trying the workflow. The demo recipe also depends on the Name, Telephone, and
> Address modules.
