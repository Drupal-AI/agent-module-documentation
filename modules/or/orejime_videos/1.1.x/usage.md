<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orejime Compliant Videos keeps embedded third-party videos (YouTube, Vimeo, Twitter, …) from loading — and setting cookies — until the visitor grants consent through the Orejime consent manager.

It works by moving the original embed markup into a `<template>` element and rendering a custom placeholder in its place; when the matching Orejime consent is granted, JavaScript swaps the template content back into the DOM and removes the placeholder. Two entry points are provided: a **text filter** ("Convert Videos into Orejime Videos") that rewrites embed markup in rich text using per-service regex rules, and an **oEmbed field formatter** ("Orejime oEmbed content") for media; the `orejime_videos_vef` submodule adds a Video Embed Field formatter. Services and their consent mapping are configured in `orejime_videos.settings` (`filtered_domains`), where each service defines an `orejime_consent` name, matching `domains`, and `htmlToExtUrl` regex `pattern`/`replacement` pairs that also produce an external "watch elsewhere" URL.

Operational notes: there is no admin UI yet — you edit `orejime_videos.settings.yml` (the `filtered_domains` map) and re-import config; defaults ship for YouTube, Vimeo and Twitter. The displayed placeholder message is translatable and its template can be overridden in a custom theme. The module requires the Orejime library to be installed and running, and you configure the corresponding Orejime "apps" (consent names) separately. No routes, permissions or outbound server calls — purely display/consent-gating.
---
Gate embedded videos behind Orejime consent by swapping the embed for a placeholder until the user opts in.
---
- Enable the "Convert Videos into Orejime Videos" text filter on a format.
- Order the filter before core's media filter to avoid double-processing.
- Use the "Orejime oEmbed content" formatter on a media oEmbed field.
- Enable `orejime_videos_vef` to gate Video Embed Field videos.
- Define YouTube consent gating in `filtered_domains` (default provided).
- Define Vimeo consent gating (default provided).
- Define Twitter consent gating (default provided).
- Add a new service with its `orejime_consent`, `domains` and regex rules.
- Reuse one Orejime consent name across multiple service filters.
- Produce an external "watch on site" URL via the `htmlToExtUrl` replacement.
- Translate the placeholder consent message via Drupal's UI.
- Override the `orejime-video.html.twig` template in a custom theme.
- Adapt theme CSS so placeholders match your video styling.
- Attach consent names to the page via the `orejime_videos` drupalSettings.
- Configure matching Orejime "apps" (consent entries) in the library config.
- Prevent third-party cookies from being set before consent is given.
- Re-import config after editing `orejime_videos.settings.yml`.
- Add per-service theme suggestions like `orejime_video__youtube`.
