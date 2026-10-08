<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Minifier HTML reduces rendered page size by minifying the HTML of every `HtmlResponse` and compressing the inline CSS and JavaScript in that markup, using regular expressions applied on the `kernel.response` event.

---

The module is deliberately minimal: it ships a single event subscriber (`MinifierHtmlSubscriber`) registered as the `minifier_html.minifier` service, and nothing else — no routes, permissions, settings form, config objects, dependencies, or Drush commands. On every response the subscriber checks whether the object is a `Drupal\Core\Render\HtmlResponse`; if so it rewrites the response body, otherwise it leaves the response untouched (so JSON, XML, and file downloads are never modified). The rewrite runs two passes: it compresses `/* … */` block comments and whole-line `//` comments inside `<script>` and `<style>` blocks, then collapses whitespace across the document (removing whitespace immediately before and after tags and reducing any run of whitespace to a single character). The result is a smaller HTML payload — on a sample page here roughly 15% smaller. Installation is the whole configuration story: enable the module and it takes effect on the next request; there is no admin UI and no runtime toggle short of disabling or uninstalling. Because the only condition is the response type, minification is applied uniformly to all HTML responses.

---

- Enable the module to start minifying HTML output with no further setup.
- Reduce rendered page size (about 15% on a sample page here) to trim bytes on the wire.
- Strip redundant whitespace between and around HTML tags.
- Collapse long runs of whitespace in the HTML output to a single character.
- Compress inline JavaScript by removing `/* … */` block comments.
- Compress inline JavaScript by removing whole-line `//` comments.
- Compress inline CSS comments inside `<style>` blocks.
- Rely on it as a dependency-free, zero-config performance add-on.
- Combine with Drupal core CSS/JS aggregation for smaller aggregated assets.
- Use on a site that cannot easily add edge/CDN minification.
- Confirm only `HtmlResponse` output is affected; API/JSON/XML responses are left intact.
- Enable it site-wide knowing it applies to every HTML page uniformly.
- Turn it off simply by uninstalling the module — there is nothing to reconfigure.
- Verify the effect by comparing response byte size with the module on versus off.
- Add it to a performance stack alongside page caching and HTTP cache headers.
- Read `MinifierHtmlSubscriber::minifierHtmlOutput()` to see exactly which passes run.
- Keep expectations aligned with the code: the `stripHtmlComments()` regex exists but is not invoked in this release, so HTML comments are preserved.
- Understand there is no per-route, per-response, or per-content exclusion mechanism.
- Prefer testing on a staging copy before enabling on production, as with any output filter.
- Treat it as a lightweight alternative when a full asset-optimization suite is overkill.
