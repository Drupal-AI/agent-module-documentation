# Structure Map — manual setup guide

**Structure Map** (`structure_map`) documents your site's information
architecture. Pick an entity type and bundle — a content type, a taxonomy
vocabulary, a media type, and so on — and it lays out the fields on that bundle,
its form and view display modes with their widgets and formatters, and which roles
can create, edit, and delete it. It can also export the same information across
many bundles at once to an XLSX spreadsheet.

The problem it solves is understanding a complex or inherited site. When a site
has grown to many entities and bundles, it becomes hard to hold the whole
structure in your head or to hand it off to another team. Structure Map gives you
a readable overview of that architecture — and a spreadsheet snapshot you can
share — without reading configuration YAML by hand. It is useful for audits,
documentation, and getting your bearings before you make changes.

Structure Map is **read-only reporting**: it creates no content and changes no
configuration; it only reports on what already exists. Every one of its pages is
gated by the strong **Administer site configuration** permission, so there is no
anonymous or content-changing surface, and the entity-type and bundle values in
its URLs are constrained and resolved through Drupal's entity system, so they
cannot reach anything an administrator could not already view. It works the moment
you enable it — the module states that **no configuration is required** — and it
depends on several core modules plus the `phpoffice/phpspreadsheet` library (pulled
in by Composer) for the spreadsheet export.

This guide is written for a **human** working through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Structure Map adds a section under **Structure → Structure Map**
(`/admin/structure/map`). All of its pages require the **Administer site
configuration** permission.

## How to use it

No configuration is needed — enable the module and use the admin pages.

**View one bundle**

1. Go to **Structure → Structure Map** (`/admin/structure/map`).
2. In the filter form, select an **entity type** and a **bundle**.
3. The resulting table shows the bundle's basic entity information, the editorial
   permissions per role (who can create/edit/delete it), its form and view display
   modes, and each field with its type and settings. Options on the form let you
   additionally show relationship (entity-reference) information and include hidden
   fields.

**Export many bundles**

1. Go to **Structure Map → Export** (`/admin/structure/map/export`).
2. Choose the entity types and bundles to include, and submit.
3. The module builds an **XLSX** spreadsheet (using `phpoffice/phpspreadsheet`)
   that you download — a snapshot of the selected architecture, handy for
   documentation or handing a site off to another team.
