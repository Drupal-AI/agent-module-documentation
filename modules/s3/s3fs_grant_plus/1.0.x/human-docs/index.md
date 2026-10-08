# S3 File System Grant Plus — manual setup guide

**S3 File System Grant Plus** (`s3fs_grant_plus`) is a small extension to the
**S3 File System** (`s3fs`) module. When s3fs uploads or copies a file to Amazon
S3, this module adds a `GrantRead` ACL to that object for a **second AWS account**,
giving that account read-only access to the file.

The problem it solves is a common split-responsibility setup: one system (an
administrator app, or a back-office service) creates and owns the files, while
another set of consumers — often front-end users of a microservice — should only
ever *read* them, never modify or delete them. Rather than making files public or
patching s3fs, Grant Plus attaches a per-object read grant to exactly the account
you name, keeping least-privilege access across accounts.

There is very little to it. The module has no routes or controllers of its own. It
adds one field to the existing s3fs settings form and implements the s3fs upload
and copy alter hooks to inject the grant. You configure it after s3fs is working by
entering the reader account's canonical user ID; from then on, every newly
uploaded or copied object carries the grant. Files created before you configured
it are unaffected. It has no submodules and no PHP library requirements beyond
s3fs.

One important practical caveat from the module's own docs: because front-end users
are given read-only access, they cannot generate image-style derivatives on the
fly (that would require a write). The recommended workaround is to pre-generate all
image styles at upload time — for example with the **Image Style Warmer** module.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable
   alongside s3fs.
2. [Configuration](configuration/index.md) — set the reader account's canonical ID
   on the s3fs settings form (or lock it in `settings.php`).

## Where it lives in the admin menu

Grant Plus does not add a menu item of its own. Its single setting appears on the
**S3 File System** settings form at **Configuration → Media → S3 File System**
(`/admin/config/media/s3fs`, config route `s3fs.admin_settings`), protected by
s3fs's own **Administer S3 File System** (`administer s3fs`) permission.

## On security

The grant is an **object-level S3 ACL** to one specific AWS account, identified by
its canonical user ID — it does **not** make files public and it does **not** change
Drupal's own file-access checks. The setting is only editable by an s3fs
administrator (who already controls the bucket configuration). The module makes no
outbound HTTP calls and stores no secrets.
