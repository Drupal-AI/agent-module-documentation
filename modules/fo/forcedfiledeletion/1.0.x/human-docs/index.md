# Forced File Deletion — manual setup guide

**Forced File Deletion** (`forcedfiledeletion`) lets a trusted administrator
**completely delete a managed file — even when Drupal would normally refuse**
because the file's usage count is not zero. It extends Drupal's file‑delete
confirmation flow so that, on confirmation, the physical file is removed from disk
(`unlink()`) as well as from Drupal's records.

To make this safer to live with, the module also tidies the file view: it hides
delete links from users who lack permission to delete a file, and from files that
no longer exist on disk. It changes the warning and button text when a file still
has usage, so the person confirming understands they are forcing the deletion. It
adds its own **"forcibly delete a file"** permission that grants this override.

> **This is destructive and irreversible.** Forcing a deletion removes the actual
> file, bypassing the usage checks that normally protect files still referenced by
> content. Anything still pointing at that file **will break**, and there is **no
> undo**. Grant the "forcibly delete a file" permission only to trusted
> administrators, and be certain before you confirm a forced deletion.

The module has no anonymous or web‑facing surface beyond the file‑delete access it
extends and its own permission. It is a rework of the older, unmaintained (and
misnamed) *Force File Delete* module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission carefully.

There is **no configuration form** for this module. Its behaviour is controlled by
the **"forcibly delete a file"** permission and appears on the standard file
delete flow, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page. It works through the existing file‑delete
confirmation flow, and its permission is set at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Grant the **"forcibly delete a file"** permission (People → Permissions) to
   the trusted role(s) that should be allowed to force deletions — and only those.
2. When such a user deletes a managed file whose usage count is non‑zero, the
   confirmation page shows the adjusted warning and button text explaining that
   the file will be forcibly deleted.
3. On confirmation, the file is removed from disk and from Drupal's records.
   Remember: anything still referencing it will now be broken, and this cannot be
   undone.
