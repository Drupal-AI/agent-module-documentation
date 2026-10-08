# AI Media Image — manual setup guide

**AI Media Image** (`ai_media_image`) adds a **"Generate Image with AI"** option to
the media image creation form. An editor types a prompt, and the module turns it
into a picture through whatever text-to-image provider Drupal's **AI** module is
configured with, then stores it as an ordinary image Media entity — ready to use
anywhere media is referenced, with image styles, the media library and usage
tracking all working normally.

The design keeps two decisions apart. Choosing the model and holding its API key is
an **administrative** decision that lives in the AI module, configured once there.
Actually generating an image is an **editorial** decision, controlled by this
module's own **`generate image with ai`** permission, which decides who sees the
generate option on media forms. This module never talks to an AI service directly
or holds a key — it consumes the provider the AI module already offers.

Three things are worth raising before you adopt it, none of them code problems.
Every generation is a **paid** call to the provider, so `generate image with ai`
is effectively a spending permission — grant it as a budget decision, not only an
editorial one. **Rights and retention** vary between providers: who owns generated
output, and whether prompts are kept for training, is a question for your legal
team, not a module setting. And generated images arrive with **no meaningful alt
text**, so your accessibility obligation is unchanged and arguably harder, since
there is no photographer or source to describe — plan to add alt text yourself.
This is an early (alpha) release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the generate permission.

## Where it lives in the admin menu

- **Settings:** `/admin/config/ai/ai_media_image`, gated by the AI module's own
  **Administer AI** permission.
- **Generate option:** appears on media image creation forms for users who hold the
  **`generate image with ai`** permission.

## How to use it

1. In the AI module, configure a text-to-image provider and its API key (see
   [Installation](installation/index.md)).
2. Grant **`generate image with ai`** to the roles that should be able to generate
   — remembering this is a spending permission.
3. When adding an image via the media form or media library, choose **Generate
   Image with AI**, enter a prompt, and the result is saved as a normal image Media
   entity. Add appropriate alt text before you rely on the image in content.
