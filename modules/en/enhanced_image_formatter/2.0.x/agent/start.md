<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enhanced Image Formatter (enhanced_image_formatter) — agent index

**Overrides the core image formatter to add tokenized ALT/TITLE, link-to-entity / link-field targets, and SVG support.**

- **Version:** 2.0.x (2.0.0)
- **Core:** ^10.3 || ^11
- **Requires:** svg_image, token
- **Formatter:** `EnhancedImageFormatter` (extends svg_image SvgImageFormatter; re-uses core `image` formatter id)
- **Swap-in:** hook_field_formatter_info_alter sets `image` formatter class; install hook raises module weight to run after svg_image
- **Settings:** `tokenizer.alt_text`, `tokenizer.title_text` (token-enabled) + extended `image_link` options (link fields)

**Security:** No routes/permissions — a display formatter. ALT/TITLE token strings are admin-configured and are passed through `Xss::filter(..., Xss::getHtmlTagList())` before being set as `#item_attributes`, then rendered as escaped HTML attributes. No raw/unescaped output path.

See [configure/enhanced_image_formatter.md](configure/enhanced_image_formatter.md)