# Background Wallpaper — manual setup guide

**Background Wallpaper** (`background_wallpaper`) gives administrators a simple
way to set or change the image behind the whole site from configuration —
without editing your theme's CSS. You pick an image once and the module applies
it site-wide, which makes it a lightweight convenience for branding or quickly
re-skinning a site's background.

It stores an admin-chosen image in configuration and renders it as the page
background across the site. There is nothing for visitors to interact with — it
is purely a theming utility with no front-end role of its own. It depends only
on core's **System** and **Configuration** modules and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, the module provides an admin setting where you choose the
background image. Set the image, save, and it is applied to every page. Because
the choice is stored in configuration, swapping the background later (for a
seasonal campaign or a rebrand, say) is just a matter of changing the setting —
you never touch theme CSS. The module ships its own permission, so you can limit
who is allowed to change the wallpaper to trusted administrators.
