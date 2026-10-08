# Mismatched entity and/or field definitions — manual setup guide

**Mismatched entity and/or field definitions** (`meaofd`) fixes one specific,
annoying problem: the *"Mismatched entity and/or field definitions"* warning that can
appear on Drupal's Status report (`/admin/reports/status`). That warning shows up
when a module changes an entity type or field definition in code but the stored
definitions in the database have not been reconciled to match. This module reconciles
them, clearing the warning.

Under the hood it wraps Drupal core's own entity-definition update system: it reads
the same change summary that drives the Status report warning, and for the entity
type you point it at, it installs/updates the stored definitions to match the current
code. It offers three ways to trigger that: a **report page** with a "Fix" button, a
**Drush command**, and a **service** you can call from an update hook to automate the
fix across environments during a deployment.

The module has **no settings** — there is nothing to configure. It works the moment
you enable it (the report page appears under Reports), and it acts only when there is
actually a mismatch to fix. It adds two permissions (view the report, and apply
fixes), ships a Drush command, and has no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The report is at **Reports → Mismatched entity and/or field definitions**
(`/admin/reports/mismatched-entity-and-or-field-definitions`). There is no settings
page — the module has nothing to configure.

## How to use it

You reach for this module when the Status report shows the mismatched-definitions
warning. There are three ways to clear it.

### From the report page

1. Go to **Reports → Mismatched entity and/or field definitions**.
2. If everything is in sync you will see *"No mismatched entity and/or field
   definitions found."* Otherwise you get a table listing each affected entity type
   and the specific changes.
3. Click **Fix** (or **Fix all** when a type has several changes) next to an entity
   type. The fix runs through Drupal's Batch system, so large reconciliations will
   not time out, and you are returned to the report with a success message.

The Fix links only appear as working buttons for users who hold the **Fix mismatched
entity and/or field definitions** permission; users with only the view permission see
the report but a disabled button.

### From Drush (deployments and the command line)

```bash
drush meaofd:fix paragraph      # reconcile the Paragraph entity type
drush meaofd:fix node
```

Pass the machine name of the entity type (for example `node`, `paragraph`,
`taxonomy_term`, `media`, `comment`). It prints what it updated, or "No updates
required" when nothing was pending. The `--no-cache-rebuild` option skips the cache
rebuild around the fix if you manage caches yourself. There is no bulk "fix
everything" command — call it once per entity type.

### From code (automated deployment)

In a module's `hook_update_N()` you can call the module's service so the fix runs
automatically when the update is applied on each environment:

```php
function mymodule_update_10001() {
  \Drupal::service('meaofd.fixer')->fix('node');
}
```

This is a safe, tidy alternative to hand-writing an `installEntityType()` update
hook. Note it targets exactly the "mismatched definitions" case — it does not perform
destructive field-data migrations.

## Permissions

Two permissions, both flagged as security-sensitive, appear on **People →
Permissions**:

- **View mismatched entity and/or field definitions** — see the report page.
- **Fix mismatched entity and/or field definitions** — actually apply a fix from the
  UI. (The Drush command runs as the command-line user and is not gated by these.)
