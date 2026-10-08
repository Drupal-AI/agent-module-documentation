# User CSV Import — manual setup guide

**User CSV Import** (`user_csv_import`) adds an **"Import users from CSV"** form to
the People admin page that creates a Drupal user account for each row of a CSV file
you upload. It's the quick way to onboard a team, a class, or a migrated user list
without writing a migration.

On the import form you upload the CSV and choose how it should be processed: the
column separator, a default password, whether accounts start Active or Blocked,
which registration email (if any) to send, the roles to grant, and which user fields
the CSV columns map to. The first row of the CSV holds field machine names; every row
after that becomes a user. The module generates a unique username for each account
(adding a number if it clashes), sets the password, skips any row whose email address
already exists, and — if you asked it to — sends the "Welcome" email with a one-time
login link.

Two conveniences round it out. A **"Generate sample CSV"** button downloads a
correctly-shaped template built from exactly the fields you ticked, so editors always
have the right column headers. And a **"Save configuration"** checkbox remembers your
chosen options so the next import pre-fills them. Access is governed by core's
**Administer users** permission, and an optional bundled submodule integrates with the
RoleAssign module so delegated admins only see roles they're allowed to assign.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (optionally) the RoleAssign submodule.
2. [Configuration](configuration/index.md) — the import form's options, the CSV
   file format, and the saved settings, field by field.

## Where it lives in the admin menu

The import form is at **People → Import users from CSV**
(`/admin/people/import`) — an action link labelled "Import users from CSV" appears on
the People (`/admin/people`) list. There is no separate settings page; all options are
chosen on the import form itself.
