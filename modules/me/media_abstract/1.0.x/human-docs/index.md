# Media Abstract — manual setup guide

**Media Abstract** (`media_abstract`) lets a **single file input accept multiple media
types**. Drupal's Media module is great for organising and rendering different kinds of
files, but on its own it can't give editors one upload field that handles images, videos and
documents together — you normally end up with a separate field per media type. Media Abstract
solves that by providing a new **"Media abstract file"** field type and formatter that looks
and behaves like an ordinary file field. The trick happens on save: each uploaded file
automatically creates a **media entity matching the file's extension**, routing it to the
right media type without the editor having to pick one.

Each field can be limited to the specific media types you want it to accept, so you keep
control over what can be uploaded while presenting editors with a single, simple input. It
builds on core's File and Media modules and has no access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its File/Media dependencies.

Media Abstract has no global settings form — you configure it per field, choosing which
media types it accepts, as described under "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated admin page. You use it from **Structure → Content types →
*(your type)* → Manage fields** by adding a Media abstract file field, and from **Manage
display** to control how it renders.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and **add a field**
   of type **Media abstract file**.
2. In the field settings, enable the **specific media types** this field should accept (for
   example image, video, document). Save.
3. When editing content, editors use the single file input to upload a file. On save, Media
   Abstract creates a media entity of the type matching the file's extension automatically.
4. On **Manage display**, choose how the field renders, as you would any media field.
