<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crosswalk block plugins & the convert pipeline

Three `Block` plugins, all in `src/Plugin/Block/`, all extending `CrosswalkBlockBase`. Each renders only
when the current route carries a `node` parameter; otherwise `build()` returns `[]`. Place them on a node
view display / region like any block.

## The blocks

- **`crosswalk_schema`** — `CrosswalkSchemaBlock`, admin label *"Crosswalk Schema.org"*, category *Crosswalk*.
  `build()` calls `convert($node, 'schemaorg')` and, on success, returns an `html_tag` render element:
  `#tag => 'script'`, `#attributes => ['type' => 'application/ld+json']`, `#value => $output` (the CLI's
  JSON-LD, injected as the script body).
- **`crosswalk_bibtex`** — `CrosswalkBibtexBlock`, *"Crosswalk BibTeX"*. `convert($node, 'bibtex')` →
  `html_tag` `<pre class="crosswalk-bibtex">` with `#value => htmlspecialchars($output)` (escaped).
- **`crosswalk_citation`** — `CrosswalkCitationBlock`, *"Crosswalk Citation"*. Runs `convert()` three times
  (`csl`, `bibtex`, `schemaorg`); if all three are NULL it renders nothing. Otherwise builds
  `#theme => 'crosswalk_citation'` with `#csl_json`, `#bibtex`, `#schemaorg` variables and attaches library
  `crosswalk/citation`.

All three call `applyCacheMetadata($build, $node)` → `CacheableMetadata` with the node as a cacheable
dependency and cache context `route`. So output is cached per node and re-computed when the node changes.

## The shared convert pipeline — `CrosswalkBlockBase::convert()`

For a given node + format string:

1. `serializer->serialize($node, 'json')` (core `serializer` service) → JSON string.
2. `enricher->enrich($json)` — resolves entity references and strips tags (see
   [../api/entity-enricher.md](../api/entity-enricher.md)).
3. Decodes the enriched JSON, computes `resolveUrl()` and sets `$data['_url']`, re-encodes.
4. Runs `new Process(['crosswalk', 'convert', 'drupal', $format])` (Symfony Process, **array argv — no
   shell**), pipes the JSON via `setInput($json)`, `run()`. On `!isSuccessful()` returns **NULL**.
5. `postProcessOutput()` on the CLI stdout, then returns it.

`$format` is never user-supplied — it is a hardcoded literal (`schemaorg` / `bibtex` / `csl`) passed by each
block subclass.

## URL / DOI resolution

- `resolveUrl($data, $node)` → `extractDoi()` first: scans `$data['field_identifier']` for an item whose
  `attr0 === 'doi'` with a non-empty `value`; if found returns `https://doi.org/<value>`. Otherwise returns
  the node's absolute canonical URL (`$node->toUrl('canonical', ['absolute' => TRUE])`).
- `postProcessOutput()` re-injects that URL after conversion: for `schemaorg` it sets `url` on the decoded
  object; for `csl` it sets `URL` on each CSL entry (handles both list and single-object shapes); `bibtex`
  output is returned unchanged.

## The citation widget (theme + library)

- Template `templates/crosswalk-citation.html.twig` renders Bootstrap-style tabs (`nav nav-tabs`) — APA, MLA,
  Chicago, CSL-JSON when `csl_json` is present, plus BibTeX and Schema.org tabs. Each pane has a
  `.crosswalk-copy` copy-to-clipboard button. `csl_json` is passed as `data-crosswalk-csl` (escaped with
  `e('html_attr')`); `bibtex` is Twig auto-escaped; `schemaorg` is emitted with `|raw` inside a
  `<script type="application/ld+json">`.
- Library `crosswalk/citation` (`crosswalk.libraries.yml`): `css/citation.css`, local `js/citation.js`, and
  external **citation-js 0.7** from `cdn.jsdelivr.net`; depends on `core/drupal`.
- `js/citation.js` (`Drupal.behaviors`, wrapped `(function (Drupal){... var Cite = require('citation-js');`):
  reads the CSL-JSON from `data-crosswalk-csl`, uses citation-js to render APA (bundled) and fetches MLA +
  Chicago CSL style XML from `cdn.jsdelivr.net/gh/citation-style-language/styles` at runtime, reformats the
  BibTeX `<pre>`, wires the copy buttons (Clipboard API with a `execCommand('copy')` fallback), and provides a
  tab-switch fallback when Bootstrap's JS is not loaded. Material Symbols icons degrade to a text "Copy" label
  when the icon font is absent.

## Operating notes

- Requires the `crosswalk` binary in PATH and RDF mappings / a crosswalk profile for the content type, or the
  CLI fails and blocks render empty (they fail silently — check `logger.channel.crosswalk` / the CLI manually).
- Blocks only act on node routes; on non-node pages they render nothing.
- Output is content-author driven and access-gated by block placement; there is no route, form, or permission.
