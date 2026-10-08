# Plyr theming & JS

## Theme hooks (`plyr_theme()`)

| Hook | Variables | Used by |
|---|---|---|
| `plyr_remote_video` | `attributes`, `plyr_settings`, `video_provider`, `video_embed_id` | `plyr_remote_video` formatter |
| `plyr_file_video` | `attributes`, `files`, `plyr_settings` | (declared; file formatters mostly reuse core file markup) |
| `plyr_file_audio` | `attributes`, `files`, `plyr_settings` | (declared) |

Templates live in `templates/` (`plyr-remote-video.html.twig`, `plyr-file-video.html.twig`,
`plyr-file-audio.html.twig`). Override by copying into your theme.

## The remote-video markup

```twig
<div{{ attributes }}
     data-plyr-provider="{{ video_provider }}"
     data-plyr-embed-id="{{ video_embed_id }}"
     data-plyr-config='{{ plyr_settings|json_encode|raw }}'></div>
```

`attributes` already carries the `plyr` and `plyr-player` classes. `plyr_settings` is the compacted
config array (see configure/formatters.md); it is admin-controlled formatter config, JSON-encoded into
the `data-plyr-config` attribute that Plyr reads.

### Overriding player defaults in a template

Merge extra Plyr options before the attribute is rendered:

```twig
{% set plyr_settings = plyr_settings|merge({'loadSprite': false, 'blankVideo': '/'~active_theme_path()~'/assets/video/blank.mp4'}) %}
```

## JS behavior (`js/plyr-player.js`)

`Drupal.behaviors.plyrSetupPlayers` runs `Plyr.setup('.plyr-player', { i18n: {…} })`. It:

- Throws a Drupal error if the global `Plyr` (the CDN library) is missing.
- Passes a full set of translated (`Drupal.t()`) i18n control labels.
- Reads each player's options from its own `data-plyr-config` attribute (Plyr's native behavior), so
  per-instance formatter settings apply automatically.
