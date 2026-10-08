# Static Facet Values — manual setup guide

**Static Facet Values** (`static_facet_values`) adds a processor to the
[Facets](https://www.drupal.org/project/facets) module that replaces the values a
facet displays with a fixed, curated set of results produced by a custom service
you write. Instead of the facet options coming straight from an indexed field, they
come from code you control — useful when facet options should be a predefined list:
editorial groupings, predefined range buckets, externally sourced values, or any
choices that don't map one-to-one to raw index terms.

This is a **developer-oriented extension point**. It has no admin settings of its
own beyond selecting the processor and a service on each facet. The module ships a
"Static facet values" processor plus a service-collection mechanism: any service
you tag `static_facet_values` (or that implements
`StaticFacetValuesServiceInterface`, auto-tagged via `autoconfigure`) is gathered
up, and when you enable the processor on a facet you pick one of those registered
services to generate the displayed results. It depends on the Facets module and
works on Drupal 10 and newer.

Because the behavior lives entirely in code you supply, there are no routes, no
permissions, and no admin form of the module's own — the security posture is
whatever your service does.

This guide is written for a **human**. Since using the module means writing and
registering a service, an AI coding agent will get more from the sibling
[`agent/`](../agent/start.md) docs, which include the interface and service
registration details.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Facets module) and enable it.

## How to use it

Using Static Facet Values is a two-part job — a bit of code, then a per-facet
setting:

1. **Write a values service.** Create a class implementing
   `Drupal\static_facet_values\StaticFacetValuesServiceInterface`; it is
   responsible for producing the results shown in the facet widget. Register it as
   an autowired/autoconfigured service (or tag it manually with
   `static_facet_values`). See the [`agent/`](../agent/start.md) docs for the exact
   service definition.
2. **Enable the processor on a facet.** On the facet's configuration, enable the
   **Static facet values** processor and choose your registered service. From then
   on, that service generates the facet's displayed options.

Use it when facet options should be a stable, curated list regardless of what is
currently in the index.
