<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 10 shipped shortcode tags

All ten plugin ids equal their token (no plugin overrides `token` in its `@Shortcode`
annotation) — so the id used in `filter_settings.shortcode` is exactly what an editor types in
`[brackets]`. Every plugin must be individually enabled per text format (see the parent
module's `agent/configure/enable-filter.md`) before it is parsed.

| id / token | Renders | Key attributes | Template / output |
|---|---|---|---|
| `quote` | Text formatted as a blockquote-style callout, optional attributed author | `class`, `author` | `shortcode-quote.html.twig` (`shortcode_quote` theme hook) |
| `button` | Content wrapped as a link styled like a button | `path` (default `<front>`) or `url`, `title`, `class`, `id`, `style`, `media_file_url` | `shortcode-button.html.twig` (`shortcode_button`) |
| `highlight` | Inline `<span class="highlight">` around text | `class` | Built inline in `process()`, no template |
| `dropcap` | `<span class="dropcap">` for a stylized drop capital | `class` (note: `author` accepted but unused) | `shortcode-dropcap.html.twig` (`shortcode_dropcap`) |
| `img` | An `<img>` tag from a direct `src` or a media entity id | `src`, `mid` (media id — auto-fills `src`/`alt` from the media's file field), `imagestyle`, `alt`, `class` | `shortcode-img.html.twig` (`shortcode_img`) |
| `link` | An aliased link around text, or just the resolved URL if no text/closing tag given | `path` (default `<front>`) or `url`, `title`, `class`, `id`, `style`, `media_file_url` | `shortcode-link.html.twig` (`shortcode_link`) |
| `block` | A rendered custom block-content instance, inline | `id` (block content entity id, required), `view` (view mode, default `full`) | `EntityViewBuilder` render array; no Twig template of its own |
| `item` | A generic `<div>` or `<span>` wrapper with class/id/style | `type` (`div`/`d`/`span`/`s`, default `div`), `class`, `id`, `style` | `shortcode-item.html.twig` (`shortcode_item`) |
| `clear` | A float-clearing `<div>`/`<span>` (adds a `clearfix` class) | `type` (`div`/`d`/`span`/`s`, default `div`), `class`, `id`, `style` | `shortcode-clear.html.twig` (`shortcode_clear`) |
| `random` | Random alphanumeric-range placeholder text | `length` (default 8, clamped 8–99) | Built inline in `process()`, no template |

## Notable behaviors

- **`img` with `mid`**: if a media id is supplied and no `alt` attribute given, alt text is
  pulled from the referenced media entity's file field automatically (`getImageProperties()`).
  `imagestyle` (an image style machine name) is applied to build a styled derivative URL.
- **`link` / `button` with `media_file_url="true"`**: when the resolved path starts with
  `/media/...`, resolves to the direct file download URL of that media entity instead of the
  media's canonical page.
- **`link` with no text and no closing tag** (`[link path="/node/5"]`): returns the bare
  resolved URL string instead of an `<a>` tag — useful for embedding just a URL.
- **`block`**: attribute `id` must be a numeric block-content entity id (`BlockContent::load()`);
  invalid/missing ids render nothing.
- **`item` / `clear`**: `type` accepts `d`/`s` shorthand for `div`/`span`; anything else falls
  back to `div`.
- All ten are registered via `hook_theme()` in `shortcode_basic_tags.module` except `highlight`
  and `random`, which build their HTML string directly with no theme hook.
