# Configuration

This module has no settings page of its own — you configure it by creating Key entities for
your AWS credentials and then adding an **AWS S3 destination** inside Backup & Migrate. This
page walks through both.

## Step 1 — Store your AWS credentials as Key entities

The module reads credentials from the Key module at runtime; it stores only the *names* of the
Key entities, never the secrets themselves. Create your keys at **Configuration → System →
Keys** (`/admin/config/system/keys`):

- **Two separate keys** — one holding the **access key id** and one holding the **secret access
  key**, or
- **A single credentials-file key** — if you enabled the optional **Key AWS** module, you can
  create one AWS credentials-file key instead.

> **Keep the secret out of version control.** Rather than typing the secret access key straight
> into the Key entity (where it can land in exported configuration), create the key with an
> **environment variable** provider and source the value from your environment. With DDEV, store
> it once with `ddev dotenv set .ddev/.env --aws-secret-access-key=<value>` and `ddev restart`,
> then create a Key that reads the `AWS_SECRET_ACCESS_KEY` variable. This way you rotate
> credentials by updating the environment (or the Key entity), with no destination change and no
> secret in the repo.

## Step 2 — Add the AWS S3 destination

1. Go to **Configuration → Development → Backup and Migrate → Settings → Destinations**
   (`/admin/config/development/backup_migrate/settings/destination`).
2. Click **Add destination** and choose the type **AWS S3**.
3. Fill in the fields:

| Field | Required | What it's for |
|-------|----------|---------------|
| **S3 Endpoint / Host** | No | The endpoint URL, e.g. `https://s3.amazonaws.com`. Set a custom endpoint here to target an S3-compatible service such as MinIO, Wasabi, or DigitalOcean Spaces. Leave blank for standard AWS. |
| **S3 Access Key** | No\* | The Key entity that holds your access key id. Shown when Key AWS is **not** enabled. |
| **S3 Secret Key** | No\* | The Key entity that holds your secret access key. Shown when Key AWS is **not** enabled. |
| **S3 Credentials Key** | No\* | A single AWS credentials-file Key entity. Shown **only** when Key AWS **is** enabled. |
| **S3 Bucket** | **Yes** | The name of the target bucket. |
| **Sub-folder** | No | An optional prefix (folder) within the bucket, written without leading or trailing slashes, e.g. `backups/prod`. Handy for keeping backups organized in a shared bucket. |
| **S3 Region** | **Yes** | The AWS region id for the bucket (choose from the list). Set this for data-residency/compliance needs. |

\* The credential fields are individually optional in the form, but a working S3 client needs a
**region** *and* resolvable credentials (either an access key + secret key, or a credentials-file
key). If you leave the credentials blank, the AWS SDK falls back to its default provider chain
(for example an IAM instance role); if nothing resolves, you'll see the error *"Please fill all
mandatory fields to create S3 client."*

4. Click **Save**.

## Step 3 — Back up to S3

With the destination saved, you can now use it:

- **Manual backup:** go to **Configuration → Development → Backup and Migrate**, run a Quick
  Backup, and select your AWS S3 destination.
- **Scheduled backup:** add the destination to a Backup & Migrate **schedule** for automated,
  recurring off-site backups.

You can also **list**, **download** (through the browser), **restore from**, and **delete**
S3-stored backups from Backup & Migrate's destination management — all scoped to the bucket and
sub-folder you configured.

## Good things to know

- **Changing the sub-folder** hides backups stored under a different prefix from the listing
  (they still exist in the bucket — they're just under the old prefix).
- **Object Lock / WORM buckets** are supported: when a bucket has S3 Object Lock enabled, the
  module adds a SHA-256 checksum on upload automatically.
- **Rotating credentials** is just a matter of updating the referenced Key entity (or its backing
  environment variable) — the destination configuration doesn't change.
- **Least privilege:** scope the IAM user or role to just the backup bucket.
- If S3 operations fail, the module surfaces the AWS error as a message and logs it to the
  `backup_migrate_aws_s3` log channel (**Reports → Recent log messages**).
