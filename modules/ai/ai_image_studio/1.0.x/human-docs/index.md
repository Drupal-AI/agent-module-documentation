# AI Image Studio — manual setup guide

**AI Image Studio** (`ai_image_studio`) is a chat-style workspace for creating and
refining AI images and video, then publishing the results into Drupal's media
library. Instead of a one-shot "type a prompt, get an image" form, it works as a
conversation: you start a **session**, each prompt you send is a **turn**, and you
can keep refining — "make it warmer", "now turn it into a short video" — building on
the previous result. When you are happy with a turn you publish it as a Media
entity.

Under the hood it uses Drupal's **AI** module for all model access, so the choice
of provider and the API key live in the AI module, not here. Depending on what you
ask for and whether you supply a starting image, a turn runs one of four
operations — text-to-image, image-to-image, text-to-video or image-to-video —
against the model you have configured. Each turn records the provider, model,
timing, token usage and an estimated cost, so you can see what a session is
spending.

Sessions are private to the person who created them: you can only see and manage
your own, unless an administrator grants the broader "view any" / "delete any"
permissions to moderators. Generated files are stored privately by default and
re-checked on download, so they are not publicly guessable. The main thing to plan
for is **cost**: there is no built-in rate limit beyond a per-session turn cap, and
anyone with access can keep creating sessions, so pair it with **AI Budget
Control** if you need hard spending limits.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permissions.
2. [Configuration](configuration/index.md) — the settings form, section by
   section, plus how editors use the studio.

## Where it lives in the admin menu

- **Studio (sessions):** **Content → AI Image Studio** (`/admin/content/ai-image-studio`),
  with a **new session** page at `/admin/content/ai-image-studio/new`.
- **Settings:** **Configuration → AI → AI Image Studio**
  (`/admin/config/ai/image-studio`), which requires the
  **Administer AI Image Studio** permission.

## How to use it

1. Grant **Access AI Image Studio** to the roles that may generate images or
   video (and the publish permissions if they should push results to Media).
2. An editor opens **Content → AI Image Studio**, starts a new session, and types
   a prompt. Each submission runs a turn through the configured AI provider and
   shows the result.
3. They refine across turns as needed, then publish a chosen turn into the
   configured media bundle — optionally burning a small "AI" badge into the image
   or video. See [Configuration](configuration/index.md) for the full workflow.
