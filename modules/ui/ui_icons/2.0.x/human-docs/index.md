# UI Icons — manual setup guide

**UI Icons Form element** (`ui_icons`) is a generic icon manager for Drupal. It
builds on top of Drupal core's **Icon API** (introduced in 11.1) to let you define
**icon packs** — from SVG files, SVG sprites, web fonts, or third-party providers —
and then pick and render those icons throughout Drupal's site-building tools:
fields, menus, CKEditor 5, media, and more. It ships with no third-party icons of
its own; instead it makes it easy to add existing icon sets (Bootstrap Icons,
Font Awesome, Material Symbols, Lucide, Tabler, and many others) or your own.

The important thing to understand about the base module is that it is deliberately
minimal: on its own, `ui_icons` provides **only the icon autocomplete form
element** and its supporting services (icon search, preview, and Twig helpers). It
has **no configuration UI, no permissions, and no Drush commands**. All the
integrations you'll actually reach for — icon fields, menu icons, CKEditor
embedding, an icon library page — come from its **submodules**, and the icon packs
themselves are declared in YAML (`EXTENSION.icons.yml`) rather than through an
admin form. Icons are addressed as `pack_id:icon_id`.

Version 2.0 targets **Drupal 11.3+** (and 12). If you're on Drupal 11.1/11.2, the
1.1.x branch is the one for you.

This guide is written for a **human** setting things up. Because UI Icons is
configured through YAML icon-pack definitions and submodules rather than a settings
page, there is no click-through configuration guide here. For terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the integration submodules you need.

There is **no configuration page** for this module (`configure` is null). Icon
packs are defined in YAML and the integrations are provided by submodules — see
"How to use it" below.

## Where it lives in the admin menu

The base module adds no admin settings page. The optional **UI Icons Library**
submodule adds an admin overview page that lists every icon available on the site
(useful as documentation for editors or a showcase for clients). Otherwise, icons
surface inside the tools each submodule integrates with — fields, menu links, the
CKEditor toolbar, and so on.

## How to use it

1. **Define an icon pack.** Icon packs are declared in a YAML file named
   `EXTENSION.icons.yml` inside a module or theme. This tells Drupal where the icon
   files live and how to extract them (a plain path of files, an SVG sprite, or a
   web font). The maintainers publish an examples repository with ready-made
   definitions for popular icon sets — the quickest way to get started is to copy
   one of those.
2. **Enable the integrations you want** as submodules (see Installation).
3. **Pick icons** wherever those integrations surface — in an icon field widget, a
   menu link, the CKEditor 5 icon button, and so on — using the autocomplete or
   the optional modal grid picker.
