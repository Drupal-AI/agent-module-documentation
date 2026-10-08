# File entity — manual setup guide

**File entity** (`file_entity`) turns Drupal's core file into a first-class,
fieldable entity. Out of the box a Drupal file is a thin record — a URI and a
little metadata. File entity extends it so files behave like nodes: you can group
them into **types** (bundles), attach **fields** to each type, give them **view
displays**, and render them with field formatters. A file gets its own page at
`/file/{file}` and can be listed and templated through Views and Token.

In practice this means you can define file types — typically by MIME, such as
image, document, video, or audio — and then attach fields to each type: captions,
credits, rights statements, alt-text metadata, and so on. Each file type is an
entity bundle with its own form and view displays. The module also adds a file
administration listing at `/admin/content/files`, a file-type UI at
`/admin/structure/file-types`, an add/upload flow, inline editing, and download,
delete, and archive/bulk-delete tooling.

Access is enforced through a full permission set (from `view files` and
`view private files` up to `administer files` and a `bypass file access` escape
hatch), complemented by per-type permissions. It is the long-standing successor to
the Drupal 7 "fieldable files" pattern and integrates with the wider media
ecosystem.

> **Note for Drupal 8+ sites:** if you are building a new site, core's **Media**
> module is the recommended way to handle rich file/media metadata. File entity
> continues to support existing installs and the use cases below (fieldable files,
> per-type handling, dedicated file pages, file listings in Views).

It depends on core's **File**, **Text**, **Views**, **Image**, and the
contributed **Token** module, and targets Drupal 10.5 and 11.2.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in its dependencies, and enable it.
2. [Configuration](configuration/index.md) — file types, fields and displays, the
   settings form, and the permission set.

## Where it lives in the admin menu

- **File settings** — **Configuration → Media → File settings**
  (`/admin/config/media/file-settings`).
- **File types** — **Structure → File types** (`/admin/structure/file-types`).
- **File administration listing** — **Content → Files**
  (`/admin/content/files`).
