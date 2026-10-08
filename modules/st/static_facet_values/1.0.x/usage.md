<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Facet Values adds a Facets processor that replaces the values a facet displays with static results produced by a custom service you implement.
---
The module ships a "Static facet values" processor for the Facets module plus a service-collection mechanism: any service tagged `static_facet_values` (or implementing `StaticFacetValuesServiceInterface`, auto-tagged via `autoconfigure`) is gathered by `StaticFacetValuesCollection`. When the processor is enabled on a facet you select one of the registered services, and that service is responsible for producing the results shown in the facet widget — decoupling the displayed facet options from the underlying indexed field.

This is a developer-oriented extension point with no admin settings of its own beyond the per-facet processor selection. Setup: create a class implementing `StaticFacetValuesServiceInterface`, register it as an autowired/autoconfigured service, then on the facet's processor settings enable "Static facet values" and choose your service. Use it when facet options should be a fixed/curated list (e.g. predefined ranges, editorial groupings, or externally sourced values) rather than raw index terms.
---
- Show a curated, fixed set of options in a facet widget.
- Replace indexed facet values with editorial labels.
- Provide predefined range buckets as facet options.
- Register a custom service implementing `StaticFacetValuesServiceInterface`.
- Autoconfigure a facet-values service with the `static_facet_values` tag.
- Select a static-values service per facet in the processor settings.
- Enable the "Static facet values" processor on a Facets facet.
- Supply facet options from an external/API source.
- Keep facet options stable regardless of current index contents.
- Group multiple raw values under one displayed facet option.
- Offer multiple static-value strategies and pick one per facet.
- Decouple facet display from Search API field data.
- Present hard-coded taxonomy-like choices without a vocabulary.
- Build A/B or scenario-specific facet option sets.
- Localize facet option labels through your own service.
- Reuse one static-values service across several facets.
- Prototype facet UIs before the index is fully populated.
- Combine with other Facets processors in the pipeline.
- Add computed/derived facet options in code.
- Serve site-search filters that don't map 1:1 to indexed fields.
