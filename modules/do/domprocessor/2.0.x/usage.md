<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DOM Processor API is a developer-only framework that lets other modules alter a page's fully rendered HTML and rewrite its outgoing URLs by registering tagged services.

---

DOM Processor API installs a single response event subscriber that runs late in the request, after Drupal has produced the final `HtmlResponse`. When any registered processor declares that it `applies()` to the response, the module parses the response body into a `\DOMDocument`, hands that DOM to every matching processor so it can mutate elements, then serializes the DOM back into the response. A parallel "URL processor" layer walks all `href`, form `action` and `formaction` attributes in the page (and the target of any `RedirectResponse`) so a module can rewrite outgoing links consistently. There is no UI, no route, no permission and no configuration: you extend it entirely in code by writing a service that implements `DomProcessorInterface` (tagged `domprocessor`) or `UrlProcessorInterface` (tagged `domprocessor_url`). It is a low-level building block for other modules rather than something a site builder enables on its own.

---

- Enable the module as a dependency of a custom or contrib module that needs to post-process rendered pages.
- Append a suffix or badge to every page `<title>` element site-wide.
- Inject a global banner, cookie notice or debug marker into the `<body>` of every HTML page.
- Strip or rewrite specific tags/attributes from the final HTML that upstream render code cannot easily reach.
- Add `rel="nofollow"`, `target`, tracking classes or data-attributes to outbound links across the whole site.
- Rewrite all outgoing link and form-action URLs to add a query parameter (e.g. a campaign or locale token).
- Consistently rewrite URLs in both page links and HTTP redirects so a parameter survives a redirect.
- Domain-rewrite links (e.g. swap a canonical host for a CDN or preview host) across every response.
- Add or normalize UTM / analytics parameters on every internal or external link.
- Inject or adjust `<meta>` tags, Open Graph tags or structured-data markup after rendering.
- Post-process HTML produced by many different modules in one central place instead of many hook implementations.
- Conditionally apply changes only to certain responses by implementing `applies()` (e.g. only admin pages, only anonymous users, only a given path).
- Wrap or annotate specific DOM nodes (tables, images, iframes) discovered via XPath in the final markup.
- Rewrite asset URLs (images, scripts) in the delivered HTML for an offline export or archive.
- Build a "link decorator" module that shares URL-rewriting logic between page links and redirect targets.
- Prototype front-end tweaks that must apply to output from themes and modules you do not control.
- Provide a reusable service other modules can call to run URL processing on ad-hoc HTML.
- Chain several independent processors (each a separate service) that each own one transformation.
- Add automated tests around whole-page HTML output using the shipped `domprocessor_test` example processors as a template.
- Enforce a site-wide HTML policy (e.g. force `loading="lazy"` on images) in a single processor.
