# Mercury Editor — manual setup guide

**Mercury Editor** (`mercury_editor`) replaces Drupal's ordinary, stacked entity
edit form with a full‑screen, **drag‑and‑drop page builder**. Instead of scrolling a
long form, editors work on a live‑preview canvas with an "edit tray" beside it:
they insert components, drag them into place, and style them, seeing the result
update as they go. It is built on top of **Layout Paragraphs** (which supplies the
components and layouts) and **Style Options** (which supplies the visual styling
controls).

You switch it on per bundle. For each content type — or taxonomy term or custom
block type — you enable, Mercury Editor takes over the "edit" experience and opens
its builder at `/mercury-editor/{entity}` instead of the standard form. Because it
sits on Layout Paragraphs, the bundle must already have a Layout Paragraphs field
for the builder to have something to edit. Changes are held in a private draft
(tempstore) so editors preview them before the entity is actually saved.

Mercury Editor has no permissions of its own — access is governed by core's
*Administer site configuration* (for its settings) plus the underlying Layout
Paragraphs and entity permissions. Two submodules extend it: **Mercury Editor
Templates** adds reusable, drop‑in section templates, and Mercury Editor Inline
Editor is a deprecated shim you should not use (its successor is
`mercury_editor_live_edit`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the Layout
   Paragraphs and Style Options dependencies, and the submodules.
2. [Configuration](configuration/index.md) — enabling Mercury Editor per bundle and
   every option on the settings pages.

## Where it lives in the admin menu

The settings live at **Configuration → Content authoring → Mercury Editor**
(`/admin/config/content/mercury-editor`), gated by core's **Administer site
configuration** permission. That page has sibling tabs for skip‑create‑form
settings, the component menu, and dialog/UI settings. The builder itself opens at
`/mercury-editor/{entity}` when you edit an enabled entity.
