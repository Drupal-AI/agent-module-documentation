<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline Style Aggregation merges the scattered inline `<style>` tags of a rendered page into a single `<style>` element in `<head>` to shrink the DOM and speed CSSOM construction.

The module registers an event subscriber on `KernelEvents::RESPONSE` at priority `-10000` (very late) that runs only for main-request `HtmlResponse` objects and deliberately skips `BigPipeResponse` (streaming) responses. For each such response it parses the body with `Symfony\Component\DomCrawler\Crawler` in UTF-8, removes the selected `<style>` tags, concatenates their CSS, and appends one `<style data-generated-by="inline_style_aggregation">` to `<head>`. It preserves the `media` attribute (wrapping the CSS in an `@media` block) and any CSP `nonce` found on the originals, and can optionally minify (strip comments and collapse whitespace).

Configuration lives at `/admin/config/development/performance/inline-style-aggregation` behind the `administer inline style aggregation` permission (restricted). Options are a master `Enable` switch, `Include <head> styles` (with configurable `head_style_selectors` to target only editor artifacts like `head style[data-cke]`), `Preserve media`, and `Minify CSS`. All work happens server-side on the outgoing HTML; there are no anonymous or mutating endpoints.
---
Merge inline styles into a single head tag to reduce DOM size and improve CSSOM performance.
---
- Enable page-wide inline `<style>` aggregation from the settings form.
- Reach the settings at `/admin/config/development/performance/inline-style-aggregation`.
- Grant the `administer inline style aggregation` permission to a trusted role.
- Toggle the master `Enable` switch on or off per environment.
- Turn on `Minify CSS` to strip comments and collapse whitespace in the merged block.
- Turn on `Include <head> styles` to also fold styles already present in `<head>`.
- Restrict head aggregation to CKEditor artifacts via `head style[data-cke]` selectors.
- Add custom `head_style_selectors` in config to target specific injected `<style>` tags.
- Keep `Preserve media` on so `<style media="print">` becomes an `@media print { }` block.
- Rely on automatic `nonce` preservation when a CSP nonce is present on originals.
- Confirm BigPipe streaming responses are skipped automatically (no action needed).
- Verify aggregation applies only to main requests, not sub-requests.
- Inspect the emitted `<style data-generated-by="inline_style_aggregation">` tag to debug output.
- Disable minification when debugging CSS to keep readable output.
- Override the event subscriber service to customise selectors or minification logic.
- Extend `InlineStyleAggregationHtmlResponseSubscriber` for per-route toggling.
- Measure DOM node reduction before and after enabling on a style-heavy page.
- Combine with core CSS aggregation for external stylesheets while this handles inline ones.
- Roll out gradually by enabling only `<body>` styles first, then `<head>` styles.
