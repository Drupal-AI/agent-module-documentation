# Parallax Background — manual setup guide

**Parallax Background** (`parallax_bg`) adds a vertical parallax scroll effect to the
background of any element on your site — a hero banner, a specific region, a block,
or even the whole `body`. As the visitor scrolls, the element's background image moves
at a different speed from the rest of the page, giving that layered sense of depth.
You don't touch any templates or write JavaScript: you point the effect at an element
using a jQuery/CSS selector and set a position and speed.

Each effect is stored as a **"Parallax element"** config entity, so your parallax
effects export and deploy with the rest of your site configuration. An element maps a
selector (for example `#hero` or `body.front #banner`) to a background horizontal
position (left, center, or right) and a scroll speed. You can create as many as you
like, enable or disable each one without deleting it, and give them different speeds
for a layered effect. On every page, the enabled elements are handed to the bundled
jQuery parallax plugin, which applies the effect to whatever matches each selector.

The module depends only on core (jQuery), ships its own copy of the jQuery parallax
plugin, and gates management behind an **Administer parallax elements** permission. A
`hook_parallax_bg_settings_alter()` hook lets developers tweak the effect
programmatically. Note that the selector you enter is used as a live jQuery selector
on the front end, so only grant the permission to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — creating and tuning Parallax elements,
   field by field.

## Where it lives in the admin menu

Effects are managed at **Structure → Parallax elements**
(`/admin/structure/parallax_element`), behind the **Administer parallax elements**
permission.

## How to use it

Make sure the target element already has a background image (via your theme's CSS),
then create a Parallax element pointing at that element's selector and choose a speed
and position. Save, and the effect applies wherever that selector exists. See
[Configuration](configuration/index.md) for the details.
