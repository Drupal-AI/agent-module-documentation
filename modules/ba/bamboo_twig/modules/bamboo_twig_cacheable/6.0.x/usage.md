<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Cacheable adds a single Twig function, `bamboo_attach_cacheable_metadata`, that lets a template declare cache tags, cache contexts and a max-age so they bubble up to the page response.

---

This submodule of Bamboo Twig registers one Twig function (`bamboo_attach_cacheable_metadata`, service `bamboo_twig_cacheable.twig.bubble_metadata`) that turns a Twig hash into a render array with a `#cache` key. It keeps only the recognised keys — `tags`, `contexts` and `max-age` — via `array_intersect_key`, silently discarding anything else, and returns that render array so Drupal's render system merges the metadata into the response. It is useful whenever a template pulls in data whose cacheability core cannot infer on its own, letting front-end developers keep the render cache correct without writing PHP or a preprocess hook.

---

- Add a cache tag for an entity a template loaded manually so the page invalidates when it changes.
- Declare that a template's output varies by `user.permissions` via a cache context.
- Vary rendered output by `url.path` or `url.query_args` from Twig.
- Set a `max-age` so a template's output expires after a fixed number of seconds.
- Mark a fragment uncacheable with `max-age: 0`.
- Attach `config:system.site` as a cache tag when a template reads site config directly.
- Bubble cache metadata for a block rendered with Bamboo Twig loader functions.
- Keep the render cache correct after pulling in third-party or computed data.
- Add `languages:language_interface` as a context for language-dependent output.
- Declare dependency on a taxonomy term tag (`taxonomy_term:5`) from a template.
- Combine multiple tags and contexts in one call.
- Avoid writing a preprocess function just to add one cache tag.
- Teach a template's output to invalidate with a specific list cache tag (e.g. `node_list`).
- Vary output by user role using the `user.roles` context.
- Add cacheability metadata when embedding a View or menu manually.
- Ensure editorial changes flush cached pages that reference them.
- Let themers manage caching declaratively from `.html.twig` files.
- Document a fragment's cache dependencies right where the fragment is built.
