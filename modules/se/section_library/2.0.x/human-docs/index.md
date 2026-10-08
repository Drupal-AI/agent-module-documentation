# Section Library — manual setup guide

**Section Library** (`section_library`) lets Layout Builder editors save any
single section — or a whole page of sections — as a reusable template and drop it
back into any other Layout Builder layout. It turns one‑off layout work into a
shared catalog of on‑brand patterns (hero banners, CTA blocks, testimonial grids,
pricing tables, full landing‑page templates) that non‑developers can reuse on the
fly.

The key design choice is that templates are **content, not configuration**. Every
saved section or page is a `section_library_template` content entity, so editors
create and reuse them without any config export/import or code. Because it is
content‑based, it happily runs alongside the config‑based *Layout Builder
Library* module rather than overlapping it.

Inside Layout Builder you get "Save to library" links (one per section, one for
the whole page) and a "Choose template from library" link that opens a
Views‑powered picker. Importing a template **deep‑clones** the stored sections —
generating fresh UUIDs and new block instances for any inline (non‑reusable)
blocks — so the copy is fully independent of the original. Saved templates are
managed at **Content → Section library**, and access is controlled by six
granular permissions so you can, for example, let a design team author templates
while general editors are limited to importing them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the six
   permissions, and how to manage saved templates.

## Where it lives in the admin menu

- **Manage saved templates:** **Content → Section library**
  (`/admin/content/section-library`).
- **Settings form:** **Configuration → Content authoring → Section library**
  (`/admin/config/content/section-library`).

## How to use it

1. Enable **Layout Builder** on a content type's display and edit a layout.
2. On any section, click **Add section to library** — or, from the top of the
   layout, save the whole page. Give it a label and (optionally) a preview image.
3. When editing another layout, click **Choose template from library**, pick a
   saved template from the picker, and it is imported (deep‑cloned) into the
   current layout.

For the label settings, permissions, and template management, see
[Configuration](configuration/index.md).
