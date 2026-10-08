# Scroll Up Down — manual setup guide

**Scroll Up Down** (`scroll_up_down`) adds two small floating buttons to every
page — one that scrolls smoothly to the top and one that scrolls to the bottom.
On long pages, and especially on mobile where there is no keyboard Home key, this
saves your visitors a lot of swiping.

The buttons are built with plain, vanilla JavaScript (no jQuery) and are designed
to be accessible: they carry proper ARIA labels, are keyboard focusable, and work
with screen readers. They fade in once the visitor scrolls down the page and fade
out again near the top, so they stay out of the way when they are not needed. All
the icons and styles are defined in CSS, so a site builder can restyle them from
the theme without touching any JavaScript.

The module works the moment you enable it — the buttons are attached to all pages
automatically and there is no settings form to fill in. Its one piece of
configuration is a **permission** that controls who is allowed to see the arrows,
so you can, for example, show them to everyone or restrict them to certain roles.
It has no dependencies beyond Drupal core and works in any modern browser that
supports smooth `window.scrollTo`.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the scroll buttons appear automatically on long pages for anyone who
has permission to see them. There is nothing to configure. To choose **who** sees
the arrows, go to **People → Permissions** (`/admin/people/permissions`), find the
Scroll Up Down permission, tick the roles that should see the buttons, and save.
To change how the buttons look, override the module's CSS in your own theme.
