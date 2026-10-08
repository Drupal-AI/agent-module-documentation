# NanoBanana Editor — manual setup guide

**NanoBanana Editor** (`nanobanana_editor`) lets content editors edit and generate
images with **NanoBanana AI** (Google's Gemini image models) directly from
Drupal's Media forms — no leaving the site, no external image tool. From a media
image you can click **Edit with NanoBanana** to transform it with a text prompt,
or from the "Add media" flow click **Generate with NanoBanana** to create a brand
new image from a description or from reference images.

It is a rich editor: you choose a model (Gemini 2.5 Flash for speed or Gemini 3
Pro for higher quality and up to 4K output), set an aspect ratio, combine
multiple images into a composite (up to 14 with Pro), and apply reusable **style
presets** so generations stay consistent. Site‑wide **system instructions** let
you set a house tone or quality standard that is prepended to every prompt.

The module builds on Drupal's **AI** framework. It depends on core **Media**, the
**AI** module (`ai`), and the **NanoBanana AI provider** (`ai_provider_nanobanana`),
which is where the actual API credentials for the image service live. You will
configure the provider (with your API key) and then the NanoBanana Editor's own
settings.

**Before you roll this out, understand the trade‑offs.** Every edit or generation
sends image data and your prompt to the AI provider's servers, which means both a
per‑request **cost** and the **privacy** consideration that images leave your
site. Restrict the module's permissions to trusted editors, and store the
provider API key securely (never in code or config that gets committed). This
release is a beta and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up its AI dependencies.
2. [Configuration](configuration/index.md) — the NanoBanana settings (system
   instructions, style presets), where the API key lives, and the cost/privacy
   considerations.

## Where it lives in the admin menu

The module's own settings sit at **Configuration → Media → NanoBanana Settings**
(`/admin/config/media/nanobanana`). The AI credentials themselves are configured
on the separate **NanoBanana AI provider** module. See
[Configuration](configuration/index.md) for both.

## How to use it

- **Generate a new image:** go to **Content → Media → Add media → Image**, click
  **Generate with NanoBanana**, describe the image, pick a model, aspect ratio,
  and optional style, click **Generate** to preview, then **Save** to create the
  media entity.
- **Edit an existing image:** open a media image's edit form, click **Edit with
  NanoBanana**, describe the change, **Generate** to preview, then **Save** to
  replace the image (or **Cancel** to discard).
- **Compose multiple images:** in either form, upload additional images and write
  a prompt describing how to combine them (up to 3 total with Flash, 14 with Pro).
