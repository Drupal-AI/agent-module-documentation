# Using the import

D7 Content Import has no settings form — it's a migration tool you drive through
an import form (**Content → D7 Import**, `/admin/content/d7-import`) or a set of
Drush commands. This page walks through the process end to end.

## Step 1 — Export content from your Drupal 7 site

On the **D7 site**:

1. Copy the module's `d7_export_script/export_content.php` to your D7 site root.
2. Run it with Drush (for a multisite, name the site):

   ```bash
   drush -l yoursite.com php-script export_content.php
   ```
3. Find the exported XML files under `sites/default/files/export/[site_name]/`.

Copy those XML files somewhere your **Drupal 11** site can read them. If you want
managed files brought across too, also make the D7 `files` directory available.

## Step 2 — Import into Drupal 11, in order

The import **must be run in this order**, because later stages depend on earlier
ones (for example, nodes reference terms and files that must already exist):

1. **Vocabularies** — creates the empty vocabulary entities.
2. **Terms** — populates terms with preserved term IDs, topologically ordered so
   each parent exists before its children.
3. **Content types / fields** — creates node types, field configurations, and the
   default form/view display components.
4. **Files** — creates file entities with preserved file IDs.
5. **Nodes** — creates nodes with preserved node IDs.
6. **Aliases** — creates URL path aliases.
7. **Menus** — creates menus and menu links.

You can run these stages from the import form at `/admin/content/d7-import`, or
with Drush.

## Drush commands

Run the whole import at once:

```bash
drush d7-import:all /path/to/export/
```

`d7-import:all` accepts `--skip-*` flags to omit individual stages, and
`--source-files=/path/to/d7/files` to copy managed files across.

Or run individual stages:

```bash
drush d7-import:vocabularies /path/to/taxonomy.xml
drush d7-import:terms /path/to/taxonomy.xml
drush d7-import:content-types /path/to/nodes.xml
drush d7-import:files /path/to/files.xml --source-files=/path/to/d7/files
drush d7-import:nodes /path/to/nodes.xml
drush d7-import:aliases /path/to/aliases.xml
drush d7-import:menus /path/to/menus.xml
```

To undo an import, `drush d7-import:purge --all` (or target a single kind with
`--nodes` / `--terms` / `--files` / `--menus` / `--aliases` / `--vocabularies`).

## What to expect

- **IDs are preserved** — node, term, and file IDs match the D7 source, and the
  auto‑increment sequences are repaired afterward so new content doesn't collide.
- **Fields are inferred** — D7 field types are mapped to their D11 equivalents
  (for example `text` → `string`, `taxonomy_term_reference` → an
  `entity_reference` to taxonomy), with cardinality and allowed values taken from
  the exported data, and each field registered on the default displays.
- **Missing source files are skipped with a warning** rather than creating broken
  managed‑file rows, and taxonomy cycles or orphans attach at the root with a
  warning.

Run it on a copy or a fresh site first, and review the warnings before treating an
import as final.
