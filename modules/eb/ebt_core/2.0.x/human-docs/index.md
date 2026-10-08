# Extra Block Types (EBT): Core — manual setup guide

**Extra Block Types (EBT): Core** (`ebt_core`) is the shared base module for the
EBT family of custom block-type modules (EBT Tabs, Hero, CTA, Carousel, and so
on). On its own it adds no block you can place — instead it supplies the common
machinery every `ebt_*` module builds on: a per-block "EBT Settings" design
field, a site-wide settings form for brand colors, breakpoints and container
widths, automatic CSS/JS generation, and the theme/template plumbing that gives
each block type its own Twig template without boilerplate.

The heart of it is a reusable **design-options field**. EBT Core defines an
`ebt_settings` field type and ships the `field_ebt_settings` storage on Drupal's
`block_content` entity. That field gives editors a UI for margins, padding,
borders (color/style/radius), background color, background media
(image/uploaded video/remote YouTube video with an optional parallax effect),
edge-to-edge full-bleed layout, and named container widths — all stored on the
block itself rather than baked into theme code. At render time EBT Core reads
those saved options and generates scoped, per-block CSS and any parallax or
background-video behavior automatically.

A single site-wide settings form holds the defaults EBT blocks fall back to:
primary/secondary brand colors, primary/secondary button text colors, a
background color (default `#0d77b5`), responsive breakpoints (mobile 640 /
tablet 1020 / desktop 1320), and named container widths from xxSmall to xxLarge.
Two optional submodules round it out: **EBT Core Remove Helper**
(`ebt_core_remove_helper`) for bulk-removing EBT blocks and the shared field
storage before uninstalling, and **EBT Core Starterkit** (`ebt_core_starterkit`),
a Drush generator for scaffolding brand-new EBT block-type modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the site-wide colors, breakpoints,
   and widths form, field by field.

## Where it lives in the admin menu

Once enabled, EBT Core's own settings form sits at **Configuration → Content
authoring → Extra Block Types (EBT) settings**
(`/admin/config/content/ebt-core`). The per-block design options appear
wherever an EBT block type's field is placed — you edit them directly on the
block while building a page (typically in Layout Builder, as an inline block, or
on a reusable custom block).

## How to use it

EBT Core is infrastructure: you rarely use it directly. The normal workflow is
to install EBT Core and then install one or more of the individual EBT block-type
modules, each of which requires this base module. Those block types automatically
gain the EBT design-options field and the site-wide defaults you set here.

If you are building your own custom block type and want the same design options,
add a `field_ebt_settings` field to that `block_content` bundle (the storage
ships with this module), set the form widget to **EBT default block settings**,
and give the bundle an `ebt_` name prefix so the render and theme hooks apply.
To scaffold a complete new EBT module, enable the Starterkit submodule and run
`drush generate ebt:module`.
