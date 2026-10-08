VariationCache is a redirect-aware caching layer that wraps any standard Drupal cache backend and adds cache-context support, so a single logical cache item can store many variations (one per context permutation). It is a backport/compatibility shim: the code was merged into Drupal core 10.2, and on core >= 10.2 this module only supplies class aliases pointing at the core classes.

---

VariationCache solves the problem of caching data that varies by cache context (user, permissions, language, URL query args, etc.) without the caller having to build context-specific cache IDs by hand. It exposes a `variation_cache_factory` service; calling `->get($bin)` returns a `VariationCacheInterface` object that wraps the underlying cache bin and understands cacheability metadata. Its `get()`/`set()` accept an array of cache keys plus `CacheableDependencyInterface` objects (the folded cacheability and the "initial"/pre-bubbling cacheability), and internally it follows a chain of `CacheRedirect` value objects to resolve the correct variation for the current request's context values. This is the same mechanism core uses for render caching and dynamic page cache. The module is marked `lifecycle: deprecated` because Drupal core 10.2+ ships `\Drupal\Core\Cache\VariationCache` and friends natively. On those core versions the module's `.module` file and per-class shim files register `class_alias()` entries so any old code referencing `\Drupal\variationcache\Cache\*` continues to resolve to the core classes; on older core it aliases to the bundled `Old\Cache\*` implementation. There is no UI, no config, no permissions, no routes, and no Drush commands — it is purely a developer/API dependency. If your site is on Drupal 10.2 or higher and no code references the module's namespace, you can uninstall it and point at the core classes directly.

---

- Cache data that varies per user, per permission set, per language, or per any registered cache context without hand-rolling cache keys.
- Obtain a context-aware cache bin wrapper via the `variation_cache_factory` service's `get($bin)` method.
- Store a value with `set($keys, $data, $cacheability, $initial_cacheability)` so the correct variation is keyed by the current context values.
- Retrieve the variation matching the current request with `get($keys, $initial_cacheability)`.
- Delete only the active variation of an item with `delete($keys, $initial_cacheability)`.
- Invalidate only the active variation with `invalidate($keys, $initial_cacheability)`.
- Wrap an existing plain cache bin (e.g. a custom bin) to add cache-context awareness on top of it.
- Reproduce core's render-cache / dynamic-page-cache variation behavior in your own module's caching.
- Provide the `VariationCacheInterface` type-hint for services that need context-varying caches on Drupal 9.5 / 10.0 / 10.1.
- Keep legacy contrib/custom code that references `\Drupal\variationcache\Cache\VariationCache` working after upgrading to Drupal 10.2+ (via class aliases).
- Act as a transitional composer dependency so a module can support both pre-10.2 and 10.2+ core with one namespace.
- Use `CacheRedirect` value objects to model "this cache entry redirects to a more specific context-based entry."
- Enforce that a stored item's full cache contexts are a superset of its initial (pre-bubbling) contexts (a `\LogicException` is thrown otherwise).
- Skip caching of items whose cacheability max-age is 0 (uncacheable) automatically.
- Decorate or subclass `VariationCacheFactory` to change how variation bins are built for your site.
- Decorate `VariationCache` itself to add logging, metrics, or alternate redirect strategies.
- Inject `@variation_cache_factory` into a custom service to cache expensive per-context computations.
- Detect whether you can drop the module by checking if `\Drupal\Core\Cache\VariationCache` already exists (core 10.2+).
- Serve as documentation reference for how core's variation caching resolves context permutations via redirect chains.
- Support long-lived caching of access-checked or role-varying render arrays where a plain bin would leak data across users.
- Give framework/library modules a stable API to depend on across the 9.5 -> 11 core range.
- Migrate away cleanly: uninstall the module and rewrite type-hints/imports to `\Drupal\Core\Cache\*` once fully on 10.2+.
- Understand the `variation_cache_factory` core service by reading this shim's small, self-contained implementation.
