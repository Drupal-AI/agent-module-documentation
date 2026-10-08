# File Crusader — manual setup guide

**File Crusader** (`file_crusader`) tightens file access control by making a public
file's reachability follow its parent content's **publishing state**. It addresses a
gap in Drupal core: a file stored in the public file system stays reachable by its
direct URL even after the content it was attached to (a node or media entity) is
unpublished. Search engines and anyone with the link can still fetch it. File
Crusader closes that gap by programmatically relocating such files into a protected,
inaccessible location when their parent entity is unpublished — so files genuinely
respect the publish/unpublish state of the content they belong to.

Its key behaviors:

- Automatically moves public files to an inaccessible path when their parent entity
  is unpublished.
- Respects the publish/unpublish status of **all** parent entities before acting, so
  a file still referenced by another *published* entity is not hidden.
- Shows a warning when a file cannot be unpublished because it is still actively
  referenced elsewhere.
- Supports unpublishing a single media entity's file when its media parent is
  unpublished.

Typical uses are preventing unpublished content from leaking its associated files by
direct URL, and improving the security posture of sites with sensitive or restricted
media. It depends only on core's File module.

> **Maturity:** this is an **alpha** release (1.0.0-alpha…) and is **not covered by
> Drupal's security advisory policy**. Treat file moves as a privileged, potentially
> disruptive operation — back up first and run it as a trusted operator — and test it
> thoroughly against your own content workflow before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

File Crusader adds no dedicated admin configuration page. It acts automatically in
response to a parent entity's publish/unpublish state, relocating the associated
public files.

## How it works

When you unpublish content that has files attached in the public file system, File
Crusader checks whether any *other* published entity still references each file. If
nothing published references it, the file is moved to an inaccessible location so it
can no longer be fetched by its public URL. If a file is still referenced by
published content, it is left in place and you are warned that it cannot be
unpublished. Re-check your content after unpublishing to confirm the files behaved as
you expected — and because the module rewrites file references and touches the
filesystem, always keep a backup and operate it as a trusted administrator.
