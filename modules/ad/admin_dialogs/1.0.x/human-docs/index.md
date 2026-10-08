# Admin Dialogs — manual setup guide

**Admin Dialogs** (`admin_dialogs`) lets you make existing admin links and forms
open in a **modal** or **off‑canvas** dialog instead of loading a whole new page —
all through the UI, with no code. Think of the *Edit* and *Delete* operation links
on a content list, the tabs on an entity edit screen, the "Add" action links, or any
link you can target by path or CSS selector: Admin Dialogs can stamp the right
behavior onto them so they pop open in place.

It does this by adding two small configuration entity types — **Dialog Group**
(a labelled container to organize your rules) and **Dialog** (one rule) — plus a
short global settings form. Each Dialog says *what* to target (operation links,
local tasks, local actions, specific paths, or CSS selectors), *how* to present it
(modal or off‑canvas, a width, an optional title), and *where* it applies (by entity
type and bundle, route, path, or selector). At render time the module quietly adds
Drupal's own AJAX dialog attributes to the matching links.

The module ships around 40 ready‑made Dialog configs for common core and contrib
admin pages (menus, fields, image styles, Pathauto, Redirect, Linkit, Media and
more), which install automatically when the relevant module is present — so you get
a nicer admin experience out of the box and can add your own rules on top. It pairs
especially well with Admin Toolbar for a faster editorial workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Dialog Groups screen, the two
   config entities, the five dialog types, and the global settings form.

## Where it lives in the admin menu

Once enabled, manage your dialogs at **Configuration → User interface → Dialog
Groups** (`/admin/config/user-interface/dialogs`). The global settings form sits
just beside it at `/admin/config/user-interface/dialogs/settings`. Everything here
is gated by a single **Administer dialogs** permission. Remember to clear caches
after you change a dialog config — the rules alter cached render output.
