# Schema Viewer — manual setup guide

**Schema Viewer** (`schema_viewer`) is a lightweight developer tool that lets you
browse the structure of your site's database tables from inside the Drupal admin
interface. Type a table name into an autocomplete field and it shows you that
table's full schema — its fields, their data types, lengths, nullability, and
indexes — without opening a separate database client.

It solves a very specific problem: when you are building a custom module,
debugging a data issue, or trying to understand how Drupal maps an entity to its
storage, you often need to see exactly what columns a table has. Schema Viewer puts
that information one autocomplete lookup away. It is aimed at custom‑module
developers, site architects, and teams working with complex entity structures or
integrations.

The module works the moment you enable it — there is nothing to configure. It has
no settings form; it simply adds one admin page plus an **Access Schema Viewer**
permission you can grant to trusted roles. Because it exposes internal database
structure, it should be restricted to developers and administrators, not opened up
to general users. It depends only on core's **System** module and supports Drupal 9,
10, and 11.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the access permission.

## Where it lives in the admin menu

Once enabled, the tool lives at **Configuration → Development → Schema Viewer**
(`/admin/config/development/schema-viewer`).

## How to use it

Open the Schema Viewer page, then start typing a table name into the autocomplete
field — for example `node`, `users_field_data`, or any other table on your site.
Select the table and the page displays its schema: the field names, data types,
sizes, and constraints, along with its indexes. To control who can reach the page,
grant the **Access Schema Viewer** permission (under **People → Permissions**) to
the roles that should have it — typically administrators or developers — and keep it
away from untrusted users, since it reveals internal database structure.
