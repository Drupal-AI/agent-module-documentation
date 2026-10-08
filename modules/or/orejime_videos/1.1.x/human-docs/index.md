# Orejime Compliant Videos — manual setup guide

**Orejime Compliant Videos** (`orejime_videos`) stops embedded third‑party videos —
YouTube, Vimeo, Twitter, and the like — from loading, and from setting their cookies,
**until the visitor grants consent** through the [Orejime](https://www.drupal.org/project/orejime)
consent manager. It's a privacy/GDPR helper for sites that embed external video but
need to gate it behind consent.

It works by moving the original embed markup into a hidden `<template>` element and
rendering a **placeholder** in its place. When the matching Orejime consent is
granted, JavaScript swaps the template's content back into the page and removes the
placeholder — so the video (and its cookies) only ever loads with permission. The
placeholder message is translatable, and its template can be overridden in your own
theme so it matches your video styling.

The module offers two ways to gate videos: a **text filter** ("Convert Videos into
Orejime Videos") that rewrites embed markup in rich‑text fields using per‑service
rules, and an **oEmbed field formatter** ("Orejime oEmbed content") for media. A
submodule, `orejime_videos_vef`, adds a formatter for the Video Embed Field module.

> **⚠️ This module is obsolete and unsupported.** The maintainers state its
> functionality has been replaced by the **Orejime Media** module, which is
> recommended for new projects. Use Orejime Media for new installations, and consider
> migrating existing configurations. The guidance below is for existing sites that
> still run this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and, optionally, the Video Embed Field submodule).

There is **no admin configuration page** for this module. You enable a text filter
and/or a formatter, and the per‑service settings live in a configuration YAML file
you edit and re‑import, all described below.

## Where it lives in the admin menu

The gating is turned on from **Configuration → Content authoring → Text formats and
editors** (the text filter) and from a media type's **Manage display** (the oEmbed
formatter). The per‑service rules are held in the `orejime_videos.settings`
configuration, which at this version has **no admin UI** — you edit the exported
`orejime_videos.settings.yml` and re‑import it.

## How to use it

The module requires the **Orejime** library to be installed and running, with matching
consent "apps" (consent names) defined there.

### 1. Turn on gating

- **Text filter (rich text):** go to **Configuration → Content authoring → Text
  formats and editors**, edit a format, and enable **Convert Videos into Orejime
  Videos**. If you also use the media oEmbed formatter, place this filter **before**
  core's media filter so a media embed isn't processed twice.
- **Media oEmbed formatter:** on the media type's **Manage display**, set the oEmbed
  field's formatter to **Orejime oEmbed content**.
- **Video Embed Field:** enable the `orejime_videos_vef` submodule and use its
  formatter for Video Embed Field videos.

### 2. Configure the services (no admin UI)

The services and their consent mapping live in `orejime_videos.settings` under
`filtered_domains`. Defaults ship for **YouTube, Vimeo, and Twitter**. To change them
or add a service, edit `orejime_videos.settings.yml` and re‑import your configuration.
Each service defines:

- **`orejime_consent`** — the name of the consent in Orejime (you can reuse one
  consent name across several services);
- **`domains`** — the domain names to match (an array);
- **`htmlToExtUrl`** — one or more `pattern` / `replacement` regex pairs that rewrite
  the embed into the placeholder and also produce an external "watch elsewhere" URL.

```yml
youtube:
  orejime_consent: youtube          # consent name defined in Orejime
  domains:
    - youtube.com
    - youtu.be
  htmlToExtUrl:
    - pattern: '/<iframe[^>]*src\s*=\s*"...youtu\.?be...([\w\-_]+)\&?/im'
      replacement: 'https://youtu.be/$1'   # external "watch elsewhere" URL
```

### 3. Define the matching Orejime consent apps

In Orejime's own configuration, define the consent "apps" whose names match the
`orejime_consent` values above (for example `youtube`, `vimeo`, `twitter`), with the
cookies and purposes they cover. Refer to the Orejime documentation for that.

### 4. Adapt your theme

Because the embed is replaced by a placeholder, adapt your theme's CSS so the
placeholder matches your video styling. The message is translatable through Drupal's
translation interface, and you can override the `orejime-video.html.twig` template in
a custom theme (per‑service suggestions like `orejime_video__youtube` are available).
