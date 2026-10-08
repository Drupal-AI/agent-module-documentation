# Configuration

Setup has two parts: store your AWS credentials securely with the Key module, then
configure the backup settings (bucket, filesystem, tables, schedule).

## Step 1 — Store your AWS credentials securely

This module reads your AWS access and secret keys from a **Key** entity via the
`key_aws` provider — the keys are never entered into plain module configuration. The
safest way to supply them is through environment variables rather than typing them into
the database.

**If you use DDEV**, save the values as environment variables and load them into the
container:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=<your-access-key>
ddev dotenv set .ddev/.env --aws-secret-access-key=<your-secret-key>
ddev restart
```

(The flag `--aws-access-key-id` becomes the variable `AWS_ACCESS_KEY_ID`, and so on.
Never commit `.ddev/.env`.)

Then create the Key entities at **Configuration → System → Keys**
(`/admin/config/system/keys`) — add a key for the access key and one for the secret
key, using the **environment** key provider pointed at the variables above. The
project also supports the **Key AWS S3** provider, which can hold both the access and
secret key on a single key entity. Once your keys exist here, you'll link them from the
backup settings in Step 2.

> **Why this matters:** these credentials can write (and read) your S3 bucket, and the
> backups themselves contain your entire database. Keep the secrets out of config and
> out of version control.

## Step 2 — Configure the backup settings

Go to **Configuration → S3 DB Backup → Settings**
(`/admin/config/s3-db-backup/settings`) — you'll need the **`administer s3_db_backup`**
permission. Key options:

- **AWS credentials (keys)** — select the Key entity/entities you created in Step 1 so
  the module can authenticate to S3.
- **S3 bucket** — the destination bucket name.
- **Endpoint** — optionally set a custom endpoint for S3‑compatible storage instead of
  Amazon's default.
- **Sub‑folder / prefix** — optionally organise objects under a folder inside the
  bucket.
- **Storage filesystem** — choose where local copies live. **Use the private
  filesystem, not public.** The form warns you if no private directory is configured.
  A public path would leave your full database dump downloadable by anyone who finds
  the URL.
- **Tables to include / exclude** — narrow the dump if you want to skip large or
  irrelevant tables (for example cache tables).
- **Compression** — gzip or bzip2 to shrink the dump.
- **Cron interval** — how often Drupal cron should run an automatic backup.

Save the form.

## Step 3 — Run and download backups

Go to **Configuration → S3 DB Backup** (`/admin/config/s3-db-backup`) to trigger an
on‑demand backup and to see the **history** of previous backups with timestamps. From
here you can download a previous backup; downloads use **time‑limited pre‑signed S3
URLs** rather than exposing the object publicly.

## Running backups from the command line

Once configured, you can generate a backup via Drush:

```bash
drush s3-db-backup:export
```

This is handy for scripted or scheduled backups outside the web UI. (Download links
are only offered inside the admin back‑end, by design.)

## Security recap

- Store AWS keys via the **Key** module (Step 1), never in plain config.
- Keep backups in the **private** filesystem — never `public://`.
- A database dump contains all site data, including hashed passwords and private
  content — protect the bucket and the local backup directory accordingly, and limit
  the `administer s3_db_backup` permission to trusted administrators.
