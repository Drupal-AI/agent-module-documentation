# Configuration

Migrate Source UI has almost nothing to configure — it works as soon as you enable
it and grant the permissions. There is a single optional setting, controlling where
uploaded source files are stored.

## Grant the permissions

The module ships two permissions, both marked security-sensitive because running a
migration can create or overwrite content in bulk and choosing an upload directory
touches the filesystem. Grant them only to trusted roles.

- **Access migrate source ui** (`access migrate source ui`) — lets a user open the
  run page, upload a source file, and run a migration.
- **Administer migrate source ui** (`administer migrate source ui`) — lets a user
  open the settings page and change where uploads are stored.

```bash
# let an "importer" role run file migrations from the UI
drush role:perm:add importer 'access migrate source ui'
# let site admins change the module settings
drush role:perm:add administrator 'administer migrate source ui'
```

## The one setting — where uploaded files are stored

Open the settings page at **Configuration → Content authoring → Migrate Source UI**
(`/admin/config/content/migrate_source_ui`). It exposes a single field:

- **File temp directory** (`file_temp_directory`) — a stream URI, such as
  `private://imports`, telling the module where to save an uploaded source file
  before it runs the migration. When you leave it blank, uploads go to Drupal's
  **temporary** files scheme. Point it at a `private://` directory if your source
  files contain sensitive data, so they aren't publicly reachable.

```bash
drush cget migrate_source_ui.settings file_temp_directory
```

That is the only setting. There is nothing here for defining migrations themselves —
Migrate Source UI only supplies the source file for migrations that already exist.

## Running a migration

With the permissions granted, go to **Content → Migrate Source UI**
(`/admin/content/migrate_source_ui`), choose a migration from the list, upload a
matching file (`csv`, `json`, or `xml`), and submit. If the migration is stuck in a
non-Idle state, the form resets it to Idle for you (with a warning) before running.
Remember this **mutates content** exactly like `drush migrate:import` — the
migration must already be correct for the file's structure; the module only points
its source path at your uploaded file.
