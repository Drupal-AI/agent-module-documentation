<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_label — tokens & Twig

**Types** (second arg to `entity_label_render` / `entity_label()`): `singular`
(default), `singular_definite_article`, `singular_indefinite_article`,
`plural`, `plural_definite_article`.

**Twig:**
```twig
{{ entity_label(node) }}            {# singular #}
{{ entity_label(node, 'plural') }}
{{ entity_label(term, 'singular_indefinite_article') }}
```

**Tokens** (on any content entity type that has a bundle):
`[node:label:singular]`, `[node:label:singular-definite-article]`,
`[node:label:singular-indefinite-article]`, `[node:label:plural]`,
`[node:label:plural-definite-article]`.

Values are read from the bundle's `entity_label` third-party settings and
`strip_tags()`ed; results are statically cached per entity-type:bundle:type.
