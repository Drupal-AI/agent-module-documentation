# Configuration

Default Content Deploy is configured in two places: a single directory setting
in `settings.php`, and the Drush commands you run day to day. There is no large
settings form to fill in.

## Set the content directory in `settings.php`

DCD needs a directory to write exported content into (and to read it from on
import). Add a line to your site's `settings.php`:

```php
// Relative path (relative to the Drupal web root).
$settings['default_content_deploy_content_directory'] = '../content';

// Or an absolute path.
$settings['default_content_deploy_content_directory'] = '/var/dcd/content';
```

It is recommended to place this directory **outside the document root** so the
exported files are not web‑accessible. If you do not set this at all, DCD falls
back to creating a directory automatically at
`public://content_<hash_salt>` — workable for a quick trial, but the explicit,
outside‑the‑root path is the better practice for a real project.

## Permissions

DCD provides two permissions, set on **People → Permissions**
(`/admin/people/permissions`):

- **`default content deploy export`** — allows running exports.
- **`default content deploy import`** — allows running imports.

> **Grant the import permission narrowly.** An import *writes and can overwrite
> entities* on the target site — it is a way to create or replace content
> programmatically. On production that belongs to a trusted deployment process,
> not a broadly assigned role. Review what a deployment includes before running
> it against production.

## Drush command reference

Exporting content:

- **`drush default-content-deploy:export`** (`dcde`) — export a single entity or
  a group of entities.
- **`drush default-content-deploy:export-with-references`** (`dcder`) — export
  entities together with the entities they reference.
- **`drush default-content-deploy:export-site`** (`dcdes`) — export a whole
  site's content.

Importing content:

- **`drush default-content-deploy:import`** (`dcdi`) — import all content found
  in the content directory.

Helpers:

- **`drush default-content-deploy:uuid-info`** (`dcd-uuid-info`) — show the
  current System Site, Admin and Anonymous UUIDs and the admin name.
- **`drush default-content-deploy:entity-list`** (`dcd-entity-list`) — list the
  current content entity types.

An import can also be triggered from the administration interface, but the Drush
commands are the primary, scriptable workflow used in deployments.

## How import decides what to write

When you run `drush dcdi`:

- Each imported entity is matched by **UUID**, so it is either created (new) or
  updated (already exists).
- Entity **IDs are not preserved** by default (so an entity may get a new ID to
  avoid conflicts); references stored by ID are corrected during import based on
  UUIDs. Use `--preserve-ids` only if you understand the consequences.
- An existing entity is updated **only if the imported version is newer** (by
  the last‑changed timestamp across all translations). An imported entity that
  is the same age or older is skipped.
- Passing **`--force-update`** overrides that: the existing entity is deleted and
  recreated from the imported JSON with the same ID. (User entities are treated
  specially — only the UUID and username are updated, to avoid creating a
  blocked, password‑less account.)

Always review what a deployment carries, and keep a backup, before importing
against production.
