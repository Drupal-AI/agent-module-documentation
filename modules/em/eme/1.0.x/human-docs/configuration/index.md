# Configuration

Entity Migrate Export is used through a settings form plus an export workflow (and,
if you prefer the command line, Drush). All of it lives under **Configuration →
Development → Entity Migrate Export**, and access is gated by the module's
restricted **Export content** and **Manage content export settings** permissions —
grant these only to trusted administrators, since exporting content extracts it in
bulk.

## Set the defaults (settings form)

Start at the settings form:

**Configuration → Development → Entity Migrate Export → Settings**
(`/admin/config/development/entity-export/settings`).

Here you customise the defaults the export uses — such as the generated module's
name, the migration group, an ID prefix, and where the module is written. Adjust
these to match your project's conventions, then save. You can leave them at their
defaults for a quick first export.

## Export content (UI)

1. Go to the export form at
   `/admin/config/development/entity-export`.
2. Select which **content entity types** you want to export (for example nodes,
   media, files, comments).
3. Submit the form.
4. At the end of the batch process you receive a generated **migration module**
   containing the migration YAML and the data files.

Any content referenced by what you export (through reference fields) is included
automatically, so the generated migration will run without dangling references.

## Group related content (collection)

For a set of related content you want to keep together and update over time, use
the **collection** form at
`/admin/config/development/entity-export/collection`. Building a collection
gathers the related entities so the output is a coherent, runnable set. To refresh
a previously exported collection with new content, use its **Reexport** button.

## Export with Drush

The same workflow is available on the command line. A minimal export:

```bash
drush eme:export --id my_project_dev --types node,block_content
```

which is equivalent to the fully spelled‑out form:

```bash
drush eme:export \
  --module my_project_dev_content \
  --group my_project_dev \
  --id-prefix my_project_dev \
  --types node,block_content \
  --name 'My Project Dev Content Entity Migration' \
  --destination modules/custom
```

To update a previous export:

```bash
drush eme:export --update my_project_dev_content
```

## Running the generated migrations

The output is a normal module, so commit it, review it, and run it with the
ordinary migrate tooling on the target environment:

1. Make sure **Migrate Plus** and **Migrate Tools** are installed there.
2. Enable the generated module (its default name is `eme_migrate`, or whatever you
   named it).
3. Import:

   ```bash
   drush migrate:import --tag my_project_dev --execute-dependencies
   ```

Because these are standard migrations, they are rollbackable, mappable, and
re‑runnable — unlike a one‑off serialisation format.
