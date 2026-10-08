<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Able Player — theme hooks, templates & libraries

`ableplayer_theme()` registers these theme hooks (templates in `templates/`); override in your theme
by copying the template.

| Theme hook | Template | Renders |
|---|---|---|
| `ableplayer_video` | `ableplayer-video.html.twig` | `<video data-able-player {{ attributes }}>` with `<source>` per file, plus `{{ caption }}`/`{{ chapter }}` |
| `ableplayer_audio` | `ableplayer-audio.html.twig` | `<audio data-able-player>` with sources + caption |
| `ableplayer_remote_video` | `ableplayer-remote-video.html.twig` | `<video data-able-player data-youtube-id / data-vimeo-id …>` |
| `ableplayer_caption` | `ableplayer-caption.html.twig` | `<track kind="captions" …>` per caption file |
| `ableplayer_chapter` | `ableplayer-chapter.html.twig` | chapter `<track>` |
| `ableplayer_sign_language` | `ableplayer-sign-language.html.twig` | sign-language source data |
| `ableplayer_poster_image` | `ableplayer-poster-image.html.twig` | poster image markup |

There are also base-hook field template suggestions: `field__field_ableplayer_media_caption`,
`field__ableplayer_caption`, `field__ableplayer_chapter`, `field__ableplayer_sign_language`,
`field__ableplayer_poster_image` (templates `field--*.html.twig`), and a
`media__able_player_caption_view_mode` suggestion for the caption view mode.

## Player markup / data-attributes

The player is activated by the `data-able-player` attribute on the `<video>`/`<audio>` tag; Able
Player's JS scans for it. Remote video adds:
- YouTube: `data-youtube-id`, optional `data-youtube-desc-id`, `data-youtube-sign-src`.
- Vimeo: `id` (unique), `data-vimeo-id`, optional `data-vimeo-desc-id`.

Local video sources may carry `data-sign-src` (from `ableplayer_sign_language`) and a `poster`
attribute (rendered from `ableplayer_poster_image`); audio uses `data-poster`.

## Attached libraries (`ableplayer.libraries.yml`)

Templates call `{{ attach_library('ableplayer/ableplayer') }}`:

- **`ableplayer/ableplayer`** (v5.0.0) — local `css/ableplayer.min.css` + `js/ableplayer.min.js`;
  depends on `core/jquery` and `ableplayer/ableplayer-cookie`.
- **`ableplayer/ableplayer-cookie`** (js-cookie 3.0.1) — loaded **from CDN**
  (`cdn.jsdelivr.net/npm/js-cookie@3.0.1`, `external: true`).
- **`ableplayer/ableplayer-vimeo`** — the Vimeo player API **from CDN**
  (`player.vimeo.com/api/player.js`), attached only for Vimeo remote videos.

Note the two external CDN JS assets load without SRI; self-host them if third-party/CDN loading is a
concern for your site. The core Able Player library itself is vendored locally under `js/`.
