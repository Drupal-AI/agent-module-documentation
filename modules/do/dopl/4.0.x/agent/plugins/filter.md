<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The dopl filter plugin (`filter_dopl`)

Class `Drupal\dopl\Plugin\Filter\FilterDopl` — `src/Plugin/Filter/FilterDopl.php`.
Extends core `FilterBase`, implements `ContainerFactoryPluginInterface`. The whole
module is this one plugin plus a CSS library and a help hook.

## Annotation

```
@Filter(
  id = "filter_dopl",
  title = "Drupal.org project link filter.",
  description = "Facilitate linking to Drupal.org projects and nodes",
  type = TYPE_MARKUP_LANGUAGE,
)
```

`create()` injects `cache.default` (→ `$this->cache`) and `http_client`
(→ `$this->client`, a `GuzzleHttp\Client`).

## Enable it

1. `composer require drupal/dopl` (dev branch: `drupal/dopl:4.x-dev`), `drush en dopl -y`.
2. Go to **`/admin/config/content/formats`** (route `filter.admin_overview`, the
   module's `configure` target), edit a text format, tick *Drupal.org project link
   filter.* in **Enabled filters**, set its position in the processing order, save.
3. There is **no settings form and no permissions**; a format's own use permission
   governs who can author with it. `tips()` prints the token syntax on this form.

## Token syntax (matched by `process()`)

Two `preg_replace_callback` passes over the text, each dispatching to `getLink()`:

- Projects — pattern `/(?<!\S)(\b)(\w+)(\.(module|theme|translation|installprofile|project))(\b)(\|"([^"]*)")?/`
  Tokens: `name.module`, `name.theme`, `name.translation`, `name.installprofile`,
  `name.project`. All resolve to the same project page.
- Nodes/users — pattern `/(?<!\S)(\b)([a-z0-9#\-]*)(\.(do|issue|gdo|user))(\b)(\|"([^"]*)")?/`
  Tokens: `nid.do`, `nid.issue`, `nid.gdo`, `nid.user`.

`matches[2]` is the name/id, `matches[4]` the suffix, and the optional trailing
`|"custom text"` is captured as `matches[7]` — an author-supplied label that
overrides the fetched title. `(?<!\S)` requires the token to start at a
word/whitespace boundary, limiting mid-word false matches.

## Resolution (`getLink()` → `doplGetLinkData()`)

Cache key `dopl:{suffix}-{name}`. On a hit it decodes the stored JSON; on a miss it
builds the endpoint by suffix and does a Guzzle `GET`:

- module/theme/translation/installprofile/project →
  `https://www.drupal.org/api-d7/node.json?field_project_machine_name={name}`
  (title/url read from `data['list'][0]`).
- do/issue → `https://www.drupal.org/api-d7/node/{id}.json`.
- user → `https://www.drupal.org/api-d7/user/{id}.json` (title from `data['name']`).
- gdo → `https://groups.drupal.org/node/{id}` (title scraped from the page
  `<title>` via `preg_match('#<title>(.+)</title>#iU', ...)`, trimmed of a 15-char
  suffix).

`title`/`url` come from the parsed api-d7 JSON. A successful `doplGetLinkData()`
result is cached `CacheBackendInterface::CACHE_PERMANENT`. Guzzle
`RequestException` is logged via `watchdog_exception('dopl', $e)` and the token is
left as-is (returns `$matches[0]`). The destination host is fixed to
drupal.org / groups.drupal.org; the captured name/id (constrained by the regexes)
is placed only into the api-d7 path/query.

For `.issue` tokens whose api-d7 `type == 'project_issue'`, the visible text
becomes `#{nid}: {title}`, a `title` attribute shows the mapped status (from a
built-in `$status_terms` map, e.g. 1→Active, 8→Needs review, 14→RTBC), and the
anchor is wrapped in
`<span class="project-issue-issue-link project-issue-status-info project-issue-status-{status_id}">…</span>`.

## Emitted markup

```php
$link_variables['title'] = array_key_exists(7, $matches) ? $matches[7] : $link_variables['title'];
$url = Url::fromUri($link_variables['url']);
$url->setOptions($link_variables['options']);
$external_link = Link::fromTextAndUrl($this->t('@title', ['@title' => $link_variables['title']]), $url)->toString();
return $link_variables['prefix'] . $external_link . $link_variables['postfix'];
```

So each resolved token becomes an `<a>` (built by core `Link`/`Url`), optionally
wrapped in the issue-status `<span>`. The link text is passed through
`t('@title', …)` — the `@` placeholder is HTML-escaped by core — and the optional
author label (`matches[7]`) flows through that same escaped placeholder. If no URL
was resolved, the original text is returned untouched.

`process()` returns `new FilterProcessResult($text)` and calls
`setAttachments(['library' => ['dopl/dopl']])`.

## CSS library

`dopl.libraries.yml` defines `dopl` (theme CSS `dopl.css`). `dopl.css` styles the
issue wrapper spans: `.project-issue-status-N a` background colors per status and
line-through on closed states. Attached automatically whenever the filter runs.

## Operational notes

- Resolution is a synchronous outbound HTTP GET at render time on the **first**
  encounter of each distinct token; results are then cached permanently, so clear
  caches to re-resolve. A body with many distinct tokens triggers many first-time
  fetches.
- With no matching project/node, the fetch yields no URL and the token is left as
  plain text (per `tips()`, project-name tokens may still not link if unresolved).
- Help (`hook_help` for `help.page.dopl`) renders `README.txt` inside `<pre>` via
  `Html::escape()`.

## Test

`tests/src/Unit/Plugin/Filter/DoplTest.php` (`@covers FilterDopl`) mocks the Guzzle
client and asserts each token type renders the expected `<a>`.
