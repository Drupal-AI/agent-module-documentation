# RDF — manual setup guide

**RDF** (`rdf`) adds machine‑readable semantic metadata to Drupal's HTML output
using the RDFa specification. It maps your entities and fields to well‑known
vocabularies — Schema.org, SIOC, Dublin Core, and FOAF — and weaves the description
into the existing markup as RDFa attributes (`typeof`, `property`, `rel`, `about`,
`content`). The result is standards‑based structured data that search engines and
aggregators can read alongside the human‑readable page, improving interoperability
and helping generate rich search results.

RDF was part of Drupal core through Drupal 9 and is now maintained as a contrib
module. It describes bundles (content types, vocabularies, users, comments) and their
fields in terms of RDF classes and properties, storing each description as an
`rdf_mapping` config entity (`rdf.mapping.*`), one per entity‑type/bundle. It ships
default mappings for core's article, page, forum, user, tags, and comment bundles, so
enabling the module immediately enriches those. At render time it adds the RDFa
attributes to the themed output and emits the namespace prefixes consumers need to
resolve the vocabulary terms.

RDF works the moment you enable it — the bundled default mappings start producing
RDFa on the relevant pages with no further action. It has **no dedicated admin UI**
and **no permissions of its own**: mappings are managed in code and configuration
rather than through a settings form. It has no dependencies beyond Drupal core, no
submodules, and no site‑wide options to fill in. Developers read and edit mappings
through the `rdf_get_mapping($entity_type, $bundle)` helper and the `RdfMapping`
config‑entity API, and can add namespace prefixes via `hook_rdf_namespaces()`. A
Drupal 7 migrate source plugin is included so legacy RDF mappings can be imported.

This guide is written for a **human**. Because RDF has no admin screens, most real
work happens in code and configuration — for the developer‑facing detail (the
`rdf_get_mapping()` helper, the `RdfMapping` entity, namespace hooks, and RDFa
theming), read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration page to open. Once the module is enabled:

- **Default mappings apply automatically.** Core's article, page, forum, user, tags,
  and comment bundles are mapped out of the box, so their pages start emitting RDFa
  (for example an article carries `schema:Article` / `sioc:Post` markup, users are
  described with FOAF, comments with SIOC).
- **View the result** by loading any node, user, taxonomy‑term, or comment page and
  inspecting the HTML source — you will see `typeof`, `property`, `rel`, `about`, and
  `content` attributes woven into the existing markup.
- **Add or change mappings in config/code.** To map a custom content type to an RDF
  class, or a field to a Dublin Core / Schema.org property, you create or edit an
  `rdf.mapping.*` config entity (typically shipped in a module's
  `config/optional`, set in an install/update hook, or read/written with
  `rdf_get_mapping()`). Because mappings are configuration, you can export them and
  deploy them across environments like any other config.
- **Add namespace prefixes** for your own vocabulary by implementing
  `hook_rdf_namespaces()`.

See the [`agent/`](../agent/start.md) docs for the exact APIs and theming hooks.
