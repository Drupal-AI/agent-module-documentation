# PrevNext — manual setup guide

**PrevNext** (`prevnext`) adds "Previous" and "Next" links to an entity's display so
visitors can page through sibling entities of the same type and bundle — the next
article, the previous lesson, and so on. It's the classic "read the next post"
navigation, and it works on nodes, taxonomy terms, or any custom fieldable entity
type that has a canonical (full‑page) URL.

Neighbours are found by **entity ID order**, within the current bundle and the
current content language, and only **published** entities are considered. So on an
article page, "Previous" links to the published article with the next‑lower ID and
"Next" to the one with the next‑higher ID. An optional **infinite loop** setting
wraps around, so the newest item's "Next" jumps back to the oldest and vice versa.
Access respects entity permissions, so people never get links to content they can't
view.

You turn PrevNext on per entity type and per bundle on one small settings page, then
choose how the links appear. There are three ways to render them, and you pick
whichever fits: as fields on the entity's **Manage display** tab, as a **block** you
place on entity pages, or as a **Views field** inside a listing. Output is cached and
automatically refreshed when a sibling is saved, and you can restyle the links with a
Twig template override.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Its settings form is at **Configuration → User interface → PrevNext**
(`/admin/config/user-interface/prevnext`).

## How to use it

Setup is two steps: enable PrevNext for the content you want, then choose how the
links render.

### 1. Enable it for entity types and bundles

1. Log in as a user with the **administer prevnext** permission.
2. Go to **Configuration → User interface → PrevNext**
   (`/admin/config/user-interface/prevnext`).
3. The form lists every eligible entity type (fieldable types with a canonical URL).
   Tick the types you want, and for each, tick the specific **bundles** — for example
   only the *Article* node type.
4. Optionally tick **infinite loop** to make navigation wrap around from the last
   item to the first (and back).
5. **Save.** Enabling a bundle only makes the links *available* — you still choose a
   render method below.

### 2. Choose how the links appear

Pick whichever one method suits the page:

- **Manage display fields** — on the entity type's *Manage display* tab you'll find
  two new components, *Previous* and *Next*. Turn them on and drag them into place
  among the other fields.
- **Block** — place the **PrevNext links** block (in the *Other* category). It shows
  the links on canonical entity pages where the bundle is enabled.
- **Views field** — add the **PrevNext links** field to a View whose rows are the
  enabled entity type.

### Permissions

Grant the blanket **view prevnext links** permission to let users see the links
across all enabled types, or use the more specific per‑entity‑type permissions
(**view {entity type} prevnext links**) to allow them only for certain types.

### Theming

The links render through a `prevnext.html.twig` template. Copy it into your theme and
clear caches to restyle them. Developers can also fetch neighbour IDs in code via the
`prevnext.service` (`getPreviousNext()` / `buildEntityLinks()`).
