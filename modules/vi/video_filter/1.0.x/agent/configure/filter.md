# Video Filter — enabling & configuring the filter

## Enable on a text format

*Configuration → Content authoring → Text formats and editors* → edit a format (e.g. Full HTML) →
check **"Video Filter"** under *Enabled filters*, then set its options under *Filter settings*.
There is no standalone settings page (`configure` is null) — everything is per text format.

Filter id: `video_filter`, type `TYPE_TRANSFORM_REVERSIBLE` (stored text keeps the `[video:...]` tag;
markup is generated on render). Filter-order matters (see the security note at the end).

## Per-format settings (schema `filter_settings.video_filter`)

| Setting | Default | Meaning |
|---|---|---|
| `width` | 400 | Default player width (maxlength 4). Blank → no width attr, size via CSS. |
| `height` | 400 | Default player height. |
| `plugins` | `{youtube:1, vimeo:1}` | Checkbox list of enabled provider codecs. Only ticked ones match. |
| `allow_multiple_sources` | TRUE | If on, `[video:URL1,URL2]` picks one URL at random. |

If `plugins` is empty, **all** installed codecs are tried.

## Author syntax

```
[video:https://www.youtube.com/watch?v=uN1qUeId]
[video:https://youtu.be/uN1qUeId autoplay:1]
[video:https://www.youtube.com/watch?v=ID width:640 height:360]
[video:https://www.youtube.com/watch?v=ID ratio:4/3]
[video:https://www.youtube.com/watch?v=ID align:right]
[video:URL1,URL2,URL3]           # random source (allow_multiple_sources)
```

- The tag regexp is `/\[video(\:(.+))?( .+)?\]/isU`. Group 2 = source URL(s); group 3 = inline options.
- Inline options are parsed with `/\s+([a-zA-Z_]+)\:(\s+)?([0-9a-zA-Z\/]+)/i` — **option values are
  limited to `[0-9a-zA-Z/]`** (no spaces, quotes, or angle brackets), so options can't inject markup.
- `align` is whitelisted to `left|right|center`. `ratio` must match `\d+/\d+`.
- Recognized generic options: `width`, `height`, `ratio`, `align`, `control_bar_height`; codecs add
  their own (YouTube: `autoplay`, `loop`, `start`, `theme`, `color`, `related`, playlist via `&list=`).

## How a tag becomes markup

1. For each enabled codec, its `getRegexp()` patterns are tested against the source URL; first match wins
   and its capture groups are stored in `$video['codec']['matches']`.
2. Width/height are resolved from inline options → format defaults, then rescaled to the aspect ratio.
3. `hook_video_filter_video_alter($video)` fires (last chance to change parameters).
4. The codec's `iframe($video)` (or `flash()`, or `html()`) returns the embed data, rendered by the
   matching Twig template: `video-filter-iframe.html.twig`, `video-filter-flash.html.twig` (deprecated),
   or `video-filter-html.html.twig` (`{{ video.html|raw }}` — codec-controlled raw HTML).
5. No codec/iframe match → an HTML comment is emitted (`<!-- VIDEO FILTER - INVALID CODEC IN: ... -->`).

## Editor tips

`FilterInterface::tips()` auto-generates help listing the enabled providers and example syntax; it shows
under the format description on forms where the filter is active.

## Filter ordering / trust (important)

Video Filter emits raw embed HTML (iframes). If you enable it on a format available to **untrusted**
roles, also ensure a "Limit allowed HTML tags" filter runs and that ordering is sane. Prefer enabling this
filter only on formats granted to trusted authors.
