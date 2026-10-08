<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Style Aggregation (inline_style_aggregation) — agent index

**Merges inline `<style>` tags from the rendered HTML into a single `<style>` in `<head>` for a smaller DOM and faster CSSOM.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 || ^12 (PHP >=8.1; requires symfony/dom-crawler + symfony/css-selector)
- **Route:** `inline_style_aggregation.settings` → `/admin/config/development/performance/inline-style-aggregation`
- **Permission:** `administer inline style aggregation` (restricted)
- **Service:** `inline_style_aggregation_response` — event subscriber on `KernelEvents::RESPONSE` priority `-10000`
- **Config:** `inline_style_aggregation.settings` (enabled, minify_css, preserve_media, include_head_styles, head_style_selectors)

**Security:** single admin config route, permission-gated and `restrict access: true`; no anonymous or mutating endpoints. Operates only on outgoing main-request `HtmlResponse` (skips BigPipe); preserves CSP nonces.

See [configure/settings.md](configure/settings.md)
