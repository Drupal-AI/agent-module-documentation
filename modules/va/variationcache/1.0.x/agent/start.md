<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VariationCache — agent index

Redirect-aware caching that adds cache-context support on top of a plain cache backend.
No UI, config, routes, permissions, or Drush commands. Pure developer/API dependency.

**Deprecated / backport.** The code was merged into Drupal core 10.2. On core >= 10.2 this
module only registers `class_alias()` entries mapping `\Drupal\variationcache\Cache\*` to the
core `\Drupal\Core\Cache\*` classes; on older core it aliases to its bundled `Old\Cache\*`
implementation. If you are on 10.2+ and reference no `variationcache` namespace, uninstall it
and use the core classes directly.

- [Call the variation cache API](api/variationcache.md) — the `variation_cache_factory` service and `VariationCacheInterface` methods.
- [Extend / decorate the cache](extend/variationcache.md) — subclass or decorate the factory and cache, and the class-alias compatibility layer.
