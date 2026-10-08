# AI Image generation module — manual setup guide

**AI Image generation module** (`ai_image_generation`) adds an admin screen that
turns a written prompt into pictures using OpenAI's DALL·E image API, and saves
the ones you like into Drupal's media library. An editor types a description
("a watercolor lighthouse at sunset"), picks a model and size, generates a few
options, previews them inline, ticks the ones worth keeping, and those are stored
as ordinary `image` Media entities you can reuse anywhere media is referenced.

Unlike most modules in the AI ecosystem, this one talks to OpenAI directly rather
than through the shared **AI** module — it only depends on core's **Media**
module. You enter an OpenAI **Organisation ID** and **API key** on its own
settings form, and every image you generate is a paid API call billed to that
key.

Two important cautions come with that. First, because each generation costs money,
access to the generation form should be kept to a small number of trusted admins.
Second, this module stores the API key in **plain module configuration** (not in a
Key entity), and the settings form shows it in an ordinary text field — so treat
any configuration export as sensitive and keep `ai_images_api.settings` out of
shared or committed config. There is also a small public page that shows a static
DALL·E pricing table; it contains only hard-coded numbers and leaks no key.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your OpenAI credentials and
   generate images, field by field.

## Where it lives in the admin menu

- **Settings (credentials):** `/admin/content/ai_image_generation_settings`
- **Generate images:** `/admin/content/ai_image_generation`
- **Pricing table:** `/ai_image_generation/AIusage`

The two working screens require the **Administer site configuration** permission.

## How to use it

1. Enter your OpenAI Organisation ID and API key on the settings form.
2. Open the generation form, write a prompt, pick a model and size, and generate.
3. Preview the results, tick the ones you want, and save them into the media
   library. See [Configuration](configuration/index.md) for the details of each
   field.
