# View Modes Display — manual setup guide

**View Modes Display** (`view_modes_display`) is a display‑debugging tool for
site builders and themers. Once enabled, it adds a **Preview** tab and operation
link to every content entity that has view modes, letting you render that entity
in each of its enabled view modes so you can see exactly how it looks — without
placing it in a listing, a View, or Layout Builder first.

From an entity's preview you can compare all its view modes on one page (Full vs.
Teaser vs. a custom "Card" or "Search result" mode), verify which display modes
are actually enabled for a bundle, and debug why a field renders in one view mode
but not another. It works for any content entity type — nodes, taxonomy terms,
media, users — and it special‑cases custom block (`block_content`) entities so
they preview correctly through the Block system. The default `full` view mode is
always available even when no custom display is enabled.

The module has **no settings form and no configuration** — it's purely a
previewing tool. The only thing to set up is who can use it: access is gated by
the restricted **Preview entities in all available view modes**
(`preview view modes`) permission. Grant it only to trusted site builders (see
the caveat below). It requires nothing beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the preview permission.

## Where it lives in the admin menu

There is no dedicated admin page. The module adds:

- A **View Mode Preview** local tab on each entity's canonical page.
- A **Preview** operation link on entity list rows (for example, the content
  admin table at `/admin/content`).

Both lead to a preview at
`/{entity_type}/{id}/view-mode/preview/list`, which lists every enabled view mode
as a link; each link renders the entity in that single mode. You grant the
permission at **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Grant the **Preview entities in all available view modes** permission to your
   builder/themer role at **People → Permissions**.
2. Browse to a piece of content (or open the content list) and click **Preview**
   (the tab on the entity page, or the operation link in the list).
3. You land on a list of the entity's enabled view modes. Click any one to render
   the entity in just that mode, or use the "all" option to see every enabled mode
   on a single page, each wrapped in a labeled block.

This is handy for QA during theme work, confirming a newly added view mode is
picked up before wiring it into Views or Layout Builder, and reviewing
image‑style or field‑visibility differences across view modes.

> **Security caveat — scope the permission tightly.** The preview routes check
> only the `preview view modes` permission; they do **not** apply the usual
> per‑entity view‑access check. Anyone holding the permission can therefore view
> the rendered output of *any* content entity by URL — including unpublished or
> otherwise view‑restricted content. This is intended (it's a restricted,
> trusted‑builder capability), but grant it only to roles you would trust to see
> every entity on the site, never to lower‑trust editorial roles.
