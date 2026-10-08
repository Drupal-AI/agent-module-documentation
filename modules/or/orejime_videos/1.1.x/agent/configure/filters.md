<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Orejime Compliant Videos

Requires the Orejime consent-manager library installed and running, with matching
consent "apps" defined there.

## Enable gating
- **Text filter:** on a text format, enable *Convert Videos into Orejime Videos*
  (`FilterVideosOrejime`). If you also use the media oEmbed formatter, place this
  filter before core's media filter so a media embed isn't processed twice.
- **Media oEmbed formatter:** on the media display, set the oEmbed field's formatter
  to *Orejime oEmbed content* (`OrejimeOEmbedFormatter`).
- **Video Embed Field:** enable the `orejime_videos_vef` submodule and use its formatter.

## Configure services (no admin UI)
Edit `orejime_videos.settings.yml` → `filtered_domains` and re-import config. Each service:
```yml
youtube:
  orejime_consent: youtube          # consent name in Orejime
  domains:                          # domains to match
    - youtube.com
    - youtu.be
  htmlToExtUrl:
    - pattern: '/<iframe[^>]*src\s*=\s*"...youtu\.?be...([\w\-_]+)\&?/im'
      replacement: 'https://youtu.be/$1'   # external "watch elsewhere" URL
```
Defaults ship for YouTube, Vimeo and Twitter. One `orejime_consent` may be reused
across services.

## How it renders
The original embed is moved into a `<template>`; a placeholder (theme hook
`orejime_video`, template `orejime-video.html.twig`, suggestion
`orejime_video__{service}`) is shown instead. `orejime_videos_preprocess_orejime_video`
attaches the `orejime_videos/orejimeVideos` library and passes the consent list via
`drupalSettings.orejime_videos.consents`; on consent the template content is injected
and the placeholder removed. The message is translatable; override the template in your
theme to restyle.
