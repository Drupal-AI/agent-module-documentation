<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Minifier HTML (minifier_html) — agent index

Reduces rendered page size by minifying the HTML of **every `HtmlResponse`** and compressing the
inline CSS and JavaScript inside it. Works immediately on enable — **no routes, permissions,
settings, config, or dependencies.** Version **11.0.2**. Core `^10.1 || ^11`. Package
*Performance and scalability*. License GPL-2.0-or-later.

## What it actually is

- One service, `minifier_html.minifier` (`minifier_html.services.yml`), tagged `event_subscriber`.
- One class: `MinifierHtmlSubscriber` in
  `src/EventSubscriber/MinifierHtmlSubscriber.php`, implementing `EventSubscriberInterface`.
- It subscribes to `KernelEvents::RESPONSE` (`kernel.response`) and, **only when the response is an
  instance of `Drupal\Core\Render\HtmlResponse`**, replaces the body with a minified version. JSON,
  XML, file and other response types pass through untouched.
- No config objects, no `config/` directory, no schema, no permissions file, no routing file, no
  hooks, no Drush, no plugins, no submodules, no libraries. `composer.json require` is empty.

## How it works (from source)

The subscriber applies plain regular expressions to the response body string, in order:

1. Compress inline CSS/JS comments — `stripInlineComments()` runs `stripScriptTagComments()` then
   `stripStyleTagComments()`, each matching `<script>…</script>` / `<style>…</style>` blocks and
   applying `stripJsComments()` (removes `/* … */` block comments and whole-line `//` comments).
2. Compress the whole document — `compressHtmlOutput()` applies three regexes:
   strip whitespace before a tag (`/[^\S ]+\</s`), strip whitespace after a tag (`/\>[^\S ]+/s`),
   and collapse any whitespace run to its first character (`/(\s)+/s`).
3. HTML comment stripping via `/<!--(.|\s)*?-->/` is defined (`stripHtmlComments()`) but note it is
   not called from `minifierHtmlOutput()` in this release — only the CSS/JS-comment and
   whitespace passes run.

Entry point: `minifilterHtmlResponse()` → `minifierHtmlOutput($html)` →
`stripInlineComments()` + `compressHtmlOutput()`.

## Operate it

- Enable: `drush en minifier_html -y`. Nothing else to do — it takes effect on the next request.
  Disable/uninstall to turn it off; there is no runtime toggle.
- Minification runs on **all** HTML responses, including authenticated and admin pages, because the
  only gate is the `HtmlResponse` type check.

## Solution docs

- Architecture, the event subscriber, the exact regex passes, response coverage, and operational
  notes → [architecture/subscriber.md](architecture/subscriber.md)
