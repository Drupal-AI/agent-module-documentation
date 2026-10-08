# Configure Minify Source HTML

## Where

Settings appear on the **core Performance form** — `system.performance_settings` at
**Admin → Configuration → Development → Performance** (`/admin/config/development/performance`),
under the **Bandwidth optimization** section. The module has no admin route of its own; it
adds fields to that form via `hook_form_system_performance_settings_alter()`. The module's
`configure` link points at `system.performance_settings`.

Access to the added fields is gated by the `administer minifyhtml` permission
(`restrict access: true`). Users without it don't see the minify/strip-comments checkboxes
(the exclude-pages textarea is always shown but only saved when the user has access).

## Settings — config object `minifyhtml.config`

Defined in `config/install/minifyhtml.config.yml`, schema in
`config/schema/minifyhtml.schema.yml`. Install defaults shown:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `minify` | boolean | `false` | Master switch. When true, HTML responses are minified. |
| `strip_comments` | boolean | `true` | Also remove HTML comments and multi-line `/* */` comments in `<script>`/`<style>`. Only active when `minify` is on. |
| `exclude_pages` | string | `'/admin*'` | Newline-separated path patterns (leading `/`, `*` wildcard, `<front>` token) where minification is skipped. |

Minification is **off out of the box** (`minify: false`) — you must enable it.

## Enable / disable via drush

```
drush cset minifyhtml.config minify true          # turn minification on
drush cset minifyhtml.config minify false         # turn it off
drush cset minifyhtml.config strip_comments true  # also strip comments
drush cset minifyhtml.config strip_comments false # keep comments
```

`exclude_pages` is a single string; edit it on the form or with
`drush cset minifyhtml.config exclude_pages '/admin*'`. Because these are config, they
export/deploy with `drush config:export`.

## What gets excluded / preserved

- **`exclude_pages`** — the current path is checked against these patterns (lowercased) with
  the path matcher; a match returns early and the page is served unminified. Default `/admin*`
  keeps the admin theme untouched.
- **Preserved tags** — `<textarea>`, `<pre>`, `<iframe>`, `<script>`, `<style>` are pulled
  out to placeholders before minifying and restored after, so their inner content is not
  collapsed. Inline `<script>`/`<style>` still get comment/whitespace cleanup unless it is
  `type="application/ld+json"` (left byte-safe). IE conditional comments (`<!--[if …]>`) are
  never removed.

## Interaction with page cache

The subscriber runs on `KernelEvents::RESPONSE` at priority **-10000** (very late), only on
`HtmlResponse` and BigPipe `BigPipeResponse`. Minification therefore happens **before**
Drupal's internal Page Cache stores the response, so the cached copy is already minified and
there is effectively no minification cost on a cache hit. Enable the core Internal Page Cache
module for anonymous traffic to get the most benefit. If minification leaves stray placeholder
artifacts, the module logs a `minifyhtml` warning and serves the original unminified content
(safe fallback).
