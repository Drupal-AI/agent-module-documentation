<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOM & URL processors — API

How to hook into DOM Processor API. All paths under
`web/modules/contrib/domprocessor/`.

## Install / enable

`composer require drupal/domprocessor` then `drush en domprocessor`. Requires the PHP `ext-dom`
extension (`composer.json` → `require: { "ext-dom": "*" }`). No config, no permissions, no admin
page — enabling it alone does nothing until another module registers a processor.

## The response flow

`DomProcessorEventSubscriber` (`src/DomProcessor/DomProcessorEventSubscriber.php`) subscribes to
`KernelEvents::RESPONSE` with priority `0` (`getSubscribedEvents()`), method `processResponse()`.

- If the response is an `\Drupal\Core\Render\HtmlResponse`:
  - It asks `domprocessor.manager->applies($response)`. Only if **some** processor returns TRUE
    does it do any parsing (cheap no-op otherwise).
  - It reads `$response->getContent()`, parses it into a `\DOMDocument` with
    `$dom->loadHTML($html, $domOptions)` where
    `$domOptions = LIBXML_HTML_NODEFDTD | LIBXML_NOERROR | LIBXML_NOWARNING | LIBXML_NONET | LIBXML_NOENT`.
    (This is HTML parsing, not `loadXML`; `LIBXML_NONET` blocks any network fetch. The input is
    Drupal's own already-rendered response body.)
  - It calls `domprocessor.manager->processDom($dom, $response)`, then writes the result back with
    `$response->setContent($dom->saveHTML())`.
- Else if the response is a `Symfony\...\RedirectResponse`: it calls
  `domprocessor.manager.url->processRedirectResponse($response)` (URL rewriting survives redirects).

## Manager fan-out

- `DomProcessorManager` (`src/DomProcessor/DomProcessorManager.php`) implements
  `DomProcessorInterface`. `applies()` returns TRUE if **any** collected processor applies;
  `processDom()` calls `processDom()` on **each** processor whose `applies()` is TRUE. Processors
  are collected via the `service_collector` tag `domprocessor` (`call: addProcessor`), so ordering
  follows service priority.
- `UrlProcessorManager` (`src/UrlProcessor/UrlProcessorManager.php`) implements
  `ChainedUrlProcessorInterface`. `processUrl()` and `processRedirectResponse()` call **every**
  collected URL processor (note: unlike the DOM manager, `processUrl` does not re-check `applies()`
  per node). Collected via tag `domprocessor_url`.
- `DomProcessorForUrlProcessorManager` (`src/UrlProcessor/DomProcessorForUrlProcessorManager.php`)
  is registered as a `domprocessor`-tagged service (`domprocessor.url`) that bridges URL processors
  into the DOM pass. Its `processDom()` builds a `\DOMXPath` and queries
  `//body//a/@href | //body//form/@action | //body//input/@formaction | //body//button/@formaction`,
  then calls `urlProcessorManager->processUrl($urlNode, $response)` for each matched `\DOMAttr`.
  So registering a `domprocessor_url` service automatically rewrites all page link/form URLs **and**
  redirect targets.

## Interfaces you implement

`src/DomProcessor/DomProcessorInterface.php`:

```
applies(\Drupal\Core\Render\HtmlResponse $response): bool
processDom(\DOMDocument $dom, \Drupal\Core\Render\HtmlResponse $response): void
```

`src/UrlProcessor/UrlProcessorInterface.php`:

```
applies(\Drupal\Core\Render\HtmlResponse $response): bool
processUrl(\DOMAttr $node, \Drupal\Core\Render\HtmlResponse $response): void
processRedirectResponse(\Symfony\...\RedirectResponse $response): void
```

The `Chained*` interfaces (`ChainedDomProcessorInterface`, `ChainedUrlProcessorInterface`) only add
`addProcessor()` and are implemented by the managers; you normally do not implement them.

## Registering a processor (the pattern)

Register a service and tag it. Example from the shipped test module
(`tests/modules/domprocessor_test/`):

`your_module.services.yml`
```
services:
  your_module.dom_processor:
    class: Drupal\your_module\MyDomProcessor
    tags:
      - { name: domprocessor }
  your_module.url_processor:
    class: Drupal\your_module\MyUrlProcessor
    tags:
      - { name: domprocessor_url }
```

- A **DOM processor** (`TestDomProcessor`) returns TRUE from `applies()`, then in `processDom()`
  uses `\DOMXPath` to find nodes (e.g. `//title`) and mutate them (e.g.
  `$node->appendChild($dom->createTextNode(' - Yay!'))`).
- A **URL processor** (`TestUrlProcessor`) rewrites `$node->value` in `processUrl()` and
  `$response->setTargetUrl(...)` in `processRedirectResponse()` — the sample adds a `?yay=1` query
  param, preserving any existing `#fragment`.

## Gotchas

- `applies()` gates cost: if no DOM processor applies, the body is never parsed. Keep `applies()`
  cheap and specific (e.g. path/route/role checks) — it runs on every HTML response.
- The DOM round-trip is `loadHTML` → mutate → `saveHTML`; expect libxml's usual HTML
  normalization of the markup. Only the response `<body>` links are visited by the URL bridge
  (the XPath is `//body//...`).
- Your processor owns the correctness/safety of whatever it injects — this module only parses,
  dispatches and re-serializes the DOM.
