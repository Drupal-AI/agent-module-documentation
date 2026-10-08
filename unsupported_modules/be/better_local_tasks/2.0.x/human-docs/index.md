# Better Local Tasks — manual setup guide

**Better Local Tasks** (`better_local_tasks`, project `betterlt`) gives Drupal's
local‑task tabs — the *View / Edit / Delete / Revisions / Translate …* tabs that
sit above content — a fancier, modern look. Instead of core's plain text tabs, you
get styled tabs with a small icon next to each action, applied automatically on the
front end.

It is a pure theming layer: no configuration, no permissions of its own, no
dependencies beyond core, and no JavaScript. Enabling the module is the entire
setup. It swaps in its own Twig templates for the local‑tasks block and menu, ships
a stylesheet and a set of action icons (edit, delete, revisions, translate, clone,
devel, shortcuts, view), and adds a semantic CSS class to each tab based on which
action it points to — so the styling knows which icon to show.

Two deliberate limits are worth knowing. The enhanced tabs apply only on
**non‑admin** routes (front‑end pages), leaving the admin theme's tabs untouched,
and the styling is attached only for users who can see contextual links (typically
editors and administrators). Everything is built on standard CSS classes
(`blt-tabs`), so you can layer your own theme's styles on top or copy the templates
into your theme to change the markup further.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page. Once enabled, the restyled tabs appear
automatically on front‑end (non‑admin) content pages for users who can see
contextual links.

## How to use it

There is nothing to configure. Enable the module (see
[Installation](installation/index.md)), then visit a front‑end content page such
as a node view as an editor or administrator: the primary and secondary tabs are
restyled with icons for View, Edit, Delete, Revisions, Translate, Clone, Devel, and
Shortcuts.

To customize further, override the `blt-tabs` CSS classes in your own theme, or
copy the module's local‑tasks templates into your theme to change the markup.
