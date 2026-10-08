# Media Library Theme Reset — manual setup guide

**Media Library Theme Reset** (`media_library_theme_reset`) fixes the way Drupal's
core Media Library looks when it is shown in a **front‑end theme** instead of the
admin theme. (The documented release, `2.0.0-beta1`, is a beta.)

Core's Media Library is built and styled for Claro, the admin theme. Whenever it is
rendered in a front‑end theme its layout breaks — the grid, spacing, and focus
styling fall apart. That happens more often than you might think: inside **Layout
Builder**, when "Use the administration theme when editing or creating content" is
turned off, when a user lacks permission to use an admin theme, when a front‑end
theme is set as the admin theme, or on end‑user webforms that embed media.

This module solves that without asking every theme to ship its own templates and CSS.
It borrows Claro's administrative styling: it registers a set of Twig templates copied
from Claro, attaches Claro's real media‑library stylesheet plus its own small fixes
CSS whenever the Media Library add‑form loads, and re‑adds the CSS classes Claro would
normally apply. It also loads an extra Olivero‑specific fixes stylesheet when Olivero
is the active theme.

There is nothing to configure — enabling the module is the whole setup. It has no
settings page, no permissions, no Drush commands, and no plugins. This guide is
written for a **human**; if you want terse, token‑cheap references for an AI coding
agent — the exact template list and how to override them — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There are no options to set. Once enabled, the Media Library simply renders correctly
in your front‑end theme — in Layout Builder, on front‑end content forms, and on
webforms that use media. Two things are worth knowing:

- **Overriding the markup.** The module ships copies of Claro's media‑library Twig
  templates. To customize any of them, copy the relevant `*.html.twig` file from the
  module's `templates/` directory into your own theme's `templates/` directory and
  edit it there — your theme's copy wins.
- **Stable 9‑based themes.** Themes based on Stable 9 ship their own
  `media--media-library.html.twig` and `media-library-wrapper.html.twig`, which shadow
  this module's versions and drop essential classes. If your layout still looks broken,
  copy those two templates from this module into your theme to fix it.
