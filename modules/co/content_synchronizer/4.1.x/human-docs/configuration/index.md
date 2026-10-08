# Configuration

Content Synchronizer has no global settings form — the module's own description
says "no specific configuration is needed." Instead you work through a
**dashboard** and two content entity types. This page covers the day-to-day
workflow, the two import strategies, the permissions, and the Drush commands.

## Grant the permissions first

Go to **People → Permissions** (`/admin/people/permissions`) and assign what each
role needs. The permissions come in three groups:

- **Dashboard** — *Access content synchronizer dashboard* lets a role reach the
  dashboard and the export/download routes.
- **Export entities** — separate permissions to *add*, *edit*, *delete*, view, and
  see the overview of Export entities, plus *Administer export entity entities*
  (security-sensitive — grant only to trusted admins).
- **Import entities** — the same set for Import entities, including *Administer
  import entities* (also security-sensitive).

A common setup: give editors *Access content synchronizer dashboard* plus the add
/edit permissions, but keep the two *Administer …* permissions for administrators
only.

## The dashboard

The dashboard lives at **Content → Content Synchronizer**
(`/admin/content_synchronizer`). From here you reach the Export and Import
collections and launch exports and imports. The collections themselves are under
**Structure**: Export entities at `/admin/structure/export_entity`, Import
entities at `/admin/structure/import_entity`.

## Export: build an archive (on the source site)

An **Export entity** is a named, reusable set of content to ship.

1. Go to the Export entities collection and click **Add Export entity**.
2. Give it a name and add the entities you want to include.
3. **Launch** the export. The module builds a `tar.gz` archive — automatically
   pulling in referenced entities (terms, files, paragraphs, and so on) so
   relationships travel with your content — and gives you the archive to
   download.

Two shortcuts exist alongside the reusable Export entity:

- **Quick Export** — a link that exports a single entity to a `tar.gz`
  immediately, without building an Export entity first.
- **Export entity action** — a bulk operation you can run from a Views listing
  (such as the Content admin view) to export many selected items at once.

## Import: load an archive (on the destination site)

An **Import entity** is an uploaded archive plus the state of running it.

1. Go to the Import entities collection and click **Add Import**.
2. Upload the `tar.gz` archive you exported.
3. Choose the two strategies below, then **launch** the import.

Because every exported entity carries a stable UUID / global reference,
relationships reconnect on this site and updates target the correct existing
content.

### Publish strategy (what happens to content as it's created)

- **Publish** *(default)* — imported content is published on creation.
- **Unpublish** — content is imported but left unpublished, so you can review it
  before it goes live.
- **Revision** — content is imported as a new revision, keeping history.

### Update strategy (what happens when the content already exists)

- **Update if recent** *(default)* — overwrite the existing entity only when the
  incoming copy is more recent.
- **Update systematic** — always overwrite the existing entity.
- **No update** — never touch entities that already exist; only genuinely new
  content is created.

## Doing it from the command line (Drush)

For CI, scripting, or headless use, the same operations are available as Drush
commands (all arguments are prompted if you omit them):

| Command | Alias | What it does |
|---------|-------|--------------|
| `content:synchronizer-export-entity <type> <id> [dir]` | `cseex` | Export one entity, e.g. `node 123`, to a `tar.gz`. |
| `content:synchronizer-launch-export <exportId> [dir]` | `cslex` | Build the archive for a saved Export entity. |
| `content:synchronizer-create-import <path>` | `csci` | Create an Import entity from an archive path (prints the new id). |
| `content:synchronizer-launch-import <importId>` | `cslim` | Run an existing Import entity. |
| `content:synchronizer-launch-import <path>` | `cscli` | Create an import from an archive **and** launch it in one step. |
| `content:synchronizer-clean-temporary-files` | `csctf` | Delete leftover temporary export/import files. |

The import commands take `--publish=` (`publication_publish` /
`publication_unpublish` / `publication_revision`) and `--update=`
(`update_systematic` / `update_if_recent` / `update_no_update`) options.

Examples:

```bash
# Export node 12 to a directory
drush content:synchronizer-export-entity node 12 /tmp/out

# Create an import from an archive and launch it, unattended
drush cscli /tmp/export3.tar.gz --publish=publication_unpublish --update=update_if_recent

# Housekeeping: remove temporary files
drush csctf
```

Note on the destination argument: it is treated as a **directory to write into**,
not the exact filename. The command logs the final "… has been created" path —
read that line to find your archive.
