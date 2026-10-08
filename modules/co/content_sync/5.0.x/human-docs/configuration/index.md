# Configuration

## Step 1 — Declare the content sync directory (required)

Content Sync writes its YAML files to a **content sync directory**, and there is *no
admin field for it*. Just like core's config sync directory, you set it as a global in
`settings.php`:

```php
// settings.php (or settings.local.php)
$content_directories['sync'] = '../content/sync';
```

Point it at a directory outside your docroot and make it writable by the web user.

A gotcha worth knowing: if this global is unset, the module does **not** throw an
error — it quietly shows a UI message and does nothing, so a Drush export can look like
it ran while writing no files. Verify the directory is resolved before you rely on it:

```bash
drush php:eval 'print content_sync_get_content_directory("sync");'
```

(If `['sync']` is unset the module falls back to `$content_directories['staging']`.)

## Step 2 — The settings form

Go to **Configuration → Development → Content → Settings**
(`/admin/config/development/content/settings`). You need the **Synchronize content**
permission. It writes to the `content_sync.AdminSettings` config object and has two
options:

- **Site UUID override** *(off by default)* — bypasses the check that content came from
  *this* site. Leave it **off** when moving content between environments of the *same*
  site (they share a site UUID). Turn it **on** only when you deliberately want to
  import content that was exported from a *different* site — doing so removes the guard
  that stops one site's content from overwriting another's.
- **Disable help menu** — hides the "How can we help you?" help menu in the UI.

## Step 3 — Export and import

### From the UI

Under **Configuration → Development → Content** you get:

- **Content** (the main change list) — shows what's created / updated / deleted between
  the sync directory and the live site, with an "Import all" action.
- **Export** — a full batched export to an archive or the sync directory, plus a
  "single" tab to view one entity's YAML on screen.
- **Import** — upload an archive to import, or paste a single entity's YAML.
- **Logs** — the module's own record of what each run did.

You can also bulk-export nodes selected in a content view using the **Export content**
action.

### From Drush (recommended for deployments)

Two batched commands, both interactive by default — they print a change table and ask
for confirmation unless you pass `--skiplist`. Always use `--skiplist` in CI (answering
"no" to the prompt exits non-zero).

```bash
# Full first export of everything, non-interactive.
drush content-sync:export sync --force --skiplist

# Only articles and the entities they reference.
drush content-sync:export sync --force --entity-types=node.article --include-dependencies --skiplist

# Deploy content on the target site.
drush content-sync:import sync --skiplist

# Additive-only import that never deletes local content.
drush content-sync:import sync --actions=create,update --skiplist
```

Useful export/import options include `--uuids=…` (only specific entities),
`--files=none|base64|folder` (how file payloads travel; default `folder`),
`--include-dependencies` (export referenced entities too), and `--actions=…` (limit to
create/update/delete). The command aliases are `cse` (export) and `csi` (import); if
`drush list` doesn't show them, run `drush cr`.

## Permissions

All four permissions are **restricted** — Drupal warns that granting them is a trust
decision, and for good reason:

- **Synchronize content** — the change-list screen, the diff pages, and the settings
  form (which can switch on the cross-site override).
- **Export content** — the export forms and archive download. Exports read **all**
  content regardless of access, including unpublished entities.
- **Import content** — the import forms. This is effectively *"create / update / delete
  any content entity"*: the importer runs with no entity-access checks and saves
  whatever the YAML says (including user entities). Treat it as an administrative
  permission and never give it to an editor role.
- **Logs content** — the module's log screen.

## A caution about import validation

Imports bypass entity access, and constraint validation runs **only for user
entities** — for nodes, terms, and everything else the importer saves the YAML without
validating it. Don't rely on import to reject malformed content; only import YAML you
trust.
