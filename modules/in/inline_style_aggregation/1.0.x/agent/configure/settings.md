<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Inline Style Aggregation

Form: `Drupal\inline_style_aggregation\Form\InlineStyleAggregationSettingsForm`
Route: `/admin/config/development/performance/inline-style-aggregation`
Config object: `inline_style_aggregation.settings`

Keys:
- `enabled` (bool) — master switch.
- `minify_css` (bool) — strip comments / collapse whitespace in the merged block.
- `preserve_media` (bool) — wrap `<style media="…">` CSS in an `@media` block.
- `include_head_styles` (bool) — also aggregate `<style>` already in `<head>`.
- `head_style_selectors` (list) — CSS selectors limiting which head styles are folded, e.g. `head style[data-cke]`, `head style[data-mce-bogus]`.

Set via Drush:
```bash
drush cset inline_style_aggregation.settings minify_css 1 -y
drush cset inline_style_aggregation.settings include_head_styles 0 -y
```

Behaviour: the subscriber runs at `KernelEvents::RESPONSE` priority `-10000`, only on main-request `HtmlResponse` (not `BigPipeResponse`), parses with DomCrawler (UTF-8), removes matched `<style>` tags, and appends one `<style data-generated-by="inline_style_aggregation">` (carrying a `nonce` when the originals had one) to `<head>`.
