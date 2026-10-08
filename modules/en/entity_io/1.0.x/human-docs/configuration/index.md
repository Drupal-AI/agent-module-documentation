# Configuration

Entity IO is driven mostly from **export tabs on entities** and, if you prefer the
command line, from **Drush commands**. This page covers the export and import
workflows, the options you can set, and the CLI.

> **Handle exports as sensitive data.** Exported JSON can contain personal
> information (for example user data). Restrict Entity IO to trusted administrators,
> store exported files carefully, and review the import diff before applying changes
> to a live site.

## Exporting

- Open a supported entity and use its Entity IO **export tab** to export it to a
  JSON file. The export follows the entity's references as deeply as configured,
  capturing related entities (referenced nodes, users, taxonomy terms, paragraphs,
  media, comments) so the relationships survive the round trip.
- **Control the depth and fields.** You can customize which fields are exported and
  how deeply related entities are included — from simple field values to deeply
  nested references.
- **Export a specific revision.** For entities that support revisions, the revision
  overview offers an export option so you can export a particular revision directly.
- **Export in bulk.** Multiple entities can be exported at once from the
  administrative interface.
- **Choose the file system.** Exports can be written to **public** or **private**
  file storage — use private storage when the content is sensitive.

## Importing

- Import previously exported JSON back into a site. All associated data is restored,
  including the referenced entities captured at export time.
- **Review the diff first.** When you import an entity that already exists, Entity IO
  shows a **side‑by‑side diff** of the existing data versus the incoming version, so
  you can review and confirm before applying the change.
- **Revisions and authorship.** You can configure imports to generate a new revision
  and to record a chosen user as the author of the change.

## Drush commands

Entity IO supports CLI‑based exports and imports. Some common commands:

```bash
# Export
drush entity-io:export
drush entity-io:export --all
drush entity-io:export --entity-type=node --all
drush entity-io:export --entity-type=node --id=123

# Import
drush entity-io:import
drush entity-io:import --user=1
drush entity-io:import --user=username
drush entity-io:import --entity-type=node

# List exported files
drush entity-io:list
drush entity-io:list --entity-type=node

# Import JSON from a folder
drush entity-io:import-folder [/path/to/json or public://entity_io_exports]

# Clear exported files
drush entity-io:clear-exports
drush entity-io:clear-exports --entity-type=node
```

> **Using DDEV?** Prefix these with `ddev` from the host (`ddev drush
> entity-io:export --all`), or run them without the prefix inside `ddev ssh`.

## Automated and large‑scale workflows

For queued operations, webhooks, pushing to another site, or purging, enable the
matching submodules described in [Installation](../installation/index.md). Because
several of those send content to other systems or expose an authenticated import
endpoint, configure them with trusted destinations and protected credentials.
