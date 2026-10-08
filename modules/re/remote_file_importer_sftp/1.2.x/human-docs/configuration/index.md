# Configuration

This module does not add its own settings page — it adds an **SFTP data-source
type** to Remote File Importer. You configure it by creating a data source of that
type in Remote File Importer's admin UI, as an administrator.

## Create an SFTP data source

Add a new data source and choose the **SFTP** type, then fill in:

- **Host** — the SFTP server's hostname or IP.
- **Port** — the SFTP/SSH port (commonly 22).
- **Username** and **Password** — the SFTP account credentials. (Authentication
  is currently by username and password.)
- **Remote directory** — the folder on the server to scan for files.

The base Remote File Importer module supplies the rest of the settings — the
destination inside Drupal, the schedule, and file-handling options such as
modification-date checks. Save the source, then run an import from the schedule,
the UI, or Drush.

Transfers happen over **SSH/SFTP, so the data is encrypted in transit** — a real
advantage over plain FTP.

## Handle the password safely (important)

The SFTP **password is stored in the data-source configuration entity** — that is,
in the module's config, which exports to YAML. Plan for this:

- **It lands in exported config.** If you export configuration for deployment, the
  data-source config (including the credential) goes into the exported YAML.
  **Do not commit that config to version control**, and restrict who can access or
  export configuration on the site.
- **A small mitigation, not a fix:** Drupal's password form element does not
  re-render a stored value, so the credential is *not* echoed back into the admin
  form's HTML. That reduces shoulder-surfing risk, but the password is still in
  config — so the "keep config out of your repo" rule still applies.
- **Prefer keeping the secret in an environment variable where you can.** The
  recommended pattern on this project is to store secrets in an environment
  variable rather than in files. With DDEV, set one with, for example,
  `ddev dotenv set .ddev/.env --sftp-password=<value>` (which becomes the variable
  `SFTP_PASSWORD`; never commit `.ddev/.env`), then `ddev restart`. Where Drupal
  offers a **Key** entity to reference such a variable, use it so the secret is not
  stored inline. At minimum, treat this module's data-source config as sensitive.
- **Use a least-privilege, dedicated SFTP account** scoped only to the import
  directory, rather than a general-purpose or administrative login.

## Save

Save the data source, test with a manual import against a non-production
directory, confirm files arrive at the destination, then enable the schedule.
