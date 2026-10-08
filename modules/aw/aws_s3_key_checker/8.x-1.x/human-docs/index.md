# AWS S3 Key Checker — manual setup guide

**AWS S3 Key Checker** (`aws_s3_key_checker`) is a small admin utility that
verifies whether a list of object keys actually **exists** inside an AWS S3
bucket. You register one or more bucket names, paste in a list of keys, and the
module checks each one with a lightweight S3 `HEAD` request — no files are
downloaded — then reports which keys are present and which are missing.

It is handy for verification and auditing tasks: confirming that uploaded assets
really landed in the bucket, checking that backups or expected report files were
written, or spot‑checking keys reported by another system before a migration or
deploy.

Both of its screens require the core **Administer site configuration** permission,
so this is an administrator‑only tool. Credential handling is done the secure way:
AWS keys are **not** stored in Drupal config — you either put them in `settings.php`
or rely on an IAM instance role (see below).

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register buckets, supply AWS
   credentials, and run a key check.

## Where it lives in the admin menu

The module adds two screens under **Configuration → AWS → S3**:

- **Settings** — `/admin/config/aws/s3/key-checker` (register buckets, choose the
  credential source).
- **Check** — `/admin/config/aws/s3/key-checker/check` (run a key‑existence check
  against a chosen bucket).
