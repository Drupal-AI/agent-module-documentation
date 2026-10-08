# Configuration

Remote File Importer is configured by creating one or more **data sources** in the
admin UI, each describing where to connect, what to fetch, and where to put it.
You configure it as an administrator. The exact fields depend on the data-source
plugin (FTP submodule or the separate SFTP module), but the shape is the same.

## Add a data source

From the module's admin screens, add a data source and fill in:

- **Connection details** — hostname, port, and the account **username and
  password** for the remote server. For FTP you can typically choose FTP or
  FTPES (FTP over TLS).
- **Source folder** — the directory on the remote server to scan for files.
- **Destination subfolder** — where inside Drupal's file storage the downloaded
  files should land.
- **Schedule** — how often the source is scanned and imported.
- **File-handling options** — for example, enabling modification-date checks so
  only new or updated files are imported, and optional deletion handling.

Save the source, then run an import — either on the schedule, manually from the
UI, or from the command line with the module's Drush command.

## Handle credentials safely (important)

Connecting to a remote server means storing **credentials**, and by design these
live in the data-source configuration entity. That has two consequences you must
plan for:

- **Credentials land in exported config.** If you export configuration (for
  Configuration Management / deployment), the connection settings — potentially
  including the password — go into the exported YAML. **Do not commit that config
  to version control**, and restrict who can access or export configuration on the
  site.
- **Prefer keeping the secret out of config where you can.** The recommended
  pattern on this project is to keep secrets in an **environment variable** rather
  than hard-coded in files. With DDEV you can set one with, for example,
  `ddev dotenv set .ddev/.env --rfi-ftp-password=<value>` (which becomes the
  variable `RFI_FTP_PASSWORD`; never commit `.ddev/.env`), then `ddev restart` so
  it is available in the container. Where Drupal offers a **Key** entity to
  reference such a variable, use it so the secret is not stored inline. Note that
  this module stores connection credentials in its own data-source config, so at
  minimum treat that config as sensitive and keep it out of your repository.
- **Use a least-privilege account.** Create a dedicated remote account scoped only
  to the import directory, with the minimum rights needed, rather than reusing an
  administrative login.

## Treat imported files as untrusted

The whole point of the module is to bring **external files** onto your site.
Those files are untrusted input:

- Apply Drupal's normal **file-type validation** and restrict which extensions are
  accepted where you can.
- Do not blindly auto-serve imported files unsanitized, and be cautious about
  where they are made public.
- Treat the remote source itself as something you trust only as far as you
  control it.

## Save

Save each data source after configuring it. Test with a manual import against a
non-production source first, confirm files arrive in the destination you set, then
enable the schedule.
