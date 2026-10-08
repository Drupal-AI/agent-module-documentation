<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VERCF adds a Views argument-default plugin ("VERCF Entity Reference"). Configured with a field machine name, it reads that entity-reference field off the current route's node and returns the referenced target ID(s) as the contextual-filter argument.

---

The plugin only reads a configured field from the node in the current route and returns its `target_id` value(s); the argument is consumed by Views' own contextual-filter handling (placeholdered), so there is no raw SQL construction here. Cache contexts include `url` but `getCacheMaxAge()` returns `Cache::PERMANENT`, which can over-cache when the referenced field changes. Note a latent bug in `getArgument()`: `if ($target_id_count = 1)` is an assignment, not a comparison, so multi-value fields always return only the first target. No security-relevant sink.

---

- Filter a View by the entity referenced on the current node.
- Drive a "related items" block from a node's reference field.
- Show content tied to the taxonomy/term referenced by the page node.
- Feed a contextual filter without exposing the ID in the URL.
- Build node-context-aware listings on entity pages.
- Reference a single target ID as the default argument.
- Pass multiple referenced IDs as a comma-separated argument.
- Configure the source field by machine name in the Views UI.
- Avoid writing a custom argument-default plugin for this common case.
- Combine with an entity-reference field to scope a View.
- Populate a sidebar View from the current node's references.
- Use on node canonical routes where the node is a route parameter.
- Keep the argument out of the visible path for cleaner URLs.
- Review the cache max-age if referenced values change often.
- Fix the `= 1` assignment bug if multi-value support is needed.
- Pair with Views relationships for deeper reference chains.
