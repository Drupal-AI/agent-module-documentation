# AI Image Alt Text — manual setup guide

**AI Image Alt Text** (`ai_image_alt_text`) adds a **"Generate with AI"** button
to image field widgets that fills in the image's alt text for you, using a
vision-capable AI model. It's a practical way to improve accessibility (a11y)
and image SEO across a large media library without hand-writing every alt
attribute — while keeping a human in the loop, since the editor sees the
suggestion in the field and can edit it before saving.

The module doesn't talk to any AI service directly. Instead it builds on the
**AI (AI Core)** module: when you click the button, it sends the image plus a
configurable prompt through whatever provider you've set up in AI Core (OpenAI,
Anthropic, and others). Before sending, the image is downscaled and reformatted
through an image style to keep the token cost down. The prompt is fully editable
and can produce alt text in the content's own language, so multilingual sites get
per-language descriptions from the same image.

You can leave the button as a manual, one-click action, or switch on
**autogenerate** so alt text is written automatically on upload. A bundled
submodule, **AI Image Bulk Alt Text** (`ai_image_bulk_alt_text`), adds a batch
tool to fill in missing alt text across many existing images at once. Everything
is controlled from one settings page under **Configuration → AI**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the generate
route and the AI Core chat-call pattern — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the AI Core prerequisite and the bulk submodule.
2. [Configuration](configuration/index.md) — the settings form field by field,
   the prompt tokens, permissions, and the button behavior.

## Where it lives in the admin menu

The settings page is at **Configuration → AI → AI Image Alt Text Settings**
(`/admin/config/ai/ai_image_alt_text`). Reaching it requires the *Administer AI*
(`administer ai`) permission. The **Generate with AI** button itself appears on
content edit forms, on any image field whose alt text is enabled, for users who
hold the *Generate AI alt tags* (`generate ai alt tags`) permission.

## How to use it

1. Make sure AI Core has a vision-capable provider available (see
   [Installation](installation/index.md) and [Configuration](configuration/index.md)).
2. Edit any content with an image field and upload an image.
3. Click **Generate with AI** next to the image; the AI-written alt text drops
   into the alt field for you to review and adjust.
4. Save the content as usual.

Prefer it fully automatic? Turn on **autogenerate** in the settings so alt text
is produced on upload. Need to backfill an existing library? Enable the
**AI Image Bulk Alt Text** submodule and run its batch tool.
