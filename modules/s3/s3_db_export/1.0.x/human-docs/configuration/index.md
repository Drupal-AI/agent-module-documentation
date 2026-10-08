# Configuration

Configuration happens on a single admin form, plus one filesystem prerequisite. You
must be an **administrator** (and hold the *administer Dbexport settings* permission) to
reach any of it.

## Step 0 — Create the tmp directory

Before your first export, create a `tmp` folder inside your files directory —
`sites/default/files/tmp` — and make sure it's writable. The module dumps the SQL file
there before uploading it. (See the security note below about this being a
web‑accessible location.)

## Step 1 — Enter your AWS S3 details

Go to **Configuration → Content authoring → DbForm**
(`/admin/config/content/DbForm`). Fill in:

- **Region** — the AWS region of your bucket (for example `us-east-1`).
- **Version** — the AWS API version string (typically `latest`).
- **Access Key** — your AWS access key ID.
- **Secret Key** — your AWS secret access key.
- **S3 Bucket Name** — the destination bucket.
- **Backup Directory** — the folder/prefix inside the bucket where dumps are stored.
- **Encryption** — whether to enable encryption for the backup files.

Save the form.

> **Important — how these credentials are stored.** This module saves the AWS access and
> secret keys in Drupal's `state` store, which means they sit **in the database in plain
> text** (it does not use the Key module). Anyone with database access, or a database
> backup, can read them. Use a dedicated IAM user scoped to just this bucket, rotate the
> keys periodically, and rotate immediately if they may have been exposed.

## Step 2 — Schedule exports (optional)

If you want automatic backups, set the export **frequency** (for example daily, weekly,
or a custom interval) on the form and save. Scheduled runs are driven by Drupal cron,
and the bundled **Ultimate Cron** job can manage the schedule if you use that module.

## Step 3 — Run an export

You can trigger a dump‑and‑upload in two ways:

- From the module interface, or
- By visiting **`/db-export-s3`** directly (admin only).

The module creates `backup_<timestamp><random>.sql` in `public://tmp/` and, when S3 is
configured, uploads it to your bucket. To grab the latest dump in your browser, visit
**`/db-export-s3-download`** (also admin only). Confirm the file lands in your S3
bucket to verify everything is wired up.

## Security: important cautions

- **Dumps land in a web‑accessible directory and are not auto‑deleted.** The `.sql`
  file is created in `public://tmp/` with a semi‑predictable name and left there. A full
  database dump could be enumerated and downloaded by someone who finds the path. After
  a successful upload, **delete the local dump** yourself, and lock down the `tmp`
  directory (for example with web‑server rules) so it isn't directly served.
- **A database dump contains all site data** — user accounts, hashed passwords, private
  content. Protect the S3 bucket (private, least‑privilege access) and the local file
  accordingly.
- **Keep the trigger and download routes admin‑only** — they already require the
  administrator role; don't loosen that.
- Consider whether a module that stores credentials via the Key module and writes to a
  private stream better fits your security requirements for handling full database
  exports.
