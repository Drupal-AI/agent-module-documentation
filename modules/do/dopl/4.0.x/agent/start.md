<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal.org project link filter (dopl) — agent index

A single text-format **filter plugin** that rewrites shorthand tokens in body text
(e.g. `views.module`, `345196.issue`) into resolved links to Drupal.org projects,
nodes, issues, groups.drupal.org nodes and users. Package `Input filters`. Depends
only on core **`filter`**. Core requirement `^9.3 || ^10 || ^11`. License
GPL-2.0-or-later. Version **4.0.x** — this is the 4.x **dev branch**; the info.yml
carries no `version:` line and there is no tagged stable release.

- **The filter plugin, token syntax, the emitted markup, the CSS library, and how to
  enable it on a text format** → [plugins/filter.md](plugins/filter.md)

## What it actually is

- One plugin: `FilterDopl` (id **`filter_dopl`**, title *"Drupal.org project link
  filter."*, type `TYPE_MARKUP_LANGUAGE`), in
  `src/Plugin/Filter/FilterDopl.php`, extending core `FilterBase` and implementing
  `ContainerFactoryPluginInterface`. Injects `cache.default` and `http_client`.
- No settings form, **no permissions**, no routes, no services, no config schema,
  no Drush. `configure` points at core's own `filter.admin_overview`
  (`/admin/config/content/formats`) — you enable the filter per text format there.
- `dopl.module`: `hook_help` for `help.page.dopl` returns `README.txt` wrapped in
  `<pre>` via `Html::escape()`. `dopl.install`: `hook_install` shows a status
  message linking to the text-formats page.
- `dopl.libraries.yml` defines library **`dopl/dopl`** (theme CSS `dopl.css`),
  auto-attached by the filter; it colors issue-status wrapper spans.

## Mechanism (from source)

- `process($text, $langcode)` runs two `preg_replace_callback` passes (project
  tokens, then node/user tokens) into `getLink()`, returns a `FilterProcessResult`
  and attaches the `dopl/dopl` library.
- `getLink()` looks up cache key `dopl:{suffix}-{name}`; on a miss it builds the
  Drupal.org api-d7 URL for the token type, calls `doplGetLinkData()` (Guzzle GET),
  and caches the result `CACHE_PERMANENT`. It emits
  `Link::fromTextAndUrl($this->t('@title', ['@title' => $title]), Url::fromUri($url))`
  wrapped in an optional `prefix`/`postfix`. On no result it returns the original
  matched text unchanged.
- Link text (`@title` placeholder) is escaped by `t()`; the optional author label
  from the `|"..."` suffix flows through the same escaped placeholder.
