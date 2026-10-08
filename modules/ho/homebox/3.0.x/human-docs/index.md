# Homebox — manual setup guide

**Homebox** (`homebox`) lets site administrators build **personalizable
dashboards** for their users out of **draggable portlets**. An admin defines one
or more Homebox pages; each user can then arrange the portlet blocks on that page
into their own layout — resizing and reordering them by dragging, much like the
classic "My Yahoo" style of customizable homepage. Layout changes are saved
per‑user and autosaved over AJAX, so everyone keeps their own arrangement between
visits. (Homebox is the module that powers the "Your Dashboard" feature on
Drupal.org itself.)

Because portlets are built on Drupal's block system, anything that can be exposed
as a block can become a portlet — including Views with exposed AJAX filters,
whose filter settings are also remembered per user. Each Homebox page has its own
role‑based access permissions and can live at a custom path (via core's Path
module), and users can override block titles or set per‑block colours where
enabled.

The module depends on core **Layout Discovery** and **Path**, provides its own
permissions, ships two portlet submodules, and runs on Drupal 10.5 and 11.

> **Heads‑up on this release.** The 3.0.x branch is a complete rewrite with **no
> upgrade path from 2.x**, and it is not yet marked stable — the maintainers ask
> that you not use it in production until there's a stable release. It also relies
> on a core AJAX‑form bug fix; see [Installation](installation/index.md) for the
> patch note.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its portlet submodules, and note the core patch requirement.

There is **no single settings page** for the module — you configure it by creating
and managing individual Homebox pages, described in "How to use it" below.

## Where it lives in the admin menu

Homebox adds its own administration for creating and managing Homebox pages (each
with its own path, columns, and role access). Grant its permissions at **People →
Permissions**, and alias each Homebox page via core **Path**.

## How to use it

1. Enable Homebox plus the portlet submodule you need — most sites want
   **Homebox Portlet Type: Block** so ordinary blocks can be used as portlets (see
   [Installation](installation/index.md)).
2. Review Homebox's **permissions** at **People → Permissions**
   (`/admin/people/permissions`) — there are global Homebox permissions plus the
   ability to restrict individual Homebox pages by role.
3. **Create a Homebox page.** Define its path, its column layout, and which roles
   may access it. You can create as many Homebox pages as you need, and optionally
   expose one as a tab on the user profile.
4. **Add portlets.** Because portlets are blocks, make the blocks you want
   available as portlets, then let users add, remove, resize, reorder, and (where
   enabled) recolour them on their dashboard.
5. Each user's arrangement is saved automatically per user — no further action is
   needed once the page and its available portlets exist.
