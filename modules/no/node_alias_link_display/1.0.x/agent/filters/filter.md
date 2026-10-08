<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Replace canonical node URLs with aliases" text filter

## Install & enable

```bash
composer require drupal/node_alias_link_display
drush en node_alias_link_display -y
```

`info.yml` declares **no** `dependencies:`. At runtime the plugin consumes core services from
`filter`, `node`, `path_alias`, and `language` (all in core), so those must be present — they are on
any standard Drupal 10/11 install. No sub-modules, no permissions, no Drush commands, no config
schema, no routes, no services of its own. `configure` is null (there is no settings form).

## Turn it on for a text format

This module ships exactly one thing: a **filter plugin**. It has no settings form of its own — you
enable it per text format.

UI path: *Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`) → edit a format (e.g. **Full HTML**) → in **Enabled filters**
check **"Replace canonical node URLs with aliases"** → **Save configuration**.

Config equivalent (each text format is `filter.format.<id>`; the filter key is the plugin id):

```yaml
# filter.format.full_html
filters:
  filter_node_alias_link_display:
    id: filter_node_alias_link_display
    provider: node_alias_link_display
    status: true
    weight: 100
    settings: {}
```

`drush cr` after enabling. Because the filter has no settings, `settings` stays `{}`.

## Plugin definition

Class **`NodeAliasLinkDisplayFilter`** in
`src/Plugin/Filter/NodeAliasLinkDisplayFilter.php`, extends core **`FilterBase`**, implements
`ContainerFactoryPluginInterface`. Declared via the PHP `#[Filter]` attribute:

| Attribute | Value |
|---|---|
| `id` | `filter_node_alias_link_display` |
| `title` | "Replace canonical node URLs with aliases" |
| `description` | Replaces anchor `href` attributes linking to `/node/{nid}` with their URL aliases |
| `type` | `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE` |
| `weight` | `100` (runs late in the filter chain) |

`create()` injects three core services: `path_alias.manager` (`AliasManagerInterface`),
`language_manager` (`LanguageManagerInterface`), `entity_type.manager`
(`EntityTypeManagerInterface`). Note: the `path_alias.manager` service is injected but the actual
alias resolution is done through `$node->toUrl()` (see below), not by calling the alias manager
directly.

## What it does at render time

`process($text, $langcode)` runs one `preg_replace_callback` over the filtered text:

```
#<a\s+[^>]*href=["'](/node/(\d+))["'][^>]*>.*?</a>#i
```

- `$matches[0]` = the whole `<a …>…</a>`; `$matches[1]` = `/node/{nid}`; `$matches[2]` = the nid
  (digits only — `\d+`).
- Returns a `FilterProcessResult($text)`.

Per match, `replaceNodeUrlCallback()`:

1. Confirms `is_numeric($nid)` and loads the node via
   `entity_type.manager->getStorage('node')->load($nid)`; bails (returns the anchor unchanged) if it
   is not a `Node`.
2. Resolves the language object for the render `$langcode` via `language_manager->getLanguage()`.
3. Computes `$node->toUrl('canonical', ['language' => $language])->toString()` — this is core's URL
   generator, which returns the alias if one exists (language-aware) and otherwise `/node/{nid}`.
4. Only if the result **differs** from `/node/$nid`, does
   `str_replace($url, $alias, $original)` — swapping the canonical substring for the alias inside the
   anchor. If no alias exists, the anchor is left exactly as-is.

## Behaviour notes / gotchas

- **Display-time only.** Stored markup keeps `/node/123`; the swap happens on every uncached render.
  A link-heavy page pays one node load + `toUrl()` per matched anchor, per render — fine behind a
  cache, worth knowing for uncached link-dense pages.
- **Language-aware:** the alias is resolved for the render language, so translated aliases are used.
- **Regex constraints:** it only matches anchors whose `href` is exactly `/node/{digits}` (no
  scheme/host, no query string, no fragment, no trailing slash). Links written as
  `https://site/node/123`, `/node/123?x=1`, or `/node/123#frag` are **not** matched.
- **`str_replace` scope:** the replacement is a plain `str_replace` of the `/node/{nid}` string
  within the matched anchor, so if that exact string also appeared in the link text it would be
  swapped too — harmless, just noting it.
- **`TYPE_TRANSFORM_IRREVERSIBLE`:** output is not cached as reversible; the filter cannot be used in
  contexts requiring a reversible transform, and (like all filters) ordering vs. other filters is set
  by weight (100 = late).
- The substituted alias comes from core's URL generator (path already percent-encoded), and matched
  nids are digits only — no user-supplied string reaches an unescaped markup sink.
