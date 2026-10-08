# Library renderer — manual setup guide

**Library renderer** (`library_renderer`) attaches asset libraries **only when
they are actually needed on a page**, using rules you declare in YAML. Instead of
loading a library everywhere and hoping aggregation sorts it out, you tell the
module to attach a library when a specific DOM element appears in the output, when
a particular Twig template is used, when a theme hook is invoked, or when a
template suggestion matches. The result is component‑ and DOM‑level rendering that
trims unnecessary CSS/JS from pages that don't need it — which helps page speed and
scores in tools like PageSpeed Insights.

It offers four ways to trigger a library, and you can combine them:

- **`html_tags`** — attach a library when the rendered HTML contains a matching
  DOM element (optionally matching attributes too).
- **`templates`** — attach a library when an exact `template.html.twig` file is
  used.
- **`theme_hooks`** — attach a library when a specific theme hook is invoked.
- **`theme_suggestions`** — fuzzy matching against template suggestions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** for this module — you configure it declaratively in
your `*.libraries.yml` files, as shown below. (Take care with YAML formatting; the
module's matching is sensitive to it.)

## How to use it

Once the module is enabled, extend a library definition in your
`*.libraries.yml` with a `library_renderer` section describing when it should
attach:

```yaml
example_library:
  css:
    component:
      theme/dist/example.css: { minified: true }
  js:
    theme/dist/example.js: { minified: true }
  dependencies:
    - core/jquery
  library_renderer:
    html_tags:
      pre: { }
      code: { attributes: { class: 'language-php' } }
    templates:
      - field.html.twig
    theme_hooks:
      - block
    theme_suggestions:
      - field__paragraph__example
```

With this in place, the library only loads on pages where one of the declared
conditions is met — for example, a page that actually renders a `<pre>` or `<code>`
element, or that uses the `field.html.twig` template. Combine this with
component‑level CSS/JS files to keep each page's payload to what it needs. Clear
the cache after editing `*.libraries.yml` so Drupal re‑reads the definitions.
