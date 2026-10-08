# S3 DB Export — manual setup guide

**S3 DB Export** (`s3_db_export`) automates SQL database backups and stores them in
**Amazon S3**. It runs a `mysqldump` (via the `ifsnop/mysqldump-php` library) to
produce a `.sql` file and, when enabled, uploads that file to your S3 bucket using the
AWS SDK. You can trigger an export on demand or let Drupal **cron** run it on a
schedule, and you can download the latest dump straight from the browser.

It offers a simple admin form for your AWS details, a manual export route
(`/db-export-s3`), a download route (`/db-export-s3-download`), and integration with a
bundled Ultimate Cron job for scheduling — useful for offsite disaster‑recovery
backups or grabbing a dump before a deployment or migration.

**Please read the security notes carefully before using this module.** A database dump
contains everything on your site — accounts, hashed passwords, private content — so how
and where it's stored matters a great deal, and this module has some sharp edges you
need to manage:

- **Dumps are written to the web‑accessible `public://tmp/` directory**, with a
  semi‑predictable `backup_<timestamp><random>.sql` filename, and the module **does not
  delete them** afterwards. That means a full database dump can linger in a location
  someone could guess or enumerate and download. Restrict access to that directory and
  clean up old dumps.
- **AWS credentials are stored in Drupal's `state` (plaintext in the database)**, not
  via the Key module.
- The export and download routes are correctly restricted to the **administrator**
  role.

Because of the above, prefer running this on a controlled environment, harden the
`tmp` directory, remove dumps after they're uploaded, and rotate the AWS keys if they
may have been exposed. The trigger/download routes being admin‑only is the main
built‑in safeguard.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your AWS details, prepare the tmp
   directory, schedule exports, and run one.

## Where it lives in the admin menu

The configuration form is at **Configuration → Content authoring → DbForm**
(`/admin/config/content/DbForm`). A manual export runs at `/db-export-s3` and the
latest dump downloads at `/db-export-s3-download`. All three require the
*administer Dbexport settings* permission **and** the administrator role. See
[Configuration](configuration/index.md).
