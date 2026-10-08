# Configuration

In the 1.0.x branch, all setup happens on the **menu-link edit form**: you take a
link you curate by hand and turn it into a *dynamic parent* whose children are
generated from published content. There is no separate module settings page in
this branch (that arrives in 1.1.x — see the branch note in the
[overview](../index.md)).

## Turn a menu link into a dynamic parent

1. Go to **Structure → Menus** (`/admin/structure/menu`) and open the menu that
   holds your top-level navigation.
2. Edit the top-level link whose children you want to automate.
3. Open the **Menu Autopilot: children of …** section on that link's edit form.
4. Choose a **source** for the children:
   - **A taxonomy term** — the published nodes tagged with that term become the
     children.
   - **A content type** — all published nodes of that bundle become the children.
   - **A hand-picked ordered list of nodes** — you choose the exact nodes and
     their order.
5. Choose how the children are **sorted**: A→Z, by date, or **Keep current
   order** so you can drag them yourself on the menu overview. New matches append
   at the end.
6. Optionally set a **child label token pattern**, for example
   `[node:title] [node:field_subtitle]`, so navigation can show a subtitle
   without changing the page title. Leave it blank to use the node title.
7. Save the menu link.

## Enabling it on a parent that already has children

If the parent link already has children, the form asks how to treat them — reuse
matching links (optionally dropping extras), add only the missing ones, or
replace every child. An optional checkbox can move matching unmanaged links from
elsewhere in the same menu under this parent. Matching is done by node URIs and
path aliases, so an existing link like `/platforms/helios` is recognised as the
same destination rather than treated as a new one — which avoids duplicate links
when you first switch a hand-built menu over to automatic management.

## Staying in sync

Once a parent is configured, its children are created, updated, reordered,
reparented, and removed **automatically** as content is published, unpublished,
retyped, or deleted — there is nothing more to click. Generated links store
canonical entity references, so they always resolve to the node's real path alias
(never `/node/123` or an editorial route), which is what makes the menu safe for
decoupled/headless front ends. Synced links are also translatable and
language-aware.

## Reconcile on demand

After a bulk import, or any time you want to force a full reconciliation, run:

```bash
drush menu-autopilot:rebuild
```

This recreates, reorders, renames, and prunes the managed children from your
published content. It is safe to run repeatedly — a second run in a row makes no
changes.
