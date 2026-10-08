# Smart Title — manual setup guide

**Smart Title** (`smart_title`) turns a content entity's label — a node title, a
term name, a media name — into a configurable pseudo-field on the *Manage
display* form. Normally the label is printed by the theme template, so a site
builder can't move it, restyle it, or hide it without custom code. Smart Title
exposes the label as an extra field called `smart_title` that you can drag among
your other fields, wrap in a chosen HTML tag with CSS classes, optionally link to
the entity, or leave out entirely — all per entity type, per bundle, and per view
mode.

Setting it up is a two-step idea. First you mark **which bundles are eligible**;
the optional **Smart Title UI** submodule provides a small admin page for that.
Then, on each view mode's *Manage display* form, you switch Smart Title on for
that display and choose the title's tag, classes, and link behaviour. Because
every choice is stored in the view-display configuration, it exports cleanly with
the rest of your config and can differ from one view mode to the next.

Smart Title has **no configure route in the core module** (`configure` is `null`)
— the admin page comes from the UI submodule — and it defines no plugins or Drush
commands. Note that it is aimed at ordinary and Field Layout displays; it
deliberately steps aside on Layout Builder-enabled displays.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config keys and the
per-display third-party settings — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module plus the optional UI submodule.

## How to use it

**Step 1 — make a bundle eligible.** With the **Smart Title UI** submodule
enabled, go to **Configuration → Content authoring → Smart Title**
(`/admin/config/content/smart-title`, permission *Administer smart title*) and
tick the entity types / bundles you want to control. (Only entity types whose
label isn't already display-configurable are offered.) This adds a hidden
`smart_title` field to those bundles' displays.

**Step 2 — enable it on a view display.** On the bundle's **Manage display** page
for a given view mode, open the **Smart Title** section and tick **Make entity
title configurable**. Then set:

- **Tag** — the wrapper element: `h1`–`h6`, `div`, `span`, or none. Default `h2`.
- **Classes** — CSS classes to put on the wrapper. Defaults to something like
  `node__title`.
- **Link** — whether to wrap the title in a link to the entity. Default on.

Save, then drag the **Smart Title** field out of the *Disabled* area into the
region and position where you want the title to appear. The theme's original
title is automatically suppressed so it isn't printed twice.

Since this is configured per view mode, you might, for example, show a linked
`<h1>` on the full page, a linked `<h3>` in teasers, and hide the title
completely in a minimal listing view mode.
