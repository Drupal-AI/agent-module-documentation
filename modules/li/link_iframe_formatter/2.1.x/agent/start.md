<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Iframe Formatter (link_iframe_formatter) — agent index

One field formatter, `link_iframe_formatter` (label **"Iframe Formatter"**), for core **`link`**
fields. Instead of an anchor, it renders each stored URL as an `<iframe>` that embeds the linked
page inline. Subclasses core's `LinkFormatter` and reuses `buildUrl()`, so the `src` is the ordinary
link-field value run through core `Url` building. No admin page, no permissions, no services, no
plugin types — just a display formatter plus one template.

- Depends on: `drupal:link` (core Link module). Core: `^8 || ^9 || ^10 || ^11`. Package: `Fields`.
- Configure route: **none** (`configure: null`) — set it per field on the entity's **Manage display** tab.
- Provides config schema. No permissions, no drush commands, no plugin types.

> **Embedding delegates rendering to the embedded origin — worth deciding per deployment:**
> 1. **Add `sandbox`** (via a template override) so the embedded page cannot script/navigate the parent.
> 2. **Constrain which hosts may be embedded** — link-field validation and/or a CSP **`frame-src`**
>    directive. Otherwise anyone who can edit the field can frame any page inside the site's chrome.
> 3. **Treat it as a consent question** where a consent/cookie manager is in use — the embedded
>    origin sees the visitor.

## What you'd do → where

- **Select the formatter on a link field, its five settings (width/height/class/scrolling/original),
  and how it renders** → [fields/link_iframe_formatter.md](fields/link_iframe_formatter.md)
- **The `link_iframe_formatter` theme hook, its template/variables, and how to override
  (add `sandbox`, `loading="lazy"`, a `title`, etc.)** → [theming/link_iframe_formatter.md](theming/link_iframe_formatter.md)

## Key facts (real machine names)

- Formatter plugin id: **`link_iframe_formatter`**, class
  `Drupal\link_iframe_formatter\Plugin\Field\FieldFormatter\LinkIframeFormatter`, field type `link`,
  extends `Drupal\link\Plugin\Field\FieldFormatter\LinkFormatter`.
- Settings + defaults: `width` (640), `height` (480), `class` (`''`), `disable_scrolling` (FALSE →
  `scrolling="yes"`), `original` (FALSE). Config schema `field.formatter.settings.link_iframe_formatter`.
  Note: `disable_scrolling` schema type is `string` while the default is boolean — cosmetic mismatch, harmless.
- Theme hook: **`link_iframe_formatter`** (declared in `link_iframe_formatter_theme()`), template
  `templates/link-iframe-formatter.html.twig`; variables `url`, `width`, `height`, `class`,
  `scrolling`, `original`, `path`.
- URL sink: template outputs `src="{{ url }}"` (no `|raw`; Twig autoescape applies). `url` is a core
  `Url` object from `LinkFormatter::buildUrl()`, which falls back to route `<none>` on an invalid URI.
