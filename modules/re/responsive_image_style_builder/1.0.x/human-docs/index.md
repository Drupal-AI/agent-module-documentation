# Responsive Image Style Builder — manual setup guide

**Responsive Image Style Builder** (`responsive_image_style_builder`) removes the
tedious part of setting up responsive images in Drupal. Normally, creating a
responsive image style means first hand‑building a separate plain **image style**
for every breakpoint and multiplier, then mapping each one — a lot of repetitive
clicking. This module automates that: when you create a **responsive image
style** against a theme's breakpoint group, it **automatically generates an image
style for each breakpoint and multiplier** for you.

The idea is to streamline the site‑builder workflow. You give a new responsive
image style a name and pick your active theme's breakpoint group; on save, the
module inspects that breakpoint group and creates the matching child image styles
behind the scenes, so they're ready to use.

It builds on core's **Responsive Image** module and doesn't add a settings screen
of its own — the "configuration" is simply the act of creating a responsive image
style, which the module then acts on. It creates image‑style configuration only
and has no role in content access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how creating a responsive image
   style triggers the automatic image‑style generation.

## Where it lives in the admin menu

Responsive Image Style Builder works through core's own **Responsive image
styles** admin at **Configuration → Media → Responsive image styles**
(`/admin/config/media/responsive-image-style`). You don't visit a separate page
for this module — it hooks into the save process there.
