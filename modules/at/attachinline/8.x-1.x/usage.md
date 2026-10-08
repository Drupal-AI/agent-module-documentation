<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attach Inline is a developer utility that lets a render array carry inline JavaScript or CSS directly through `#attached`, without defining a `*.libraries.yml` library for a two-line snippet.

---

Drupal's asset system is deliberately strict — assets come from libraries declared in `*.libraries.yml` and are attached by name, which buys aggregation, dependency ordering and one auditable place — and it has no built-in path for a snippet that exists only for a single render array, the case Drupal 7's `drupal_add_js($js, 'inline')` used to cover. Attach Inline supplies that path properly by adding two new keys, `js` and `css`, under a render array's `#attached`, each taking a list of snippet arrays (or plain strings). A JS snippet accepts `data` (the code, required), `scope` (`header` or `footer`, default footer), `group`, `weight`, `attributes` (merged onto the `<script>` tag) and `dependencies` (real library names, forced into the header via a synthetic `attachinline/<library>` proxy when the snippet is header-scoped); a CSS snippet accepts `data`, `group`, `weight` and `attributes` (e.g. `media`). Under the hood it replaces core's `html_response.attachments_processor` service and decorates the asset resolver, library discovery and the JS/CSS collection renderers so snippets travel through the normal pipeline and are emitted as `<script>`/`<style>` tags at the end of their collection. There is no UI, route or permission — it is code-only, on core `^10 || ^11 || ^12`, version **8.x-1.9**, with no module dependencies. When the **Content Security Policy** module (`drupal/csp`, suggested) is installed it automatically adds a CSP **hash** (default) or **nonce** for each inline tag so the policy need not allow `'unsafe-inline'`; the method is chosen by the single config key `attachinline.settings:csp-allow-method` (set via `drush config:set`, there is no form). Because the inline `data` is emitted unescaped (via `AttachInlineMarkup`, like core's `Markup::create`), only ever pass known-safe strings and sanitise any dynamic value in your own code before attaching it.

---

- Attach a two-line script to one render element.
- Add an inline `<script>` without a library file.
- Add an inline `<style>` to a single element.
- Initialise a JS widget with a small inline snippet.
- Pass a tiny configuration into inline JavaScript.
- Scope an inline script to the page header.
- Keep an inline script in the footer (the default).
- Declare a real library as a snippet dependency.
- Force a header snippet's dependency into the `<head>`.
- Order snippets with `group` and `weight`.
- Add attributes such as `defer` or `media` to the tag.
- Add scoped one-off CSS to a block or view.
- Port a Drupal 7 `drupal_add_js(..., 'inline')` call.
- Avoid inventing a library for a single use.
- Avoid pasting a raw `<script>` tag into markup.
- Keep inline assets inside the asset pipeline.
- Add a small tracking or analytics snippet to one page.
- Attach a conditional polyfill inline.
- Add a CSP hash automatically for each inline tag.
- Use a CSP nonce instead of a hash for inline tags.
- Satisfy a strict CSP without `'unsafe-inline'`.
- Prototype a front-end tweak quickly from a custom module.
