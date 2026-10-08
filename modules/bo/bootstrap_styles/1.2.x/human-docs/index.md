# Bootstrap Styles — manual setup guide

**Bootstrap Styles** (`bootstrap_styles`) is a styling engine for Drupal's
**Layout Builder**. It provides a builder plus a library of ready‑made style
controls — background (color, image, video), spacing (padding and margin),
colors, borders, box shadow, typography, and scroll‑in animations — that apply
CSS classes to Layout Builder sections and blocks. Think of it as the foundation
that turns Layout Builder into a visual design tool for editors.

An important thing to understand: **Bootstrap Styles does not, by itself, add any
controls to the Layout Builder UI.** It is a foundation module. It defines the
style plugins and a manager service, and it stores the list of available CSS
classes in configuration — but another module has to actually surface those
controls on sections and blocks. In practice that consumer module is
[Bootstrap Layout Builder](https://www.drupal.org/project/bootstrap_layout_builder),
which calls Bootstrap Styles to render the styling tabs you see in the
off‑canvas editor. If you want the editing experience, you almost always install
both.

What you *do* configure directly in Bootstrap Styles is the **catalog of style
options** — the CSS classes and their human‑friendly labels (for example
`bs-bg-success|Green` or `bs-p-3|Padding 3`), which media types supply background
images and videos, the light/dark theme of the off‑canvas builder, and the
scroll‑effects (AOS) library settings. Developers can extend it with their own
`Style` and `StylesGroup` plugins and alter the bundled ones.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — the settings form: editing the
   style option classes, the builder theme, background media, and scroll effects.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Bootstrap Styles**
(`/admin/config/bootstrap-styles/settings`). It is gated by the **Configure
bootstrap styles** permission.

## How to use it

1. Install and enable Bootstrap Styles (it pulls in Layout Builder and Media
   Library Form Element).
2. Install and enable a consumer such as **Bootstrap Layout Builder** so the
   style controls actually appear in the Layout Builder off‑canvas editor.
3. Optionally open the Bootstrap Styles settings form to tune the list of
   available classes, the builder theme, and which media types provide
   background images and videos.
4. Edit a page or content type with Layout Builder — the style tabs
   (Background, Spacing, Border, Shadow, Typography, Animation) now appear on
   sections and blocks.
