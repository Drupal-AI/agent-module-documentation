<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOM Processor API (domprocessor) — agent index

A developer API that post-processes the **final rendered HTML** of a response and rewrites
**outgoing URLs**. Other modules extend it by registering **tagged services** (no Drupal plugin
type, no UI). Core requirement `^9 || ^10 || ^11`. Composer requires only `ext-dom`. License
GPL-2.0-or-later. Version 2.0.1 (dir 2.0.x).

- **The two extension points, the event subscriber, how HTML is parsed, and how to register a
  processor** → [api/dom-and-url-processors.md](api/dom-and-url-processors.md)

## What it actually is

- **No routes, no permissions, no config, no `.module`/`.install`, no plugin type.** The whole
  module is: `domprocessor.services.yml` + `src/**`. Extension happens purely in code via service
  tags collected by `service_collector`.
- One event subscriber, `DomProcessorEventSubscriber` (`src/DomProcessor/DomProcessorEventSubscriber.php`),
  on `KernelEvents::RESPONSE`. For an `HtmlResponse` it may parse the body into a `\DOMDocument`
  and let processors mutate it; for a `RedirectResponse` it runs URL processors on the target.

## Services (from `domprocessor.services.yml`)

- `domprocessor.manager` → `DomProcessor\DomProcessorManager` — collects services tagged
  **`domprocessor`** (`service_collector`, `call: addProcessor`). Implements `DomProcessorInterface`.
- `domprocessor.manager.url` → `UrlProcessor\UrlProcessorManager` — collects services tagged
  **`domprocessor_url`** (`service_collector`, `call: addProcessor`). Implements
  `ChainedUrlProcessorInterface`.
- `domprocessor.url` → `UrlProcessor\DomProcessorForUrlProcessorManager` — a bridge, itself tagged
  `domprocessor`, that turns URL processors into a DOM processor by XPath-selecting link/action
  attributes.
- `domprocessor.event_subscriber` → the subscriber, wired to both managers.

## Extension points (interfaces)

- `DomProcessor\DomProcessorInterface` — `applies(HtmlResponse): bool`,
  `processDom(\DOMDocument, HtmlResponse): void`. Tag your service `domprocessor`.
- `UrlProcessor\UrlProcessorInterface` — `applies(HtmlResponse): bool`,
  `processUrl(\DOMAttr, HtmlResponse): void`, `processRedirectResponse(RedirectResponse): void`.
  Tag your service `domprocessor_url`.
- `Chained*` variants (`ChainedDomProcessorInterface`, `ChainedUrlProcessorInterface`) just add
  `addProcessor()` — implemented by the managers, not something you usually implement.

## Example / tests

- `tests/modules/domprocessor_test/` ships `TestDomProcessor` (appends " - Yay!" to `<title>`) and
  `TestUrlProcessor` (adds `?yay=1` to links, form actions and redirects) — the canonical
  copy-me examples. Functional tests: `DomProcessorTest`, `UrlProcessorTest`, `AdminPageTest`.
