# oEmbed Formatter Plus — manual setup guide

**oEmbed Formatter Plus** (`oembed_formatter_plus`) is a slightly enhanced version
of Drupal core's built‑in **oEmbed** field formatter — the one that renders a
"Remote video" media field (YouTube, Vimeo, and similar) as an embedded player. It
keeps everything the core formatter does and adds a few extra options that give
editors and site builders more control over the markup.

Specifically, it lets you:

- **Disable the wrapping iframe** for providers you mark as **trusted**, so their
  embedded content renders without the extra core iframe wrapper.
- **Customise the inner and outer iframe titles**, which matters for accessibility
  and screen‑reader users.

It also folds in the responsive video styling improvements from the **Video Embed
Field** module, so embeds scale cleanly within their container. It requires only
core's **Media** module — nothing outside Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. As a field formatter, it is
configured on a media type's **Manage display**, described in "How to use it"
below.

## How to use it

The formatter works with **Media types that use a "Remote video" media source**
(core Media must be enabled).

1. Go to **Structure → Media types** and choose a media type whose source is
   **Remote video**.
2. Open its **Manage display** tab and change the **Format** of the *Video URL*
   field to **"oEmbed formatter plus content."**
3. Open the formatter's settings (if you use the Claro admin theme, click the
   **gear** icon) and configure:
   - **Trusted Providers** — add the providers you trust, separated by semicolons,
     for example `YouTube; Vimeo`. Content from these providers can render without
     the wrapping iframe.
   - **Include inner iframe title** — enabled by default. Leave it on if you want
     the outer title to incorporate the embed's own inner iframe title. When you
     turn it *off*, the "Outer iframe title" value becomes the title instead.
   - **Outer iframe title** — text prepended to the inner iframe title. Useful for
     embeds from providers you haven't marked trusted. Avoid relying on it on pages
     with **multiple videos**, as a repeated outer title is worse for screen‑reader
     users.
4. Click **Save**.
