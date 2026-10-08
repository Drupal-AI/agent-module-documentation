<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Minifier HTML — the response subscriber

The module's entire behavior lives in one class. This doc is the fast path so you do not have to
read the source.

## Wiring

- `minifier_html.services.yml` defines service `minifier_html.minifier`:
  - `class: Drupal\minifier_html\EventSubscriber\MinifierHtmlSubscriber`
  - `arguments: []` (no injected dependencies; empty constructor)
  - tag `event_subscriber`
- `MinifierHtmlSubscriber::getSubscribedEvents()` returns
  `[KernelEvents::RESPONSE => ['minifilterHtmlResponse']]`, i.e. it listens on `kernel.response`
  at default priority.

## Gate

`minifilterHtmlResponse(ResponseEvent $event)`:

```php
$response = $event->getResponse();
if ($response instanceof HtmlResponse) {
  $event->getResponse()->setContent($this->minifierHtmlOutput($event->getResponse()->getContent()));
}
```

The only condition is `instanceof Drupal\Core\Render\HtmlResponse`. Every HTML page — anonymous,
authenticated, and admin — is rewritten. Non-HTML responses (`JsonResponse`, `BinaryFileResponse`,
`CacheableResponse` that is not an `HtmlResponse`, redirects, etc.) are not touched.

## The passes (in order)

`minifierHtmlOutput($html)` runs exactly two steps:

1. `stripInlineComments($html)` → calls, in order:
   - `stripScriptTagComments()`: `preg_match_all('/<script[\s\S]*?>[\s\S]*?<\/script>/', …)`, then
     applies the `stripJsComments()` filters to each matched block and `str_replace`s them back.
   - `stripStyleTagComments()`: same, matching `<style…>…</style>`.
   - `stripJsComments()` filters:
     - `'#/\*.*?\*/#s' => ''` — remove `/* … */` block comments.
     - `'#\n([ \t]*//.*?\n)*#s' => "\n"` — remove whole-line `//` comments (the `//` is anchored to
       the start of a line after optional indentation).
2. `compressHtmlOutput($html)` → applies three regexes over the whole document:
   - `'/[^\S ]+\</s' => '<'` — strip non-space whitespace immediately before a `<`.
   - `'/\>[^\S ]+/s' => '>'` — strip non-space whitespace immediately after a `>`.
   - `'/(\s)+/s' => '\\1'` — collapse any whitespace run to its first character.

## Dead code to be aware of

`stripHtmlComments()` (`'/<!--(.|\s)*?-->/' => ''`) is defined but **never called** from
`minifierHtmlOutput()` or anywhere else in this release. HTML comments are therefore **not**
removed by this version — only inline JS/CSS comments and document whitespace are affected. Do not
assume comment stripping from the method's presence; check the call graph.

## Scope and limits

- No configuration: there is no `config/` directory, no schema, no settings form, no route,
  no permission, no hook, no Drush command, no submodule, no library, no dependency
  (`composer.json require` is empty; `.info.yml` lists no `dependencies`).
- No exclusion mechanism: the passes run against the full response string with no per-tag,
  per-route, or per-response opt-out, and none can be added without patching the class.
- To disable, uninstall the module; there is no runtime switch.
- The bundled test is `tests/src/Functional/LoadTest.php` — it only asserts the front page returns
  HTTP 200 with the module enabled; it does not assert minification correctness.
