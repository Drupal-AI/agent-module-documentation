# On-page Help — manual setup guide

**On-page Help** (`on_page_help`) lets you show the one piece of guidance a user
needs *on this page*, in a block that appears only on the pages — and for the people —
you target. It's a lightweight way to add contextual help or onboarding without
editing theme templates.

Each help item is a **content entity** (like a node): it has a body you write, full
**revision** history, and **translation** support, and it can be published or
unpublished. What makes it contextual is that each item is tied to a **route** (the
page it should appear on), and can optionally be restricted to specific **node types**
and to users who hold **all** of a listed set of **roles**. The **On-Page Help block**
looks at the current page, finds the first help item the current user is allowed to
see, and renders it. If no item exists yet and the user is allowed to add help, the
block instead shows an *"Add a new on-page help"* link that pre‑fills the current
route (and node type) for you.

Because a help item is a first‑class entity, you can define more than one **type** of
On-Page Help, each with its own block and its own generated permissions — so you can
delegate help authoring per type. Access is governed by a granular permission set and
enforced by a dedicated access‑control handler.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its dependencies.

Setup happens through the entity and block UIs rather than a single settings form,
described in "How to use it" below.

## Where it lives in the admin menu

Manage help items and types at **Structure → On-Page Help**
(`/admin/structure/on_page_help`). A default type, **Route On-Page Help**, ships with
the module. Place the block at **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. **Create (or use) a type.** Go to **Structure → On-Page Help** and either use the
   shipped **Route On-Page Help** type or add your own. Each type is independent and
   gets its own block and generated permissions. It's worth browsing the type's
   display settings and, for example, disabling the author from the main display.
2. **Place the block.** At **Structure → Block layout**, add an **On-Page Help block**
   to a region — the top of the **Content** region is a natural spot — and, in the
   block form, choose which On-Page Help **type** it should display. The block
   re‑resolves per page and per user (its cache contexts are the URL path and the
   current user).
3. **Add some help.** Navigate to a page that should have help; the block shows a
   placeholder with an **"Add a new on-page help"** link that pre‑fills the route (and
   node type, when you're on a node). Or add items from the entity add form. Each item
   has:
   - a **route** to match (for example `entity.node.canonical`),
   - optional **node types** to limit it to specific bundles,
   - optional **roles** the viewer must *all* hold to see it,
   - the help **body**, and a **publish** status.
4. **Understand which item shows.** For a given page the block picks the first
   published item that matches the route and type, passes the node‑type restriction,
   whose required roles the user holds, and that the user has permission to view. If
   several match, the one with the **lowest weight** wins. If there are no published
   items and the user may view unpublished help, the lowest‑weight unpublished item is
   shown instead.

## Permissions

On-page Help ships a granular permission set: `add`, `edit`, `delete`,
`view published`, and `view unpublished` on‑page help, plus revision permissions
(view all revisions, revert, delete revisions), per‑type permissions, and "own"
variants so authors can manage only their own items. `administer on-page help` is a
restricted permission. Grant these deliberately to decide who can author and see help.
