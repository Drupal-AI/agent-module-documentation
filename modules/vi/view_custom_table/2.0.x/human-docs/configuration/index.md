# Configuration

Configuring Views Custom Table is a two-part job: first you **register** a database
table so Views knows about it, then you build a **View** over it like any other data
source. Everything starts at **Structure → Views → View Custom Table**
(`/admin/structure/views/custom_table`).

## Before you start

The table you want to expose must already **exist** in the database and must have a
**primary key**. If it lives in a database other than the site's default, that
connection must be defined in your `settings.php` `$databases` array — you register the
table against its connection key. Any column you later want to use as a relationship to
an entity or another table must be **numeric**.

## Register a table

1. Go to **Structure → Views → View Custom Table**
   (`/admin/structure/views/custom_table`) and choose **Add**.
2. Pick the **database** (its connection key — `default` for the main database, or the
   key of a secondary connection) and enter the **table name**. The form checks that
   the table actually exists in that database and is not already registered.
3. Give it a **description** — a human label shown in the admin listing so you can tell
   your registered tables apart.
4. Optionally declare **column relations** now (you can also do this later via **Edit
   Table Relations**). For each numeric column that references something, choose the
   target: a Drupal entity type (node, user, taxonomy_term, file, …) or another
   registered custom table.
5. Save. The registration is stored in configuration.

## Rebuild Views data

After adding or changing a registration, **clear the site caches** (`drush cr`, or
**Configuration → Development → Performance → Clear all caches**) so Views rebuilds its
data and your table appears as a new base table. Until you do this, the table will not
show up when you create a View.

## Edit table relations

Use the **Edit Table Relations** operation on a registered table to map its numeric
columns to entities or to other custom tables. Declaring a relation adds a Views
relationship (and a reverse relationship the other way), so that inside a View you can:

- join a foreign-key column to the **Node** or **User** entity and pull in that
  entity's fields, or
- join two custom tables that live in the **same** database to each other.

A table in a non-default database can only relate to other tables in that same
database.

## Build a View over the table

Once the table is registered and caches are cleared:

1. Go to **Structure → Views** (`/admin/structure/views`) and add a new View.
2. When choosing what the View shows, pick your registered custom table as the base
   table.
3. Add fields, filters, sorts, and arguments as usual — numeric columns get numeric
   handlers, text columns get string handlers, and **date/time columns** are handled
   by the module's own date handler, so you can format them with standard Drupal date
   formats.
4. If you declared column relations, add the corresponding **relationship** in the
   View to bring in the related entity's or table's data.
5. Choose a display (page, block, or an export format such as CSV, JSON, or RSS) and
   save.

## What gets stored

Registrations are saved in the `view_custom_table.tables` configuration object, keyed
by table name, recording the table name, its database connection key, the description,
the column relations, and the UID of whoever created it. Because it is configuration,
you can export and deploy registrations across environments with Drupal's
configuration sync. For the exact stored shape and the column-to-handler mapping, see
the [`agent/`](../agent/start.md) docs.
