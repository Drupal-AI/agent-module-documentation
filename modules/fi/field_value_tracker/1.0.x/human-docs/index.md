# Field Value Tracker — manual setup guide

**Field Value Tracker** (`field_value_tracker`) solves a problem that shows up
every time you copy a production database down to a staging or development
environment: the content is now full of *production* values — live URLs, real
customer email addresses, API endpoints, CDN domains, SSO/login links — and you
usually do not want a lower environment using any of them. Left alone, a staging
site can happily send test emails to real customers or call production services.

Rather than hand-editing hundreds or thousands of field values after every sync,
you configure this module once. You tell it which fields to watch and what their
values should become in a non-production environment, then run a single Drush
command after each database copy to swap them. It has two modes: **Replace** does
a substring replacement (turn `production.example.com` into
`staging.example.com` wherever it appears), and **Overwrite** sets the field to a
fixed value outright (make every notification email `test@example.com`).

For safety it refuses to run in a detected production environment (Acquia and
Pantheon are recognised automatically), and it offers a **dry run** so you can
preview every change before touching the database. Updates are written directly at
the database level for speed, so it works only with fields stored in field tables
(not entity base fields), and it deliberately does **not** clear entity caches for
you — run a cache rebuild afterwards. Because the values you store here can be
credentials-adjacent configuration, treat them with care: grant the module's
permission only to trusted administrators and keep secrets out of exported config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — add tracker items field by field, and
   run the Drush update (with a dry run first).

## Where it lives in the admin menu

Once enabled, the tracker's admin screen sits at **Configuration → Development →
Field Value Tracker** (`/admin/config/development/field-value-tracker`). That is
where you add and manage the field mappings. The actual value swap happens from
the command line with Drush, not from the UI.

## How to use it

The typical workflow is:

1. Grant the **Administer field value tracker** permission to the roles that should
   manage it (see [Installation](installation/index.md)).
2. Add one or more **tracker items** on the admin screen, each naming a field, a
   mode, and the values to find/set (see [Configuration](configuration/index.md)).
3. After syncing a production database into your lower environment, preview the
   changes with a dry run:

   ```bash
   drush fvt:update --dry-run
   ```

4. When the preview looks right, apply it:

   ```bash
   drush fvt:update
   ```

5. Rebuild caches (`drush cr`) so the fresh values are shown — the module does not
   clear entity caches for you.

You can automate step 3–4 by hooking `drush fvt:update` into your host's
post-database-copy step (for example an Acquia `hooks/post-db-copy` script or a
Pantheon `pantheon.yml` workflow), so every future sync self-cleans.
