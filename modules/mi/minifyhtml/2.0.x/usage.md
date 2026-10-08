Minify Source HTML strips whitespace and (optionally) comments from Drupal's fully-rendered page HTML so pages ship fewer bytes. It hooks in at the very end of the render process via a kernel response subscriber, minifying the entire page rather than just the content area.

---

Minify Source HTML registers an event subscriber (`MinifyHTMLExit`) on `KernelEvents::RESPONSE` at priority `-10000` (very late) that rewrites the HTML of `HtmlResponse` and BigPipe `BigPipeResponse` objects only. When the `minify` config flag is on, it collapses runs of whitespace, trims whitespace around block-level and undisplayed tags, and — if `strip_comments` is enabled — removes HTML comments (keeping IE conditional comments) plus multi-line `/* … */` comments inside `<script>` and `<style>` tags. Content that must not be touched is protected first: `<textarea>`, `<pre>`, `<iframe>`, `<script>`, and `<style>` blocks are swapped for placeholder tokens, the rest of the page is minified, and the originals are restored afterward; `application/ld+json` script blocks and IE conditional comments are handled specially. Because it works on the final response, minification runs before Drupal's page cache stores the response, so the cached copy is already small and there is virtually no per-request cost on a cache hit. An `exclude_pages` path pattern (default `/admin*`) skips minification on matching paths using the path matcher, and the whole feature is off by default (`minify: false`). Settings live in the `minifyhtml.config` config object and are surfaced on the core Performance settings form (`system.performance_settings`) under Bandwidth optimization, gated by the `administer minifyhtml` permission. If minification leaves stray placeholder artifacts it logs a warning and reverts to the unminified content as a safety fallback. The module has no PHP library dependencies and only depends on core `system`.

---

- Reduce page weight by stripping redundant whitespace from rendered HTML.
- Remove HTML comments from the source served to browsers.
- Strip multi-line comments inside inline `<style>` blocks.
- Strip multi-line comments inside inline `<script>` blocks.
- Minify the entire page, not just the content region (unlike the older Minify module).
- Serve smaller pages while keeping the on-disk templates readable.
- Turn minification on for anonymous traffic while excluding admin pages (default `/admin*`).
- Exclude specific pages from minification with path patterns and `*` wildcards.
- Exclude the front page from minification using the `<front>` token.
- Keep `<pre>` blocks byte-for-byte intact so preformatted output is preserved.
- Keep `<textarea>` contents intact so form values are not mangled.
- Preserve `<iframe>` markup while trimming surrounding whitespace.
- Preserve `application/ld+json` structured-data script blocks without breaking newlines.
- Preserve IE conditional comments (`<!--[if …]>`) while dropping ordinary comments.
- Pair with Drupal's internal page cache so the minified HTML is cached once, not per request.
- Work with BigPipe, since BigPipe responses are explicitly minified too.
- Enable or disable minification from the drush CLI (`drush cset minifyhtml.config minify true`).
- Toggle comment stripping from the CLI (`drush cset minifyhtml.config strip_comments true`).
- Deploy minification settings between environments as exported configuration.
- Restrict who can change minification settings via the `administer minifyhtml` permission.
- Configure everything from the core Performance settings page under Bandwidth optimization.
- Cut bandwidth costs on high-traffic anonymous pages.
- Improve perceived load time by shipping fewer bytes over the wire.
- Get a safe automatic fallback to unminified HTML if a regex fails (logged, not broken pages).
- Diagnose minification issues via warnings logged to the `minifyhtml` logger channel.
