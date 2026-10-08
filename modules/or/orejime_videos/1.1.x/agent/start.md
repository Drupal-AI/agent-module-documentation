<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orejime Compliant Videos (orejime_videos) — agent index

**Replaces embedded videos with a consent placeholder (`<template>`) restored once the matching Orejime consent is granted.**

- **Version:** 1.1.x
- **Core:** ^9 || ^10 || ^11 (dep: media; requires the external Orejime JS library)
- **Provides:** text filter `FilterVideosOrejime` ("Convert Videos into Orejime Videos"), oEmbed formatter `OrejimeOEmbedFormatter`, theme `orejime_video`
- **Service:** `orejime_videos.field_formatter_helper`
- **Config:** `orejime_videos.settings` → `filtered_domains` (per-service `orejime_consent`, `domains`, `htmlToExtUrl` regex rules) — **no admin UI; edit config YAML**
- **Submodule:** `orejime_videos_vef` (Video Embed Field formatter)

**Security:** no routes, permissions, or outbound/server requests — purely client-side display and consent gating. Filter output is built from admin-controlled config regexes applied to editor content. No security findings.

See [configure/filters.md](configure/filters.md)
