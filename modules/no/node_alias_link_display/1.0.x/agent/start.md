<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Alias Link Display (node_alias_link_display) — agent index

One text filter that rewrites `/node/{nid}`-style links in rendered content to their **path aliases**.
At render time it scans the text for anchor tags whose `href` is `/node/{nid}`, loads that node, and
if a real alias exists swaps the canonical path for the alias — so stored markup keeps the stable
`/node/123` reference while visitors see the readable URL. Version **1.0.1**. Core `^10 || ^11`,
package `SEO`. Trivial module: `configure` null (no settings form of its own), no routes, no services,
no permissions, no drush, no config schema, no plugin *types*. Enable it per text format and it just
runs.

**Display-time rewriting is deliberate:** the stored `/node/123` is the stable reference — it keeps
working when the alias changes, whereas markup rewritten on save would break. Two things to check in
practice: the alias is resolved (a node load + `toUrl()`) **per link, per render**, so a link-heavy
uncached page pays that cost repeatedly; and it alters rendered links, so check interaction with
anything else in the output pipeline — particularly language prefixes and link-tracking modules.

**Solution doc:** [`agent/filters/filter.md`](filters/filter.md) — enabling it per text format, the
plugin definition/attribute, the regex + callback logic, and behaviour gotchas.

Everything you need:
- **Filter plugin:** id `filter_node_alias_link_display`, title "Replace canonical node URLs with
  aliases", type `TYPE_TRANSFORM_IRREVERSIBLE`, weight `100` (runs late).
  `src/Plugin/Filter/NodeAliasLinkDisplayFilter.php`, extends core `FilterBase`.
- **Use it:** *Configuration → Content authoring → Text formats and editors* (`/admin/config/content/formats`),
  edit a format (e.g. Full HTML), enable "Replace canonical node URLs with aliases", save. Zero
  settings — no filter settings form.
- **Logic** (`process()` + `replaceNodeUrlCallback()`): `preg_replace_callback` with regex
  `#<a\s+[^>]*href=["'](/node/(\d+))["'][^>]*>.*?</a>#i` matches each anchor to `/node/{nid}`; loads
  the node via `entity_type.manager`, computes `$node->toUrl('canonical', ['language' => …])->toString()`
  using the render `$langcode` (via `language_manager`), and if the result differs from `/node/$nid`
  does `str_replace($url, $alias, $original)`. Digits-only nid; language-aware alias lookup.
- **Depends on:** nothing declared in info.yml (`dependencies:` absent), though at runtime it consumes
  core `filter`, `node`, `path_alias`, `language`. No submodules.
- **No security surface.** Pure render-stage text transform; the substituted alias comes from core's
  URL generator (path is percent-encoded), matched nids are digits only, no routes/services/callbacks.
