# Hreflang tags

Adds hreflang MetatagTag support (`<link rel="alternate" hreflang="…">`):

- `hreflang_per_language` — automatically emits one alternate link per available language
  translation of the current entity.
- `hreflang_xdefault` — the `x-default` fallback link.

Enable as a Metatag default (typically global). Relies on Drupal's language/translation
system to know the available translations. Schema:
`config/schema/metatag_hreflang.metatag_tag.schema.yml`.
