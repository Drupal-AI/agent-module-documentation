# Admin Toolbar Content — manual setup guide

**Admin Toolbar Content** (`admin_toolbar_content`) reshapes the **content** area of
the Admin Toolbar so editors can jump straight to a content type's listing or its
"add" form, instead of always going through `/admin/content` and filtering. Admin
Toolbar turns Drupal's toolbar into full drop‑downs, which is great for configuration
but leaves content behind a single generic *Content* link. For an editor working
across many content types, that's the wrong shape — and this module fixes it by
expanding the toolbar's content section with per‑type entries and related shortcuts
(content types, and things like media types and taxonomy vocabularies).

It builds specifically on the **Admin Toolbar Tools** submodule — the part of Admin
Toolbar that provides the expanded menus — so it depends on both `admin_toolbar` and
`admin_toolbar_tools`, not just the base module. It adds no permissions of its own:
each entry follows the underlying route's normal access rules, so an editor only ever
sees links to things they could already reach. In other words, it changes how the
toolbar is *composed*, never what a user is allowed to do.

For developers, the module defines a plugin type
(`AdminToolbarContentPluginInterface` and its manager), so other modules can
contribute their own toolbar sections rather than this module hard‑coding a fixed
list.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, and
   enable it alongside Admin Toolbar and Admin Toolbar Tools.

## Where it lives in the admin menu

There's a settings form at **Configuration → User interface → Admin Toolbar Content**
(`/admin/config/user-interface/admin-toolbar-content`), gated by the **Administer site
configuration** permission, where you control which content entries appear. The main
effect, though, is seen in the toolbar itself.

## How to use it

1. Make sure Admin Toolbar and Admin Toolbar Tools are enabled, then enable this
   module (see [Installation](installation/index.md)).
2. Hover over the **content** area of the Admin Toolbar. Instead of a single
   *Content* link, you'll see per‑type entries — jump straight to a type's listing,
   or to its "add content" form in one click.
3. If you want to tune which entries appear, open the settings form at
   `/admin/config/user-interface/admin-toolbar-content`.

This is aimed at editors on multi‑type sites: it speeds up editorial navigation and
reduces reliance on the `/admin/content` filters.
