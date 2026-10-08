# minifyhtml — agent start

Minifies Drupal's fully-rendered page HTML (whitespace + optional comments) via a
`KernelEvents::RESPONSE` subscriber running at priority `-10000`, so the whole page is
minified before the page cache stores it. Off by default. Depends only on core `system`.
Settings live in `minifyhtml.config` and appear on the core Performance form
(`system.performance_settings`) under Bandwidth optimization.

- Enable/disable minification, strip comments, exclude pages, drush + page-cache notes → [configure/minifyhtml.md](configure/minifyhtml.md)
- Understand / extend the response subscriber (`MinifyHTMLExit`) → [extend/minifyhtml.md](extend/minifyhtml.md)
