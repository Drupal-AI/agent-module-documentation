# SVG Icon Field — manual setup guide

**SVG Icon Field** (`svg_icon_field`) adds a new field type — **"SVG Icon"** —
that lets an entity store and render an SVG icon picked from a library of icons.
Out of the box it ships roughly 1,000 categorized SVG icons (released under the
CC0 licence, so you can use them for personal or commercial work without
attribution), grouped into themes such as *Business*, *Design*, *Internet*,
*Travel and transport*, *Weather* and more.

The problem it solves is a familiar one: you want editors to attach a small,
crisp, scalable icon to a piece of content — a service card, a menu entry, a
feature list — without uploading and managing image files by hand. Instead of an
image upload, editors get an icon picker; the chosen icon is stored on the field
and rendered inline as an SVG.

The module works by giving you a field type to add to any bundle. There is no
site-wide settings form — you configure it per field on that field's widget
settings, where you pick the default icon category and default icon. It depends
only on core's **Field** module, and it ships no submodules. Developers can
extend or replace the built-in icon sets with the
`hook_svg_icon_field_categories_alter()` hook.

A security note worth keeping in mind: a rendered inline SVG is **active markup**
— an SVG file can contain `<script>` and event handlers. Because this module
renders SVG inline, only offer icons from a **trusted source**. The bundled CC0
library is curated and safe; if you add your own icon sets through the hook,
treat those files as you would any code you place on your site, and avoid letting
untrusted users supply arbitrary SVG (that would be a stored‑XSS surface).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the SVG Icon field to a bundle
   and choose the default icon category and icon.

## How to use it

Once enabled, the field type appears when you add a field to any entity bundle
(a content type, taxonomy vocabulary, and so on). On the **Manage fields** screen
choose **SVG Icon** from the field type list (it sits in the *Reference*
section), then on the widget settings page pick which icon category and which
default icon editors start from. Editors then choose an icon when they create or
edit content, and the icon renders on the entity. See
[Configuration](configuration/index.md) for the step‑by‑step.
