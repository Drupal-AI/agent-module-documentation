# UI Icons — manual setup guide

**UI Icons** (`ui_icons`) is a generic icon manager for Drupal 11. The idea is
simple: declare an icon pack once in a small YAML file, and then use those icons
everywhere Drupal renders output — in forms, fields, menus, rich-text, media, and
Twig templates. It builds on Drupal core's Icon API (available from 11.1), so any
module or theme can ship icon packs and any integration can consume them, all
addressing icons by a single combined `pack_id:icon_id` string.

The base `ui_icons` module is essentially plumbing. It adds a reusable
`icon_autocomplete` form element (so editors can search for and pick an icon), an
icon search service, an icon preview API, a Twig `icon_preview()` function, and some
theme-specific styling for the autocomplete. It has **no configuration UI and no
permissions of its own** — its value shows up once you add the integration
submodules that consume it.

Those submodules are where the day-to-day features live: an **Icon field type**, a
**Media** integration, a **CKEditor 5** button for inserting icons into rich text, a
**text filter**, **menu-link icons**, a **visual icon picker**, an **admin icon
library overview**, a **web-font extractor**, a **UI Patterns** bridge, and several
Link/Linkit integrations. You enable just the ones you need.

Icon packs themselves are declared by developers or themers in an
`EXTENSION.icons.yml` file, using core's `path`, `svg`, or `svg_sprite` extractor —
that setup is a code task covered in the [`agent/`](../agent/start.md) docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to declare icon
packs and use the form element and services — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the integration submodules you need.

## Where it lives in the admin menu

The base module adds no admin page. Where icons appear depends on which submodules
you enable — for example the **UI Icons Library** submodule adds an admin overview
page listing every icon available on the site, and **UI Icons CKEditor 5** adds an
icon button to your text-format toolbars. There is no central settings form.

## How to use it

1. Enable `ui_icons` plus the integration submodules that match how you want to use
   icons (see [Installation](installation/index.md) for the full list).
2. Make sure at least one icon pack is available — either from a module/theme that
   ships one, or by declaring your own in an `*.icons.yml` file (a developer task;
   see the [`agent/`](../agent/start.md) docs).
3. Use icons through whichever integration you enabled: pick one in an Icon field,
   insert one in CKEditor, attach one to a menu link, and so on. In Twig you can
   render any icon directly with `{{ icon_preview('pack_id', 'icon_id', settings) }}`.
