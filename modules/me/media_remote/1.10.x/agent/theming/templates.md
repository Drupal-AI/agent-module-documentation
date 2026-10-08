<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hooks and templates

`media_remote_theme()` registers one theme hook per provider. Every hook also receives `media`
(the media entity), so a template override can read fields off it. Templates live in
`web/modules/contrib/media_remote/templates/` and use the hyphenated file name
(`media_remote_google` → `media-remote-google.html.twig`).

| Theme hook | Variables (besides `media`) |
|---|---|
| `media_remote_apple_podcasts` | `slug`, `token` |
| `media_remote_arcgis` | `url`, `name`, `width`, `height` |
| `media_remote_box` | `hash`, `width`, `height` |
| `media_remote_brightcove` | `url` |
| `media_remote_buzzsprout` | `episode_id`, `podcast_id` |
| `media_remote_dacast` | `url`, `width`, `height` |
| `media_remote_deezer` | `episode_id` |
| `media_remote_documentcloud` | `document_id`, `slug` |
| `media_remote_dropbox` | `app_key`, `url`, `width`, `height` |
| `media_remote_google` | `type`, `url`, `width`, `height` |
| `media_remote_google_map` | `title`, `url`, `width`, `height` |
| `media_remote_libsyn` | `episode_id` |
| `media_remote_loom` | `video_id`, `width`, `height` |
| `media_remote_matterport` | `url`, `width`, `height` |
| `media_remote_msforms` | `url`, `width`, `height` |
| `media_remote_npr` | `url`, `width`, `height` |
| `media_remote_panopto` | `domain`, `type`, `id` |
| `media_remote_planet_estream` | `url`, `width`, `height` |
| `media_remote_quickbase` | `url` |
| `media_remote_stitcher` | `url` |

Note the formatters pass **capture groups from the URL regex**, not the raw URL, for providers
whose embed URL differs from the share URL (Loom's `video_id`, Box's `hash`, Buzzsprout's
`episode_id`/`podcast_id`, Panopto's `domain`/`type`/`id`, Apple Podcasts' `slug`/`token`).

## Example output

`media-remote-loom.html.twig` builds a responsive wrapper and rewrites the share URL into Loom's
embed URL:

```twig
<div style="position: relative; padding-bottom: 62.5%; height: 0;">
  <iframe src="https://www.loom.com/embed/{{ video_id }}"
          width="{{ width }}" height="{{ height }}" frameborder="0"
          allowfullscreen
          style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe>
</div>
```

`media-remote-google.html.twig` branches on the document `type` and mangles the URL per Google's
embed rules:

```twig
{% if type == 'document' %}
  <iframe src="{{ url }}?embedded=true" width="{{ width }}" height="{{ height }}"></iframe>
{% elseif type == 'spreadsheets' %}
  <iframe src="{{ url }}?widget=true&amp;headers=false" width="{{ width }}" height="{{ height }}"></iframe>
{% elseif type == 'presentation' %}
  {% set url = url|replace({'/pub?': '/embed?'}) %}
  <iframe src="{{ url }}" frameborder="0" width="{{ width }}" height="{{ height }}" allow="fullscreen"></iframe>
{% endif %}
```

## Overriding

Copy the template into your theme's `templates/` directory under the same hyphenated name; no
`hook_theme_suggestions` are provided, so per-bundle variants require your own
`hook_theme_suggestions_HOOK()`. Because `media` is always passed, a common override is to add a
caption or a privacy-consent placeholder around the iframe.

`width`/`height` come from the formatter settings, so a pure sizing change is display config, not
a template override — see [../configure/media-type.md](../configure/media-type.md). Providers with
no `width`/`height` settings (Apple Podcasts, Brightcove, Buzzsprout, Deezer, DocumentCloud,
Libsyn, Panopto, Quickbase, Stitcher) hard-code their dimensions in the template, so those do need
a template override to resize.
