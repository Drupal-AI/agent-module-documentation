<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter: heading_id_filter (HeadingIdFilter)

Class: `Drupal\auto_heading_ids\Plugin\Filter\HeadingIdFilter`
(`src/Plugin/Filter/HeadingIdFilter.php`). Annotation `@Filter`: id `heading_id_filter`, title
"Automatically apply identifiers (anchors) to headings in content", type
`FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`, weight `10`. Extends `FilterBase`, implements
`ContainerFactoryPluginInterface`. Injects core's `transliteration` service
(`PhpTransliteration`) via `create()`.

## Install & enable

1. Enable the module: `drush en auto_heading_ids`.
2. Go to `/admin/config/content/formats`, edit a text format (e.g. Full HTML).
3. Check "Automatically apply identifiers (anchors) to headings in content" and save.

There is no settings form and no config schema — the filter has no per-format options. It runs
at filter weight 10, so order it after any filter that alters heading markup.

## How processing works

`process($text, $langcode)` returns `new FilterProcessResult($this->filterAttributes($text))`.

`filterAttributes($text)`:
- Loads the HTML into a DOM with `Html::load($text)` and builds a `\DOMXPath`.
- Queries `//h2|//h3|//h4|//h5|//h6` (h1 is intentionally excluded).
- For each heading node: `$id = $this->transformHeadingToId($heading_tag->nodeValue);` then
  `$heading_tag->setAttribute('id', Html::getUniqueId($id));`.
- Only re-serializes (`Html::serialize()` + `trim()`) if at least one heading was found;
  otherwise returns the original text unchanged (cheap no-op for heading-less content).

Because IDs are applied through the DOM (`setAttribute`) and emitted via `Html::serialize()`, the
attribute value is encoded by the serializer — the filter does not build markup by string
concatenation. `Html::getUniqueId()` also guarantees uniqueness within the rendered fragment,
appending `-2`, `-3`, … to repeated IDs.

## ID generation — transformHeadingToId($heading)

Mirrors migrate `MachineName` / pathauto `AliasCleaner` logic:
1. `transliterate()` the heading text to ASCII (accented/non-Latin chars folded, e.g.
   "Ä Ö Ü äöüåø" → "a-o-u-aouao").
2. `preg_replace('/[^a-zA-Z0-9\/]+/', '-', …)` — collapse everything except letters, digits and
   `/` into the `-` separator (`SEPARATOR` const).
3. Collapse consecutive separators, then `trim()` leading/trailing `-`.
4. `mb_strtolower()`.
5. `Unicode::truncate($value, 128, TRUE)` — cap at 128 chars on a word boundary.

Edge cases (from `tests/src/Unit/HeadingIdFilterTest.php`): a heading that transliterates to
nothing (e.g. an emoji `👽`) yields an empty `id=""`; duplicate `<h2>hello</h2>` headings become
`id="hello"` then `id="hello--2"`.

## Operating notes

- Display-only, irreversible transform: it rewrites rendered output, never the stored field
  value, and has no bearing on access control.
- No dependencies beyond core `filter`; no permissions, routes, services, hooks (only
  `hook_help` in `auto_heading_ids.module`), or drush commands.
- Downstream anchors/TOC/scrollspy can target headings by the generated `id`.
