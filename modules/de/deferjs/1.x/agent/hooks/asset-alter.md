<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeferJs — runtime hooks (what actually gets deferred)

Three hooks in `deferjs.module`. All behaviour keys off config `deferjs.settings`; nothing runs until
`module_enable` is truthy.

## `deferjs_help()` (`deferjs.module:15`)
Standard `hook_help()` — prints an About blurb on `help.page.deferjs`. No logic.

## `deferjs_page_attachments(&$page)` (`deferjs.module:28`)
When `module_enable` is truthy, reads the bundled file `js/defer.min.js` with `file_get_contents()` and
inlines it verbatim into `<head>`:
```php
$page['#attached']['html_head'][] = [
  ['#tag' => 'script', '#value' => Markup::create($deferJs), '#weight' => 1],
  'deferJs-library',
];
```
Important: this runs on **every page** (no page/content-type/file filtering here — only `js_alter` filters).
The `#value` is the module's own bundled `@shinsenter/defer.js@3.6.0` asset, not any request/config data, so
`Markup::create()` here carries no injected input. The library declared in `deferjs.libraries.yml`
(`deferjs/deferjs`, path `/js/defer.min.jss`) is **not** used by this path and is never attached elsewhere.

## `deferjs_js_alter(&$js)` (`deferjs.module:49`)
When `module_enable` is truthy, decides whether to stamp `attributes['defer'] = TRUE` on managed JS assets.

Flow:
1. `exclude_page` → split on `\r\n` into `$exclude_page_list`.
2. Current path → alias via `path.current` + `path_alias.manager` (`getAliasByPath()`), giving `$result`.
3. Current node type (`$curentPageContentType`) only when the route is `entity.node.canonical`
   (`$route_match->getParameter('node')->getType()`); empty otherwise.
4. Guard: defer only if
   `module_enable` **and** `$result` (the alias) **not in** `exclude_page_list`
   **and** `$curentPageContentType` **not in** `enabled_content_types`.
5. If the guard passes, loop over `$js`; for each asset whose `'/' . $value['data']` is **not** in the
   `\r\n`-split `exclude_file` list, set `$js[$key]['attributes']['defer'] = TRUE`.

Consequences / gotchas an agent should know:
- **Exact-match only.** `exclude_page` compares the resolved alias with `in_array` — no wildcards
  (`/admin/*` will not match, despite what the unit test fixture implies). `exclude_file` matches the exact
  asset path with a single leading `/`.
- **`enabled_content_types` is an exclude list** (step 4 uses `!in_array`); see `agent/configure/settings.md`.
- **Line endings:** both textareas are split on the literal `\r\n`; values saved with `\n`-only newlines
  will not split into multiple entries.
- **No `node` dependency declared.** `hook_js_alter` calls `->getType()` on the node parameter only on the
  node canonical route, so it is guarded, but the module ships without declaring `node` in info.yml.
- Deferral applies to Drupal-managed/aggregated scripts in `$js`; inline scripts and externally-embedded
  `<script>` tags are unaffected.
