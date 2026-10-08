<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views_custom_cache_tag — agent start

Adds one Views cache plugin, **`custom_tag`** ("Custom Tag based"), that attaches your own
cache tags to a view. The cached results + rendered output persist until one of those tags is
invalidated. It also strips the entity `*_list` tags core would add, so the view is flushed
only by your tags — you bust it from your own code. Requires `views`. No config UI/route of
its own; everything is set per view display. Package: Views.

- Select & fill in the plugin on a view (Advanced → Caching, tag list, lifespan) → [configure/custom-tag-cache.md](configure/custom-tag-cache.md)
- The `custom_tag` plugin: id, class, options, Twig tokens, config shape → [plugins/custom-tag.md](plugins/custom-tag.md)
- Invalidating the cache from code + the execute-debug flag → [api/cache-invalidation.md](api/cache-invalidation.md)
