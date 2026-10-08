<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shortcode Basic Tags ships a ready-made set of ten `@Shortcode` plugins — `[block]`, `[button]`, `[clear]`, `[dropcap]`, `[highlight]`, `[img]`, `[item]`, `[link]`, `[quote]` and `[random]` — so editors have real WP-style bracket tags to use as soon as the `shortcode` filter is enabled on a text format.

---

The module has no configuration UI, no permissions, and no services of its own — it is purely a collection of `Plugin\Shortcode` classes discovered by the parent `shortcode` module's `plugin.manager.shortcode`. Most plugins render through a Twig template registered via `hook_theme()` (e.g. `shortcode_quote`, `shortcode_img`, `shortcode_button`, `shortcode_dropcap`, `shortcode_item`, `shortcode_clear`, `shortcode_link`); a couple (`highlight`, `dropcap` is via template but `highlight` is inline) build HTML directly in `process()`. Each tag's id defaults to its own token (lowercase, unset in the annotation), takes a handful of attributes (mostly `class`, plus tag-specific ones like `author`, `path`/`url`, `mid`/`imagestyle`, `type`), and several reuse `ShortcodeBase` helpers (`getAttributes()`, `addClass()`, `getUrlFromPath()`, `getTitleFromAttributes()`, `getImageProperties()`) for consistent attribute handling. Like every shortcode plugin, each tag must still be explicitly enabled per text format via `filter_settings.shortcode` before it will be parsed instead of left as literal `[tag]` text.

---

- Wrap editor-entered text in a styled quote block with `[quote author="Ada Lovelace"]...[/quote]`.
- Insert a call-to-action link styled as a button with `[button path="/contact"]Contact us[/button]`.
- Highlight a phrase inline with `[highlight]important[/highlight]` (renders a `<span class="highlight">`).
- Start a paragraph with a stylized drop capital using `[dropcap]T[/dropcap]he rest of the text...`.
- Embed an image by URL or media id with `[img src="..." alt="..."]` or `[img mid="42" imagestyle="medium"]`.
- Wrap text in a plain `<div>` or `<span>` with custom class/id/style using `[item type="span" class="note"]...[/item]`.
- Insert a float-clearing element with `[clear /]` or `[clear type="span"]...[/clear]` for layout cleanup.
- Turn any internal path or absolute URL into a link with `[link path="/about" title="About us"]About[/link]`.
- Get just the resolved URL back by omitting text/closing tag: `[link path="/node/5"]`.
- Embed a reusable custom block instance inline in body text with `[block id="3" view="full"]`.
- Insert placeholder/random alphanumeric text of a given length with `[random length="12"]`.
- Give a link/button/image a direct media file URL instead of a Drupal path via `media_file_url="true"`.
- Add extra CSS classes to any of these tags via the shared `class` attribute pattern.
- Set a custom HTML `id` and inline `style` on link/button/item/clear tags.
- Nest tags, e.g. a `[button]` inside a `[block]`-rendered custom block's own filtered field.
- Use `[quote]` and `[dropcap]` together to build a styled pull-quote layout in an article.
- Enable only a subset (e.g. `quote`, `button`, `highlight`) on a restrictive text format while leaving others off.
- Standardize editorial styling (buttons, quotes, highlights) across a site without teaching editors raw HTML.
- Override or extend these Twig templates (`shortcode-quote.html.twig`, etc.) in a custom theme.
- Provide editors a lightweight `[button]` alternative to hand-writing anchor markup with button classes.
- Insert clearing markup after a floated image or button to fix layout wrapping in body text.
- Build a byline/callout using `[quote author="..."]` where the author name is auto-rendered alongside the text.
- Give editors alt-text-aware image embedding that pulls `alt` from the referenced media entity automatically.
