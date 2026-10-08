# Processor: make_first_facet_active

Single facets processor shipped by the module. Makes a facet's first value active by
default when the visitor arrives with no value selected.

## Registration
- Plugin id: `make_first_facet_active`
- Label: "Make first facet active"
- Description: "If there is no facet selected, the first facet will automatically be selected"
- Type: Facets processor (annotation `@FacetsProcessor`), discovered by the facets
  processor plugin manager (`plugin.manager.facets.processor`).
- Stage: `build` only, priority `55`.
- Class: `Drupal\facet_active_by_default\Plugin\facets\processor\ActiveByDefaultProcessor`
- Implements `BuildProcessorInterface`, `ContainerFactoryPluginInterface`; uses
  `UnchangingCacheableDependencyTrait`.
- Injected services: `kernel`, `request_stack`.
- No configuration/settings: no `buildConfigurationForm`, no default config, no schema.
  The processor is either enabled on a facet or not.

## build() behavior
1. Iterate the facet's results; if ANY result `isActive()`, return results unchanged
   (a value is already selected — do nothing).
2. Collect the facet's enabled `STAGE_SORT` processors. If present, sort the full result
   set with `sortFacetResults()` — a local copy of the DefaultFacetManager sort logic
   that also recurses into child results. This is needed because a build processor
   otherwise cannot see the result set after sorting.
3. Take the first result (`array_key_first`). If it exists:
   - Get its URL string via `$result->getUrl()->toString()`.
   - Store it on the current request: `$request->attributes->set('facet_active_by_default', $url)`.
   - Call `$facet->mergeCacheMaxAge(0)` so the unselected state is not cached and the
     redirect fires on every subsequent visit.
4. Return results.

## Redirect (event subscriber)
`FacetActiveByDefaultSubscriber` on `KernelEvents::RESPONSE`
(`onKernelResponse`): if the request attribute `facet_active_by_default` is set, it
replaces the response with `new RedirectResponse(Url::fromUserInput($path)->toString())`.
Net effect: the visitor is redirected to the first facet value's URL, landing on a
pre-filtered page.

## Block placeholder handling
`hook_block_build_alter()` checks each built block; for a `Drupal\facets\Plugin\Block\FacetBlock`
whose facet has this processor at STAGE_BUILD, it sets `$build['#create_placeholder'] = FALSE`.
This prevents the facet block from rendering in a deferred lazy-builder placeholder, so the
active-by-default decision (and its redirect) happens during the main request.

## Enabling on a facet (UI)
1. Requires the Facets module and at least one configured facet (Search API or core
   search source). This module declares no dependency in info.yml but does not function
   without `facets`.
2. Edit the facet at Admin > Configuration > Search and metadata > Facets (route
   `entity.facets_facet.edit_form`, path `/admin/config/search/facets/<facet>/edit`).
3. In the processor / "Facet settings" area, enable "Make first facet active". There are
   no extra options for this processor.
4. Optionally enable/configure a sort processor on the same facet to control which value
   counts as "first".
5. Save the facet.

## Verify
- Confirm the module is enabled: `ddev drush pm:list --status=enabled | grep facet_active_by_default`.
- Confirm the processor is registered:
  `ddev drush php:eval '$d=\Drupal::service("plugin.manager.facets.processor")->getDefinitions(); echo isset($d["make_first_facet_active"]) ? "ok" : "missing";'`
  (if missing after enabling, run `ddev drush cr` — annotation-based facets processors
  are cached by the plugin manager).
- Functional check: load a facet-driven listing with no facet in the URL; the response
  should be an HTTP redirect to the URL of the facet's first value.

## Caveats / notes
- Only meaningful on facets that produce at least one result; with zero results nothing
  happens.
- Because it forces `cacheMaxAge(0)` on the facet and disables block placeholdering, a
  facet using this processor is effectively uncacheable on that request path.
- Redirect uses the first result AFTER the facet's own sort processors run, so ordering
  is deterministic per your sort configuration.
