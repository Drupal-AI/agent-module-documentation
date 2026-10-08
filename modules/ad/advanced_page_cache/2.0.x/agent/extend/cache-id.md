<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend the anonymous page-cache id

Advanced Internal Page Cache lets other modules append custom parts to the internal page cache id used by core's `page_cache` module for anonymous responses, so one URL can cache multiple variants.

## Mechanism
`AdvancedPageCacheService` (arguments `@config.factory`) is a service collector: any service tagged `advanced_page_cache_cid` is collected, and its `getAdditionalCacheIdPart()` contribution is folded into the cache id built by the `AdvancedPageCache` stack middleware. `AdvancedPageCacheServiceProvider` wires the collection.

## Implement your own cache-id part
1. Create a class implementing `Drupal\advanced_page_cache\AdvancedPageCacheInterface` with:
   ```php
   public function getAdditionalCacheIdPart(): string;
   ```
2. Register it in your module's `*.services.yml` tagged `advanced_page_cache_cid`:
   ```yaml
   services:
     my_module.page_cache_variant:
       class: Drupal\my_module\MyCacheIdPart
       tags:
         - { name: advanced_page_cache_cid }
   ```

## Bundled example submodules
- **cookie_page_cache** (`CookiePageCache`) — varies the anonymous page cache by a cookie value.
- **ip_page_cache** (`IpPageCache`) — varies the anonymous page cache by client IP.

## Operational notes
Requires core `page_cache`. Adding cache-id parts multiplies the number of cached variants per URL — a high-cardinality part (e.g. raw IP) can bloat the cache and reduce hit rates, so key on bounded/normalized values.
