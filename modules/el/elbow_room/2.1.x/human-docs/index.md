# Elbow room — manual setup guide

**Elbow room** (`elbow_room`) adds a toggle that lets editors **hide the sidebar**
(the second "advanced" column) on node add/edit forms, giving them a wider main
editing area. On content forms, core groups things like authoring information,
revision settings, URL alias, and other "advanced" options into a sidebar column;
that's useful, but it also narrows the space for the body and main fields. Elbow
room lets an editor collapse that sidebar to reclaim the horizontal room, and expand
it again when they need it.

It's purely an editing-UX convenience. It changes no data, hides no fields from
saving, and grants no access — core field access still governs what an editor may
edit and save. The module ships a little CSS/JS (including a small state script that
remembers the toggle client-side) and attaches it to the node form; there are no new
entities, no extra routes beyond its settings form, and no database tables. It works
on standard node add and edit forms and is compatible with Claro/Gin-style admin
themes. It has no runtime dependencies beyond Drupal core, and it's safe to enable
or disable without any data migration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — grant the permission and adjust the
   options.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Elbow room**
(`/admin/config/content/elbow-room`, route `elbow_room.settings`), gated by the
**Administer elbow room settings** permission.

## How to use it

Once enabled and permitted, editors see a toggle on the node add/edit form to
collapse or expand the sidebar. Collapsing it widens the primary body/field editing
column; the chosen state is remembered client-side between forms. It's especially
handy on sites where many advanced sidebar groups clutter the form, and it pairs well
with modules that add extra vertical-tab groups.
