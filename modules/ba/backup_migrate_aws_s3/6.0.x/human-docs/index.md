# Backup and Migrate: AWS S3 — manual setup guide

**Backup and Migrate: AWS S3** (`backup_migrate_aws_s3`) adds an **AWS S3** destination to
the popular Backup & Migrate module, so your scheduled or manual Drupal backups are stored
off-site in an Amazon S3 (or S3-compatible) bucket instead of only on the web server. It's the
piece you add when you want a cloud copy of your backups — a proper disaster-recovery store,
independent of the server's filesystem, and the "off-site" leg of a 3-2-1 backup strategy.

Once installed, "AWS S3" appears as a destination type inside Backup & Migrate alongside the
built-in local and private-file destinations. You point it at a bucket (and optionally a
sub-folder), pick a region, and it uploads backups with the AWS SDK, lists and downloads them
through the Backup & Migrate UI, and restores from them like any other destination. It also
supports **S3-compatible** services — MinIO, Wasabi, DigitalOcean Spaces, Ceph — via a custom
endpoint, and understands **S3 Object Lock** (WORM) buckets, adding a SHA-256 checksum on upload
when a bucket has Object Lock enabled.

Crucially, **this module never stores your AWS credentials itself**. It relies on the **Key**
module: you create Key entities for your access key and secret key (or a single AWS
credentials-file key with the optional Key AWS module), and the destination just references them
by name, reading the values at runtime. That means you can rotate credentials centrally by
editing the Key entity, without reconfiguring the destination.

There is **no settings page of its own** — all configuration happens inside Backup & Migrate.
The module requires **Backup & Migrate 5.x**, the **Key** module, and the `aws/aws-sdk-php`
library (pulled in by Composer).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, the Key module, and the AWS SDK
   with Composer, then enable them.
2. [Configuration](configuration/index.md) — create Key entities for your credentials and add
   the S3 destination inside Backup & Migrate, field by field.

## Where it lives in the admin menu

The module adds no page of its own. You'll work in three existing places:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — create the Key entities
  that hold your AWS credentials.
- **Configuration → Development → Backup and Migrate → Settings → Destinations**
  (`/admin/config/development/backup_migrate/settings/destination`) — add and configure the AWS
  S3 destination.
- **Configuration → Development → Backup and Migrate** (`/admin/config/development/backup_migrate`)
  — run manual (Quick Backup) backups to the destination, or set up schedules.

## How to use it

At a high level:

1. **Store your AWS credentials as Key entities** (access key + secret key, or a single
   credentials-file key with Key AWS). Ideally keep the secret out of exported config by sourcing
   it from an environment variable — see [Configuration](configuration/index.md).
2. **Add an AWS S3 destination** in Backup & Migrate, entering the bucket, region, optional
   endpoint and sub-folder, and referencing your credential keys.
3. **Back up to it** — either run a Quick Backup and choose the S3 destination, or add it to a
   Backup & Migrate schedule for automated off-site backups.

Every field is explained on the [Configuration](configuration/index.md) page.
