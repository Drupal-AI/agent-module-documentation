# RDF — manual setup guide

**RDF** (`rdf`) adds machine-readable semantic metadata to your site's HTML output
using the **RDFa** specification. It maps your entities and fields to well-known
vocabularies — Schema.org, SIOC, Dublin Core, FOAF — and weaves the corresponding
`typeof`, `property`, `rel`, `about`, and `content` attributes into the existing
themed markup, so search engines, aggregators, and other applications can better
understand your content's structure and relationships. This can help feed rich
results in search engines and support Linked Data / semantic-web integrations.

RDF was part of Drupal core through Drupal 9 and is now maintained as a contributed
module; this **4.x branch requires Drupal core 11.3 or 12**. It ships default
mappings for core's article, page, forum, user, tags, and comment bundles, and it
adds the RDFa attributes automatically at render time — so for those bundles it
does useful work the moment you enable it, with nothing to configure.

The important thing to know is that RDF has **no admin UI and no permissions of its
own**. Mappings are stored as `rdf_mapping` configuration entities (one per
entity-type/bundle, config prefix `rdf.mapping.*`) that are managed in code and
configuration, not through a settings screen. Adjusting or adding mappings — for a
custom content type, or to override a core default — is a developer task done via
config files, update hooks, or the module's `RdfMappingHelper` service. The module
has no runtime dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it exposes no settings form
and no admin pages. Mappings live in configuration and are edited in code/config,
as described below.

## Where it lives in the admin menu

RDF adds no admin menu items. Once enabled, it silently enriches page output with
RDFa attributes based on the active `rdf_mapping` config entities. To customize what
is emitted you edit or add those mappings:

- **In configuration** — export the `rdf.mapping.*` config objects and edit the
  bundle-to-class and field-to-property mappings, then import them back with your
  normal configuration workflow.
- **In code** — read and write mappings through the `RdfMappingHelper` service and
  the `RdfMapping` config entity API, and declare custom namespace prefixes with
  `hook_rdf_namespaces()`.

To confirm it's working, view the page source of a node and look for RDFa
attributes such as `typeof` and `property` on the rendered markup.
