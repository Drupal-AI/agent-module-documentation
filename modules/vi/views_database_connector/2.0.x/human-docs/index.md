# Views Database Connector — manual setup guide

**Views Database Connector** (`views_database_connector`, often shortened to VDC)
lets Drupal's Views see the tables of *any* extra database you've connected in
`settings.php` — a legacy MySQL database, an external CRM or reporting database, a
SQLite dataset, a PostgreSQL or SQL Server system, and so on. That means you can
build a normal View over external or legacy data, with fields, filters, sorts, and
arguments, without writing a single line of custom `hook_views_data()` code.

Once enabled, VDC introspects each database it's allowed to see, figures out each
table's columns and their data types (numeric, date, string, boolean), and
registers every table as a Views base table. In the Views UI these appear in the
**Show** list prefixed like `[VDC] legacy: orders`. From there you build the View
just as you would over Drupal content.

Which databases and tables get exposed is controlled two ways: a settings form with
a checkbox per connection, and an optional allow-list in `settings.php` that limits
VDC to specific named tables.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Views Database Connector**
(`/admin/config/development/views_database_connector`). It requires the **Administer
site configuration** permission. The View-building itself happens in the normal
Views UI under **Structure → Views**.

## How to use it

### Step 1 — Define the extra database in settings.php

VDC only sees connections Drupal already knows about, so first add the database the
normal Drupal way in `sites/default/settings.php`:

```php
$databases['legacy']['default'] = [
  'driver'   => 'mysql',
  'database' => 'legacy_db',
  'username' => '...',
  'password' => '...',
  'host'     => '...',
  'prefix'   => '',
];
```

Supported drivers are **MySQL**, **SQLite**, **PostgreSQL**, and **SQL Server**
(`sqlsrv`/`odbc`). Any other driver returns no tables.

### Step 2 — Choose which connections VDC exposes

Go to **Configuration → Development → Views Database Connector**
(`/admin/config/development/views_database_connector`). The form lists a checkbox for
each database connection Drupal knows about; tick the ones you want Views to see and
save.

> **Important default — non-default databases are exposed automatically.** The main
> Drupal (`default`) database is *opt-in*: it stays hidden from Views unless you
> explicitly enable it. But any **other** connection is *opt-out* — the moment it
> appears in `settings.php` its tables become buildable into Views, even before you
> visit this form, until you uncheck it and save. If the external data is sensitive,
> review this before anyone builds a public (anonymous-visible) View over it.

After changing database configuration, the module's README suggests running `drush
cr` and toggling the module off and on again so Views rebuilds its data.

### Step 3 (optional) — Restrict to specific tables

To limit VDC to only certain tables of a connection, add an allow-list in
`settings.php`. When set for a connection, VDC exposes **only** the listed tables:

```php
$settings['vdc_allow']['legacy'] = ['orders', 'customers'];
// For the Drupal database itself, use the key "default":
$settings['vdc_allow']['default'] = ['watchdog'];
```

A connection that isn't mentioned in `vdc_allow` is unrestricted (all its tables are
exposed), so the allow-list only takes effect where you set it.

### Step 4 — Build the View

Create a new View (**Structure → Views → Add view**). In the **Show** dropdown pick
the entry prefixed `[VDC]` for the table you want. VDC adds the table's first column
as the initial field; add the rest with **Add**, and use the auto-detected column
types to add numeric/date/string/boolean filters, sorts, and arguments.

### Rendering a string column as HTML

String columns use VDC's own field handler, which has a **Render as HTML** option
(off by default). Leave it off for plain, escaped text. Turn it on only if you trust
the source data — even then, values are still run through Drupal's XSS filter, so it
is not raw-HTML injection.

### Joining two external tables

VDC doesn't create relationships automatically, but it ships a relationship plugin
you can wire up with a tiny custom module implementing `hook_views_data_alter()`.
See the [`agent/`](../agent/start.md) docs for the exact code.
