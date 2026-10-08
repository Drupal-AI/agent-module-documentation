<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode Basic Tags (shortcode_basic_tags) — agent index

Bundled **starter tag set** for the Shortcode framework. Submodule of `shortcode`
(`dependencies: shortcode:shortcode`). Package `Input filters`. Core `^11.1 || ^12`, PHP 8.3+.
No permissions, no routes, no config schema of its own. Version 3.0.0.

- **Every bundled tag, its attributes, template and behaviour** → [plugins/tags.md](plugins/tags.md)
- Framework, filter setup and plugin API → parent:
  [../../../3.0.x/agent/start.md](../../../3.0.x/agent/start.md)

## What it provides

Ten `Plugin\Shortcode` plugins in `src/Plugin/Shortcode/` (id = token unless noted):

| Tag | Class | Renders |
|---|---|---|
| `quote` | `QuoteShortcode` | Twig `shortcode_quote` — quote block, optional `author`/`class`. |
| `img` | `ImageShortcode` | Twig `shortcode_img` — image from `src` or `mid` (+`imagestyle`, `alt`). |
| `highlight` | `HighlightShortcode` | inline `<span class="… highlight">` (built directly). |
| `button` | `ButtonShortcode` | Twig `shortcode_button` — link styled as a button. |
| `dropcap` | `DropcapShortcode` | Twig `shortcode_dropcap` — drop-cap span. |
| `item` | `ItemShortcode` | Twig `shortcode_item` — `div`/`span` wrapper (`type`, `class`, `id`, `style`). |
| `clear` | `ClearShortcode` | Twig `shortcode_clear` — float-clearing `div`/`span`. |
| `link` | `LinkShortcode` | Twig `shortcode_link` — aliased link (`path`/`url`, `media_file_url`). |
| `block` | `BlockShortcode` | `block_content` entity via view builder (`id`, `view`). |
| `random` | `RandomShortcode` | random alphanumeric string of `length` (8–99, built directly). |

- **Templates** (`templates/shortcode-*.html.twig`) are registered by
  `src/Hook/ShortcodeBasicTagsHooks.php` (`#[Hook('theme')]`) — `shortcode_quote`, `shortcode_img`,
  `shortcode_button`, `shortcode_dropcap`, `shortcode_item`, `shortcode_clear`, `shortcode_link`.
  Override them in a theme to restyle a tag.
- **`img`** injects `RendererInterface`, `FileUrlGeneratorInterface`, and
  `MediaUrlResolverInterface`; **`link`/`button`** inject `MediaUrlResolverInterface` and
  `use MediaUrlResolverTrait` for the `media_file_url`/`path` handling; **`block`** injects
  `EntityTypeManagerInterface` and calls `$block->access('view')` before rendering.
- All plugins define default attributes with `getAttributes()` and expose usage help via `tips()`.

## Enable

```bash
drush en shortcode_basic_tags -y
drush cr
```

Then enable the *Shortcodes* filter on a text format and tick the individual tags on the filter
settings form (all tags default to enabled via `#[Shortcode(status: TRUE)]`).
