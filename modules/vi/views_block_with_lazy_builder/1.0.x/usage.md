<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Blocks with Lazy Builder provides a way to add lazy builder behaviour to views blocks, improving cacheability.

---

Views Blocks with Lazy Builder adds lazy-builder behaviour to Views blocks — so a Views block is
rendered via a lazy builder (deferred, per-context rendering) rather than inline, improving cacheability of
the surrounding page (the dynamic Views block doesn't force the whole page to be uncacheable). It depends on
core Views. This helps performance where personalized/dynamic Views blocks would otherwise fragment or bust
page cache.

Use it to improve caching around dynamic Views blocks. It is a performance/rendering feature affecting how
Views blocks render/cache; the block content respects the View's access, and it has no access-control role.
Enable lazy-builder behaviour on the relevant Views blocks.

---

- Add lazy-builder to Views blocks.
- Improve page cacheability.
- Render Views blocks deferred.
- Depend on core Views.
- Avoid busting page cache.
- Handle dynamic Views blocks.
- Respect the View's access.
- Have no access-control role.
- Enable lazy builder on blocks.
- Improve performance.
- Defer block rendering.
- Cache the surrounding page better.
- Handle personalized blocks.
- Configure lazy building.
- Improve Views block caching.
- Render per-context.
- Optimize block rendering.
- Add lazy behaviour.
- Improve caching.
- Configure lazy Views blocks.
