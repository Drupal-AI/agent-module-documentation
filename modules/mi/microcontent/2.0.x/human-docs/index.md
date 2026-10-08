# Micro-content — manual setup guide

**Micro-content** (`microcontent`) gives you a lightweight, reusable content entity
for the small pieces of content that don't really deserve to be full nodes —
promos, callouts, disclaimers, snippets, notices. Instead of scattering these into
blocks or one-off nodes, you manage them as first-class, fieldable entities with
their own types, and reference them wherever you need them.

Like nodes, micro-content items are **fieldable, revisionable, translatable**, and
have an owner and a published/unpublished status. You define one or more
*micro-content types* (the equivalent of content types), attach whatever fields you
like to each type with Field UI, and then create items of those types. The entity
supports core Content Moderation workflows too, so snippets can go through the same
editorial process as the rest of your content.

There is no global settings form — the module's `configure` link is empty on
purpose. "Configuring" Micro-content means creating types and adding fields to them,
which you do through the standard entity admin UI. The module depends only on core's
**User** and **System** modules, and provides a full set of permissions (including
per-type create/edit/delete grants). It optionally integrates with **Entity Browser**
(for picking items) and with the **Backfill Formatter** module (to show a fallback
value for empty references).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — creating micro-content types, adding
   fields, permissions, and the optional Entity Browser / Views config.

## Where it lives in the admin menu

- **Types** (the bundles) live at **Structure → Micro-content types**
  (`/admin/structure/microcontent-types`). This is where you add types and, with
  Field UI enabled, manage their fields, form display, and display.
- **Items** (the actual content) live at **Content → Micro-content**
  (`/admin/content/microcontent`), where you list, add, edit, and delete them.
