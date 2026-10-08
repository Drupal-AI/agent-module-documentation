# Tokens & the drimage Twig function

Provided by `src/Hook/VarbaseMediaTokens.php` (tokens) and
`src/Twig/VarbaseMediaTwigExtension.php` (Twig function). Nothing here needs config.

## Media image-style tokens (type `media`)

| Token | Image style | Size | Notes |
|---|---|---|---|
| `[media:social_large]` | `social_large` | 1200×630 | Built with `ImageStyle::load(style)->buildUrl(uri)`. |
| `[media:social_medium]` | `social_medium` | 600×315 | |
| `[media:social_small]` | `social_small` | 280×150 | |

Resolution (`imageUrl()`): picks the media's `field_media_image` if present and non-empty,
else the media `thumbnail`; returns the image-style URL, or the theme fallback (see below) if
no image entity exists. The image styles must exist (they ship with the Varbase distribution,
not this module).

## Smart node share-image token (type `share-image` / `[node:share-image]`)

`[node:share-image]` returns a social share URL for a node by checking, in order:
`field_media` → `field_image` → `field_video` (each an entity-reference to a media entity),
applying the `social_large` style. If none yields an image it falls back to
`<scheme+host><base>/<active_theme_path>/share-image.png`.

The token type is declared `nested` with sub-tokens `field_media`, `field_image`, `field_video`
(each of token `type` `media`). Typical use: an Open Graph / Twitter-card Metatag field.

> Implementation note: the code advertises a parameterized form
> `[node:share-image:<field>:<style>]`, but the `hook_tokens` branch that would parse it is
> gated on the literal token name `share-image:` (an unreachable exact match), so in practice
> only the plain `[node:share-image]` (→ `social_large`, auto field order) resolves. Use the
> plain token.

## `varbase_media_drimage(src)` Twig function

```twig
{% set drimage = varbase_media_drimage(image_src_url) %}
```

Reverses a raw image URL (e.g. a Canvas/SDC `image-uri` prop already resolved server-side to a
`canvas_parametrized_width` style URL) back to a managed `file` entity, then to its parent
`image` media entity, and returns the `drimage_improved` data array expected by
`vartheme_bs5:dynamic-responsive-image` for client-side responsive rendering. Returns **NULL**
when no matching managed file exists (template should then fall back to a plain `<img>`).

Returned keys include: `fid`, `subdir` (public files dir), `scheme`, `original_source`,
`original_width`/`original_height` (from the media source field, best-effort), `filename`, and
`drimage_improved.settings` values (`core_webp`, `imageapi_optimize_webp`, `threshold`,
`upscale`, `downscale`, `multiplier`, `lazy_offset`), plus `lazyload: 'lazy'`,
`image_handling: 'scale'`, and `focal_point` (whether the `focal_point` module is enabled).
The media lookup runs an entity query with `accessCheck(FALSE)` on bundle `image` /
`field_media_image` — it is a URL→file→media resolver for rendering, not an access decision.
