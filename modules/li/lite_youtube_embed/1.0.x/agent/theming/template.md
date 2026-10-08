# Theme hook & template

## `lite_youtube_embed` theme hook

Registered by `lite_youtube_embed_theme()` with variables:

| Variable | Meaning |
|---|---|
| `video_id` | the parsed 11-char YouTube id (→ `videoid` attribute) |
| `label` | the resource title (→ `playlabel` attribute) |
| `entity` | the media entity being rendered (available to overrides) |

## Template

`templates/lite-youtube-embed.html.twig`:

```twig
<lite-youtube videoid="{{ video_id }}" playlabel="{{ label }}"{{ attributes }}></lite-youtube>
```

It emits the [`lite-youtube`](https://github.com/paulirish/lite-youtube-embed) custom element. That
element renders a lightweight thumbnail facade and only injects the real YouTube iframe when the user
clicks play — this is where the performance win comes from. The element is upgraded by the
`lite-yt-embed.js` from the library (attached as `lite_youtube_embed/lite_youtube_embed` by the
formatter).

## Overriding

Override `lite-youtube-embed.html.twig` in your theme to add attributes/classes (the `entity`
variable lets you vary output per media item), or add wrapper markup. The web component itself is
styled by the library's `lite-yt-embed.css`; add your own CSS targeting `lite-youtube` for further
theming.
