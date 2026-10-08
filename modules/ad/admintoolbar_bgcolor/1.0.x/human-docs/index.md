# Admin Toolbar Background Color — manual setup guide

**Admin Toolbar Background Color** (`admintoolbar_bgcolor`) changes the background
colour of the admin toolbar. Its most common use is as a per-environment
indicator: set the toolbar red on production, green on development, orange on
staging, and so on, so that anyone editing the site can tell at a glance which
environment they are in and avoid the classic mistake of editing the wrong one.

It is an administration / UX helper — it only affects how the toolbar looks. It
stores no content, changes no access, and has no content or access-control role.
The module depends on the [Color Field](https://www.drupal.org/project/color_field)
module, which provides the colour-picker input it uses, and it targets Drupal 10
and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Color Field dependency) and enable the module.

## Where it lives in the admin menu

The module provides a setting where you choose the toolbar's background colour.
Set the colour there, and it applies to the admin toolbar site-wide.

## How to use it

The typical workflow is to give each environment a distinctive colour. Because
the setting is stored per site, you configure a different colour on each
environment (production, staging, dev) so the toolbar visually signals where you
are working. Pick a colour, save, and the toolbar background updates for everyone
who sees the toolbar. There is nothing else to set up.
