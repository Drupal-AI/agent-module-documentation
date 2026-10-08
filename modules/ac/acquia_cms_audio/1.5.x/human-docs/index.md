# Acquia CMS Audio — manual setup guide

**Acquia CMS Audio** (`acquia_cms_audio`) provides an **Audio media type** and
its supporting configuration for Acquia CMS, so editors can manage audio as
media entities. It includes support for **SoundCloud**-hosted audio through the
`media_entity_soundcloud` module, alongside locally uploaded audio files.

It is part of the **Acquia CMS** family of single-purpose modules and depends on
`acquia_cms_common` plus core's Media and Media Library. It provides its own
permissions, and access to audio media is governed by core media/entity access —
the module adds no special access role of its own.

Like the rest of the family this is distribution configuration: it ships a
pre-built media type rather than a generic, standalone feature. On an Acquia CMS
site it is exactly right; elsewhere it carries the family's assumptions with it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

This module has no dedicated settings page. Once enabled it adds an **Audio**
media type, which appears in the usual core Media locations:

- **Content → Media → Add media → Audio** (`/media/add/audio`) to add an audio
  item, either a local file or a SoundCloud URL.
- **Structure → Media types → Audio**
  (`/admin/structure/media/manage/audio`) to review or extend its fields, source
  settings, form display, and view displays.

## How to use it

Editors add audio through the Media library or **Content → Media → Add media →
Audio**. For SoundCloud, paste the track URL into the audio media form. Audio
media can then be referenced from any media-reference field elsewhere on the
site. To change the model — add a field or adjust a display — edit the Audio
media type under **Structure → Media types**, exactly as with any Drupal media
type.
