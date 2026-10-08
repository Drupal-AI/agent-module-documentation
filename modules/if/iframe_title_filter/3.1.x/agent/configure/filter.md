# Configure iFrame Title Filter

There is no settings form (`configure` null). Configuration is enabling the filter on a text format.

## Enable the text filter

1. Go to **Configuration › Content authoring › Text formats and editors**
   (`/admin/config/content/formats`) and edit a format.
2. Check **"Add missing titles to iFrames"** (filter id `filter_iframe_title`).
3. Under **Filter processing order**, drag it to run **after** any HTML-correcting filter and any
   filter that generates iframes (e.g. Media embed, video_filter) — it operates on the final markup.

Enabling in config: add `filter_iframe_title` to the format's `filters` with `status: true` in
`filter.format.<id>.yml`. The filter has no settings of its own.

## What it does (`FilteriFrameTitle::process`)

- `Html::load($text)`, iterate `iframe` elements.
- For each iframe **without** a `title` attribute: `parse_url($src)`; `host = url_pieces['host']`
  (or `"<src> on this website"` if no host); set `title` = `t('Embedded content from @host', ['@host' => $host])`.
- Return `Html::serialize($html_dom)` as a `FilterProcessResult`.
- Author-supplied titles are left untouched. `@host` is a placeholder → escaped by the translation
  system. It is a `TYPE_TRANSFORM_REVERSIBLE` filter (weight 100).

## Media oEmbed integration (no config needed)

`src/Hook/IframeTitleFilterHooks` (autowired service, `#[Hook]` attributes):
- `preprocessMediaOembedIframe()` — on core Media's `media_oembed_iframe`, loads
  `$variables['media']`, and titles any title-less iframe with the oEmbed **resource title**, else
  `"Embedded content from <provider name>"`.
- `theme()` + `themeSuggestionsAlter()` register the `media_oembed_iframe__iframe_title_filter`
  suggestion/theme hook (variables `resource`, `media`, `placeholder_token`) as an override point.
- `.module` wires these via `#[LegacyHook]` shims for the procedural hook names.
