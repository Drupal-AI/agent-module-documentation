# Lottiefiles Field — manual setup guide

**Lottiefiles Field** (`lottiefiles_field`) lets editors add **Lottie animations**
to your content and have them play right on the page. Lottie animations are
lightweight, vector‑based JSON animations (the kind you find on lottiefiles.com) —
they scale crisply at any size and are far smaller than a GIF or video. The module
adds a dedicated field type, a matching widget and formatter, and a ready‑made
media type, all rendered with the bundled `<lottie-player>` web component.

You can point a field at an animation three ways: paste an external
lottiefiles.com JSON URL, reference an internal path, or upload a `.json` file
directly on the content form. Each animation carries its own player options —
**autoplay**, **loop**, **controls**, play‑on‑**hover**, **speed** (1–5),
**mode** (normal or bounce), **background** colour (transparent or a hex value),
**width**, and a unique CSS selector — so two animations on the same page can
behave differently.

The field type is built on core's **Link** field, so it inherits Drupal's URL
validation. Installing the module also creates a ready‑made **Lottiefiles media
type** so you can manage reusable animations through the Media Library. There's no
global settings page and no permissions of its own — access follows the entities
and fields you attach it to. It depends on core's **Link**, **Media**, and **Media
Library** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Link, Media, and Media Library come along).

## Where it lives in the admin menu

The module adds no settings page. You add a Lottiefiles field to a bundle from its
**Manage fields** screen (**Structure → Content types → [type] → Manage fields**),
and you'll find the ready‑made **Lottiefiles** media type under **Structure →
Media types**.

## How to use it

### Option A — add a Lottiefiles field to a content type

1. Go to **Structure → Content types → [your type] → Manage fields** and click
   **Add field**.
2. Choose the **Lottiefiles Field** field type, give it a label, and save.
3. On **Manage form display**, make sure the field uses the **Lottiefiles Field**
   widget (it is by default).
4. On **Manage display**, make sure the field uses the **Lottiefiles Field**
   formatter.

When editing content you'll now see a Lottiefiles field where you can:

- Paste a **Lottiefile URL** (an external lottiefiles.com JSON URL or an internal
  path), **or** upload a **`.json`** file — an uploaded file's URL is filled in
  automatically.
- Pick a **background** colour (transparent or a hex value, with a colour picker).
- Toggle **autoplay**, **loop**, **controls**, and play‑on‑**hover**.
- Choose the **mode** (normal or bounce), the **speed** (1–5), and an optional
  **width** in pixels.

### Option B — use the Lottiefiles media type

Installing the module creates a **Lottiefiles** media type. Add animations through
the **Media Library** (URL or upload) and reuse them anywhere a Media reference
field points at that type — handy for a shared library of animated icons or
illustrations.

> **Note:** the animation JSON is loaded by the visitor's browser directly from the
> URL you store, so make sure the animation file is reachable from the front end.
