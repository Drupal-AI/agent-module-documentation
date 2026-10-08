# Edit + — manual setup guide

**Edit +** (`edit_plus`) brings **inline, in‑place editing** to the front end of a
Drupal site: authorized users see a thing, click a thing, and change a thing —
editing content directly on the rendered page instead of going to a separate edit
form. It's a component of the **+Suite** page‑building family, adding the **Change**
tool to +Suite's **Edit Mode**. Edits are powered by the normal Drupal entity
form, so you can `hook_form_alter` or extend them exactly as usual, and there's a
plugin system for building slick inline widgets (falling back to the standard form
element when no custom widget exists).

It's a substantial module. It depends on two other projects —
[Tempstore Plus](https://www.drupal.org/project/tempstore_plus) (`tempstore_plus`)
and [Twig Events](https://www.drupal.org/project/twig_events) (`twig_events`) — and
it ships a large set of optional submodules for building blocks and landing pages
(CTA, header, image, teaser blocks, a landing page, a layout block, and Layout
Builder / non‑Layout‑Builder node integrations). It provides its own permissions
and some Drush commands.

Like any in‑place editing tool, **who can change what is governed by its
permissions plus the underlying entity and field edit access**. That's the safe
default: a user can only change content they already have edit access to, and
inline editing should never expose editing to someone who lacks it. When you set it
up, grant the Edit+ permissions to the right roles and verify that inline editing
isn't handing edit access to users who shouldn't have it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Tempstore Plus and Twig Events dependencies, and enable the submodules you
   need.

There is **no single central settings form** documented for this module — you
configure it through **permissions** (People → Permissions) and by enabling the
submodules that match the blocks and page types you build with. How it fits
together is described below.

## How to use it

1. Enable Edit + and the submodules for the block/page types you want (see
   [Installation](installation/index.md)).
2. Grant the **Edit +** permissions to the editor roles that should be able to edit
   inline — and confirm those roles already hold the underlying entity/field edit
   access.
3. As an authorized user, browse to a page and enter **Edit Mode**; the **Change**
   tool lets you click a piece of content and edit it in place, using the normal
   entity form rendered inline.

> **Check your permissions carefully.** Inline editing is only as safe as the edit
> access behind it — grant the Edit + permissions to trusted editor roles, and
> verify that turning on inline editing hasn't exposed editing to anyone who lacks
> the underlying access.
