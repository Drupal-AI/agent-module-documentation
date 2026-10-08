<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundled shortcode tags

All plugins live in `src/Plugin/Shortcode/`, extend `Drupal\shortcode\Plugin\ShortcodeBase`, and
carry a `#[Shortcode]` attribute. Templates are the `templates/shortcode-*.html.twig` files
registered by `ShortcodeBasicTagsHooks::theme()`.

## quote — `QuoteShortcode`
`[quote (class="…" author="…")]text[/quote]`. Defaults `class=''`, `author=''`. Adds a `quote`
class via `addClass()`, renders `shortcode_quote` (`<span class="{{ class }}">`, optional
`{{ author|trans }} wrote:`, body).

## img — `ImageShortcode`
`[img (src="…"|mid="…") (class="…" alt="…" imagestyle="…")/]`. Injects `RendererInterface`,
`FileUrlGeneratorInterface`, `MediaUrlResolverInterface`. If `mid` is set, calls
`mediaUrlResolver->getImageProperties($mid)`; with `imagestyle` set,
`getImageStyleUrl($imagestyle, $path)` for the derivative, else the absolute file URL; media alt
fills an empty `alt`. Renders `shortcode_img` (`<img src class alt>`).

## highlight — `HighlightShortcode`
`[highlight (class="…")]text[/highlight]`. Builds output directly: `<span class="…highlight">text</span>`
where the class string is composed with `addClass()`. No template.

## button — `ButtonShortcode`
`[button path="…" (url="…" title="…" class="…" id="…" style="…" media_file_url=true)]text[/button]`.
`use MediaUrlResolverTrait`; injects `MediaUrlResolverInterface`. Uses `url` if given, else
`getUrlFromPath($path, $media_file_url)`. Builds an attributes array (href/class/id/style/title),
`array_filter`s empties, renders `shortcode_button` (`<a{{ attributes }}><span>{{ text }}</span></a>`).
Adds a `button` class.

## dropcap — `DropcapShortcode`
`[dropcap (class="…")]text[/dropcap]`. Adds a `dropcap` class, renders `shortcode_dropcap`
(`<span class="{{ class }}">{{ text }}</span>`).

## item — `ItemShortcode`
`[item (class="…" id="…" style="…" type=div|d|span|s)]text[/item]`. `type` normalised to `div` or
`span` (default `div`). Attributes array (class/id/style) filtered of empties, renders
`shortcode_item` (`<{{ type }}{{ attributes }}>{{ text|raw }}</{{ type }}>`).

## clear — `ClearShortcode`
`[clear (class="…" id="…" style="…" type=…)]text[/clear]` or `[clear /]`. Like `item` but adds a
`clearfix` class; template `shortcode_clear`.

## link — `LinkShortcode`
`[link path="…" (url="…" title="…" class="…" id="…" style="…" media_file_url=true)]text[/link]`.
`use MediaUrlResolverTrait`; injects `MediaUrlResolverInterface`. Uses `url` or
`getUrlFromPath($path, $media_file_url)`. With text → renders `shortcode_link`
(`<a{{ attributes }}>{{ text }}</a>`) using a filtered attributes array; **without** text/closing
tag it returns just the URL string.

## block — `BlockShortcode`
`[block id="1" (view="full")/]`. Injects `EntityTypeManagerInterface`. Casts `id` to int
(0 → empty), loads the `block_content` entity, **checks `$blockEntity->access('view')`**, then
`getViewBuilder('block_content')->view($entity, $view, $langcode)` and renders it; any exception →
empty string.

## random — `RandomShortcode`
`[random (length="8")/]`. `length` clamped to 8–99. Builds a random string from the alphanumeric
charset `[a-zA-Z0-9]` using `random_int()` (charset limited so `<`/`>` can't appear and skew the
length). No template.

## Notes
- All tags default to **enabled** (`#[Shortcode(status: TRUE)]`) but only apply where the
  *Shortcodes* filter is on and the tag is ticked for that format.
- `getAttributes(defaults, attrs)` supplies defaults for missing attributes on every plugin.
- Override any `templates/shortcode-*.html.twig` in your theme to change a tag's markup.
