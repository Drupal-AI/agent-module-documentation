# Noahs Page Builder — manual setup guide

**Noahs Page Builder** (`noahs_page_builder`, project `noahs`) is a
drag-and-drop visual page builder for Drupal. Editors open an entity — a node or,
for example, a commerce product — in a live iframe editor, drag in **widgets**
from a palette, and adjust each one with styling **controls** (spacing, colour,
background, typography, borders, and more). The finished layout is saved as JSON,
with the corresponding CSS generated for the front end, and rendered back to
visitors through the module's own response subscriber and Twig templates. It's a
no-code way to compose rich landing pages and layouts directly on the entity.

Under the hood the module is plugin-based: it ships roughly 35 **Widget** plugins
and 40 **Control** plugins, so there's a wide toolbox out of the box, and
developers can add more. It stores layouts in its own database tables rather than
in fields. Because it composes real content and media, it **depends on several
core modules** — Block content, Image, Media, Media Library, Views, Editor, and
Filter — which Composer and Drupal pull in for you.

A single permission, **Administer Noahs** (`administer noahs_page_builder`),
gates the entire module: the admin pages, the editor and preview, every builder
AJAX endpoint, media upload, and the save action. Treat that permission as a
**full-HTML / file-upload capability** and grant it only to fully trusted
editors — the builder can render arbitrary CSS and HTML to anonymous visitors,
and its media upload accepts files (including SVG) without a MIME/extension
allowlist. One optional submodule, **Noahs Gallery** (`noahs_gallery`), adds a
gallery configuration entity and media widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally Noahs Gallery), and grant the permission.
2. [Configuration](configuration/index.md) — the permission, the admin pages,
   and the global/style/iframe settings forms.

## Where it lives in the admin menu

The module's admin pages live under **Structure → Noahs**
(`/admin/structure/noahs`), with global settings at
`/admin/structure/noahs/settings`, a style editor at
`/admin/structure/noahs/settings_styles`, iframe settings at
`/admin/structure/noahs/settings_iframe`, and an icon browser at
`/admin/structure/noahs_page_builder/icons`.

## How to use it

1. Grant the **Administer Noahs** permission to the trusted roles that should
   build pages (see [Configuration](configuration/index.md)).
2. Open a node (or other supported entity) and use the **Edit with Noahs** local
   task, or go directly to `/noahs_edit/{entity_type}/{entity}`.
3. Drag widgets in from the palette. Select a widget to edit its controls —
   spacing, colour, background, typography, borders, and so on.
4. Save. The layout is written to the module's storage, its CSS is generated,
   and the built page is rendered to visitors on the front end.
