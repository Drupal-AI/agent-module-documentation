# Entity Clone Template — manual setup guide

**Entity Clone Template** (`entity_clone_template`) builds on the **Entity Clone**
module to give editors a friendly "start from a template" workflow. Editors mark
certain nodes as reusable **content templates**, give each one a **preview image**,
and then start new content by picking a template from a visual gallery page — the
chosen template is cloned into a fresh node they can edit.

You turn the feature on per content type with a single checkbox on the content‑type
form. Once a type is enabled, its node edit form gains an **Entity Clone Template**
section where an editor can flag the node as a template and upload a preview image.
A bundled View lists every template‑flagged node with its thumbnail at
`/admin/content/clone-content-from-template`, so an editor can browse the available
starting points and clone one. To keep things tidy, the module automatically clears
the template flag and image on any clone, so copies never accidentally become
templates themselves.

This is handy for landing‑page teams, branded document skeletons, event or case‑study
layouts, and any situation where people repeatedly build similar content. Templates
are just normal nodes, so they remain revisionable, translatable, and
permission‑controlled. The module depends on **Entity Clone**, **Views**, and the
**Image** module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Entity Clone)
   and enable the module.
2. [Configuration](configuration/index.md) — enabling the feature per content type,
   marking a node as a template, the gallery, and the permission.

## Where it lives in the admin menu

There is **no dedicated settings page**. You enable the feature on each content
type's edit form (*Structure → Content types → [type] → Edit*), mark templates on the
node add/edit form, and browse them at **Content → Clone content from template**
(`/admin/content/clone-content-from-template`).

## How to use it

1. On the content type you want to template, edit the type and tick **Enable Entity
   Clone Template**.
2. Create (or edit) a node of that type, tick **Allow content to be defined as a
   template**, and optionally upload a preview image. Save it.
3. When you need a new page, go to
   **Content → Clone content from template**, pick a template from the gallery, and
   the standard Entity Clone flow creates a new node from it — which you then edit and
   save.

See [Configuration](configuration/index.md) for the details, including the permission
that controls who may define templates.
