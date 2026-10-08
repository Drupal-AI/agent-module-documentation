# Node Display Title — manual setup guide

**Node Display Title** (`node_display_title`) gives a node **two titles**: the normal
node title, which becomes the *admin/internal* title, and a separate **display
title** that is shown to site visitors. The admin title appears on admin pages and in
the edit form, so editors can keep a descriptive, findable name; the display title is
what the public sees when they view the content.

The classic case that inspired it: a multi‑site or multi‑domain setup where several
sections each have a page called "Services." To an administrator those identical
titles are confusing, so you give each a meaningful admin title ("MYS Services," "GMC
Services") while the visitor‑facing display title stays simply "Services." More
generally it's handy whenever the internal reference name and the public/SEO title
should differ.

Under the hood, enabling the module for a content type adds a **Display title** field
to it. When a node is viewed on the front end, that value automatically replaces the
node title (including in Views, Panels, and core search indexing); on admin pages and
on the node's own edit/delete forms the real admin title is kept. Using a display
title is **never forced** — leave it empty on a given node and the normal title is
used, so you can mix and match freely. The module depends on core's **Field** module
and provides permissions to control who can manage the setting and edit the field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content types use display
   titles, and set the permissions that control access to the field.

## Where it lives in the admin menu

After enabling, the settings form is at
**Configuration → Content authoring → Node Display Title** — direct path
`/admin/config/content/display-title-settings`. You need the *manage display title
field settings* permission to reach it.

## How to use it

1. Open the settings form and tick the content types that should offer a display
   title (see [Configuration](configuration/index.md)). This adds a **Display title**
   field to those types.
2. Grant editors the *access display title field* permission (or the per‑bundle
   variant) so the field appears on their node forms.
3. When creating or editing a node of an enabled type, fill in the **Display title**
   to override what visitors see, or leave it blank to keep the normal title.
