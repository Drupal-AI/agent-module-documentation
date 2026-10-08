# AI Image Generator CKEditor — manual setup guide

**AI Image Generator CKEditor** (`ai_image`) adds an **"AI Image"** button to the
CKEditor 5 toolbar. An author types a text prompt, the module sends it to a
configured AI text-to-image provider, and the returned image is inserted straight
into the editor body — a one-click prompt-to-picture workflow inside the normal
content form.

Under the hood, the button collects the prompt (plus optional extra prompt text
and a chosen provider/model) and posts it to the module's JSON endpoint. A
controller resolves the provider — falling back to the site's default
text-to-image provider when none is chosen — generates the image, saves it to the
public files directory, and hands the URL back to the editor. It supports
OpenAI DALL·E-style providers and Stable Diffusion-style providers, and other
modules can adjust the generation parameters via a hook.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up the provider and toolbar.

## Where it lives in the admin menu

AI Image has no central settings page (`configure` is null). You enable its
button per text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), and you configure the AI provider
and its Key through the AI and Key modules. Generated images are stored in the
public files directory.

## How to use it

1. Configure an AI text-to-image provider (OpenAI or a Stable Diffusion
   provider) in the AI module, with its API key stored as a **Key** entity — see
   [Installation](installation/index.md).
2. In a CKEditor 5 text format, add both the core **Image** button and this
   module's **AI Image** button to the toolbar, then save.
3. While editing, click **AI Image**, type a prompt (optionally choosing a
   provider/model), and the generated image is inserted into the body.
