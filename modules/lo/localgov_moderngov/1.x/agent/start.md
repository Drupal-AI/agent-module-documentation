<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov ModernGov (localgov_moderngov) — agent index

Serves ONE public HTML "template page" at `/moderngov-template` that the external **Modern.Gov**
(Civica) democratic-services platform periodically fetches and uses to skin its own generated site.
It does NOT call any external API, store credentials, or fetch council data — the data flow is
outbound only: Modern.Gov pulls this page from your site. The page is your theme's normal page shell
with four literal placeholder tokens left in place of the real content — `{pagetitle}`,
`{breadcrumb}`, `{content}`, `{sidenav}` — which Modern.Gov substitutes on its side. A
`hook_theme()` registers the `page__moderngov_template` template (base hook `page`); the shipped
`templates/page--moderngov-template.html.twig` is an example placement of those tokens that themes
are expected to copy and customize.

The heavy lifting is a `KernelEvents::RESPONSE` subscriber (`HtmlResponseSubscriber`, priority -10)
that post-processes the finished HTML **only** on this route: it rewrites every root-relative URL
(`/…`, but not `//…`) in URI attributes to an **absolute** URL using the request's scheme+host
(Modern.Gov requires absolute asset/link URLs), and it emits three response variants driven by query
parameters — `?nocontent` (empties the first visible `<main>`), `?header` (returns only the
`<header>` plus head `<script>`/`<link rel=stylesheet>` and pre-header body scripts), and `?footer`
(returns only the `<footer>` plus trailing body scripts). BigPipe is disabled on the route
(`_no_big_pipe: TRUE`) since the page is served to anonymous consumers.

- Depends on: nothing (info.yml has no `dependencies`; core only). Composer `require` is empty.
- Core: `^10.5 || ^11.2`. Package: `LocalGov Drupal`.
- No settings page / `configure` route. No permissions of its own (route uses core `access content`).
  No config schema, no drush, no plugin types, no fields, no submodules.
- One route, one service (the response subscriber), one theme hook, two hooks
  (`hook_theme`, `hook_preprocess_html`).

## What you'd do → where

- **Understand/customize the template page: route hack, the four tokens, the `?nocontent`/`?header`/
  `?footer` variants, absolute-URL rewriting, the response subscriber, and how to theme it** →
  [api/template-page.md](api/template-page.md)

## Key facts (real machine names)

- Route: `localgov_moderngov.modern_gov` → path `/moderngov-template`. Defaults use the core PHP
  function as controller: `_controller: json_decode` with `json: '[]'` (returns an empty array, i.e.
  an empty render result so the page template supplies everything), `_title: '{pagetitle}'`.
  Requirement `_permission: 'access content'`. Option `_no_big_pipe: TRUE`.
- Service: `localgov_moderngov.html_response_subscriber` →
  `Drupal\localgov_moderngov\EventSubscriber\HtmlResponseSubscriber`, tag `event_subscriber`,
  subscribes `KernelEvents::RESPONSE` at priority **-10** (method `onRespond`). Static helpers:
  `transformRootRelativeUrlsToAbsolute()`, `emptyContent()`, `toDom()`, `toHtml()`.
- Helper: `Drupal\localgov_moderngov\HeaderFooterExtraction` (all static) —
  `prepareHeader()`, `prepareFooter()`, `extractHeadScriptsAndStyles()`, `extractPreHeaderScripts()`,
  `extractPostFooterScripts()`, `extractMarkup()`, `createEmptyDiv()`, `toHtml()`.
- Theme hook: `page__moderngov_template` (`Constants::PAGE_TPL_NAME`, `'base hook' => 'page'`),
  template `templates/page--moderngov-template.html.twig`.
- Body class added on this route: `page--moderngov-template` (`Constants::PAGE_BODY_CLASS`), set in
  `localgov_moderngov_preprocess_html()`.
- Constants: `Constants::PAGE_TPL_NAME = 'page__moderngov_template'`,
  `Constants::PAGE_BODY_CLASS = 'page--moderngov-template'` (`src/Constants.php`).
- Query-parameter variants of `/moderngov-template`: `?nocontent`, `?header`, `?footer` (presence of
  the key is enough — value ignored).
- Tokens embedded literally in the page (Modern.Gov replaces them): `{pagetitle}`, `{breadcrumb}`,
  `{content}`, `{sidenav}`.
