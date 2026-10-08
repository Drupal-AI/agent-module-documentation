# Private Files Download Permission — manual setup guide

**Private Files Download Permission** (machine name `pfdp`, project
`private_files_download_permission`) controls who may download files out of
Drupal's **private file system**. You register one or more directory paths and,
for each, list the roles and/or individual users allowed to read from it.
Anyone not on the list is denied — and, importantly, a private file that lives in
*no* registered directory is denied too, so the module gives you a positive,
auditable allow-list of who can read what.

This fills a real gap: Drupal's private file system keeps files out of the web
root, but out of the box it does not give you an easy, configurable way to say
"only the finance role may download files under `/billing`" or "let this one named
user reach `/contracts`". With this module you express those rules as
configuration, per directory, with support for role-based access, per-user
access, and an option to always let a file's own uploader download it. Nested
directories are matched by longest path, so the most specific rule wins.

A settings page adds a handful of behavioural options — forcing downloads to save
as attachments, immediate streaming for large files, and a debug log to explain
why a particular download was allowed or denied. Because everything is stored as
configuration, you can deploy download permissions between environments and prove
to auditors exactly which roles can read a private directory.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and make sure the private file system is configured.
2. [Configuration](configuration/index.md) — register directories with their
   allowed users and roles, and the behavioural settings.

## Where it lives in the admin menu

Once enabled, the module lives at **Configuration → Media → Private files
download permission**
(`/admin/config/media/private-files-download-permission`). That page lists your
registered directories with **Add**, edit and delete forms, and has a **Settings**
child page for the behavioural options. Both require the **Administer Private
files download permission** permission.

## How to use it

Decide which private directories need controlled access, register each one, and
list the roles and/or users allowed to download from it. Files placed in those
private directories are then only downloadable by the people you have granted —
everyone else gets access denied. See
[Configuration](configuration/index.md) for the step-by-step, and
[Installation](installation/index.md) for the private-file-system prerequisite.
