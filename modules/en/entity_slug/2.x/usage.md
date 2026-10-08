Entity Slug adds "Slug" and "Slug Path" field types that convert editor-entered text (with optional tokens) into a URL-friendly slug on save, using a configurable stack of pluggable slugifier transformations.

---

Entity Slug is a generic slugging toolkit for any fieldable Drupal entity. It provides two field types — `slug` (a single URL-friendly identifier) and `slug_path` (a "/"-separated composite of several slugs) — plus a matching widget and formatter. An editor types raw text into the field's textfield widget; on entity save the stored text (`input`) is passed through the field's enabled slugifier plugins in weight order to produce the final URL-safe `value`. Shipped slugifiers cover token replacement (against the host entity), Pathauto's alias cleaner, cross-entity token/alias lookups, taxonomy term-parent lookups, and a short-circuit "first non-empty" selector. Slugifier is an extensible plugin type, so sites can add bespoke slug transformations. The module depends on Pathauto and does not itself enforce uniqueness, routing, or any particular consumption of the slug — you decide where the generated string is used.

---

- Add a URL-friendly identifier field to a content type, alongside the node title.
- Generate a slug from a node's title token (`[node:title]`) with the default token + Pathauto slugifiers.
- Store a normalized, lowercased, punctuation-stripped key derived from a free-text field.
- Build a hierarchical path field (e.g. `section/subsection/item`) with the Slug Path field type.
- Produce stable machine-name-like identifiers for taxonomy terms.
- Derive a slug for a product from its SKU or name for use in a custom URL scheme.
- Create a per-entity key for use in an external system or API export.
- Combine a category token and a title token into a single composite slug.
- Feed a generated slug into a custom route, breadcrumb, or link builder.
- Prefix an item's slug with the name of its top-most parent taxonomy term (Term parent token slugifier).
- Include another entity's URL alias inside a slug via the Entity alias slugifier.
- Pull a field value from a specific referenced entity into a slug via the Entity token slugifier.
- Provide a fallback chain — use a headline field's token if set, otherwise fall back to the title (Short circuit slugifier).
- Force every entity of a bundle to a fixed default slug pattern with the "Force default value" setting.
- Re-normalize existing slugs after changing Pathauto's cleaning settings by re-saving entities.
- Expose the generated slug on the entity's display via the default Slug formatter.
- Add a slug field to a custom entity type to give it clean, human-readable keys.
- Give editors an inline token-tree helper under the slug widget to discover available tokens.
- Create a language-aware alias-derived slug that respects the entity's language.
- Extend slugging behavior by writing a custom Slugifier plugin for a project-specific rule.
- Standardize import keys by slugifying an incoming label field on migration or content creation.
- Generate SEO-friendly identifiers to feed into sitemap or canonical-URL logic downstream.
- Compose multi-segment paths where each segment is independently cleaned to be URL-safe.
