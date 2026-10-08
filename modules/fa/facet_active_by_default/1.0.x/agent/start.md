# Facet Active by Default — agent index

Add-on for the contrib Facets module. Provides ONE facets build processor,
`make_first_facet_active`, that auto-selects a facet's first value when nothing is
active and redirects the request to that filtered URL. Requires `facets` at runtime
(info.yml declares no dependency, package "Custom", placeholder description).

No settings form (`configure` null), no permissions, no config schema, no Drush,
no submodules, no libraries. The only choice is enabling the processor on a facet.

- **How the processor works, how to enable it on a facet, sort interaction, caching,
  block placeholdering, and verification** → [plugins/processor.md](plugins/processor.md)

Key facts:
- Processor plugin id `make_first_facet_active`, label "Make first facet active",
  stage `build` (priority 55). Class `ActiveByDefaultProcessor` implements
  `BuildProcessorInterface`, annotation `@FacetsProcessor`.
- `build()`: if any result is already active, returns unchanged. Otherwise it runs the
  facet's enabled STAGE_SORT processors (copied sort logic incl. children), takes the
  first result, sets request attribute `facet_active_by_default` to that result URL,
  and calls `$facet->mergeCacheMaxAge(0)`.
- `FacetActiveByDefaultSubscriber` (KernelEvents::RESPONSE) reads that request attribute
  and returns a `RedirectResponse` to the stored URL.
- `hook_block_build_alter()` sets `#create_placeholder = FALSE` on any `FacetBlock`
  whose facet has this processor, so the redirect decision runs in the main request.
- Enable per facet on the facet edit form (processor / facet-settings section). No
  per-processor options.
