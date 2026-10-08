<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Make a cache context contribute a Vary header

## How it works
- The module's `PageCacheVaryServiceProvider` replaces the core `http_middleware.page_cache` implementation with `Drupal\page_cache_vary\StackMiddleware\PageCacheVary` (extends core `PageCache`).
- Compiler passes `VaryCacheContextPass` and `VaryCacheContextApplyServicePass` collect cache-context services that implement `VaryCacheContextInterface` and inject the list into the middleware.
- On the first computed response for a URL, the middleware reads the vary headers from the participating contexts, stores them once per URL in the `cache.page_vary_metadata` bin, sets `Response::setVary(...)`, and derives the page cache id from the varied header values. Every later request to that URL reuses the stored Vary header (HTTP requires one consistent Vary per URL).

## Implementing a vary-aware context
Implement `Drupal\page_cache_vary\VaryCacheContextInterface` on a cache context service so it declares the request header(s) it varies on. The context is then picked up by the compiler pass and its header is added to the emitted `Vary`.

## Operational notes
- No configuration: enabling the module activates it (requires core `page_cache`).
- Because it replaces a core middleware, test alongside any other module that alters the page cache, and confirm the emitted `Vary` behaves as expected on your CDN/reverse proxy.
- Disable the module to restore the stock internal page cache behavior.
