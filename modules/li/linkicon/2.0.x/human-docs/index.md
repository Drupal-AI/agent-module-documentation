# Link Icon — manual setup guide

**Link Icon** (`linkicon`) turns the links in a core **Link** field into iconized
links. Instead of typing an icon class per link, you define a controlled list of
allowed link titles (for example `facebook`, `linkedin`, `x-twitter`), and Link
Icon builds a CSS icon class from whichever title an editor picks — so a "Facebook"
link automatically gets an `icon-facebook` class and renders with the right icon.

It is **icon-library agnostic**: the module only emits CSS classes, so it works
with FontAwesome, Fontello, or any icon font you already load in your theme. It
does not add a field type of its own — it works on the standard core Link field.
Setup is a two-step flow on the field: first switch the link field's title option
to **"Predefined"** and enter the allowed `key|value` titles (Manage fields), then
choose the **"Link icon"** formatter and its many display options on Manage
display (prefix class, tooltip, icon-only, vertical layout, size, style presets,
`rel="nofollow"`, open-in-new-window, and more).

There is also a small **global settings form** with a single option: the path to a
custom icon-font CSS file to load, for cases where your theme doesn't already load
the font. The module depends on core's **Link** module, adds an *Administer
linkicon* permission, and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set predefined titles on a link
   field, choose the Link icon formatter, and point the module at your icon font.

## Where it lives in the admin menu

The global settings form is at **Configuration → User interface → Link Icon**
(`/admin/config/user-interface/linkicon`). The main work, though, happens on a
link field's **Manage fields** and **Manage display** pages for the content type
that holds the field.
