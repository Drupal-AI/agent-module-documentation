<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bamboo_attach_cacheable_metadata

`bamboo_attach_cacheable_metadata(cacheable_metadata)` — class `BubbleMetadata`, function name id
`bamboo_attach_cacheable_metadata`, service `bamboo_twig_cacheable.twig.bubble_metadata`.

Attaches render-array `#cache` metadata from within a template, so cache tags/contexts/max-age
bubble up to the page response. It builds `['#cache' => array_intersect_key($input, ['tags','contexts','max-age'])]`
— i.e. it **keeps only** the `tags`, `contexts` and `max-age` keys and silently drops anything else.

```twig
{{ bamboo_attach_cacheable_metadata({
  'tags': ['node:1', 'config:system.site'],
  'contexts': ['user.permissions', 'url.path'],
  'max-age': 3600
}) }}
```

Notes:
- Pass an associative array (Twig hash). Unknown keys (e.g. `'foo'`) are ignored.
- `max-age` of `0` means uncacheable; omit it to leave max-age unaffected.
- Use it to declare that a template's output depends on data core didn't already know about.
