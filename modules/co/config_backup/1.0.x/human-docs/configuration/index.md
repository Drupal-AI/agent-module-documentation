# Configuration

Config Backup doesn't need much setup — the two things to get right are the
**backup directory** and the **permission**. You then create snapshots either from
the admin UI or with `drush`.

## Set the backup directory (required)

The module has **no default directory**. Add a setting to the end of `settings.php`
telling it where to write archives, for example:

```php
$settings['config_backup_directory'] = '../config/back';
```

Choose a path **outside the webroot** (as the README recommends) so the archives
are not web-accessible, and add it to `.gitignore` if it sits inside your repo. If
this setting is missing, the Backup page and the Drush command show an error and
write nothing. The directory must be writable — the form warns you if it is not.

## Grant the permission carefully

Under **People → Permissions**, grant **Backup configuration** **only to trusted
administrators**. Because a configuration backup can include sensitive values (API
keys, credentials, and other settings), anyone who can create a backup can
potentially read those values. This is the module's only permission (there is no
separate restore or download permission — the module does not offer those
features).

## Create a backup

- **From the admin UI** — open **Configuration → Development → Configuration
  synchronization → Backup**
  (`/admin/config/development/configuration/backup`) and click **Backup**. It writes
  a `configs-<date>_<time>.tar.gz` archive into your configured directory and shows
  the saved path.
- **From Drush** — run `drush config:backup` (alias `drush cbkp`) on the command
  line (handy for scripting or scheduling). Inside DDEV, prefix with `ddev` from the
  host (`ddev drush …`); run `drush` directly inside `ddev ssh`.

## Restoring from a snapshot (manual)

The module only *creates* archives — it does not restore them. To roll back, extract
the archive's YAML files into a configuration sync directory and run
`drush config:import`. Treat that as a deliberate action — it overwrites active
configuration.

## Handle backups securely

Keep the backup directory somewhere **not publicly accessible** and protect the
archives like any other sensitive artifact. Don't point the directory at a
web-reachable path, and don't commit archives containing secrets to a shared
repository.

> The module's bundled `README.md` carries the most complete and current
> documentation for exact routes, options, and Drush command names.
