Entity Reference Unpublished adds entity-reference selection handlers that let a reference field point at unpublished content (nodes, media, or taxonomy terms), which core's default handlers filter out for users without bypass permissions.

---

Core's entity-reference selection handlers for nodes, media and taxonomy terms (`NodeSelection`, `MediaSelection`, `TermSelection`) restrict autocomplete/select results to *published* entities unless the current user can bypass access. This module provides three alternative selection plugins — `unpublished` (nodes), `unpublished_media` (media) and `unpublished_taxonomy_term` (taxonomy terms) — that extend the generic `DefaultSelection` base class instead of those entity-specific handlers, so the "published only" condition is never added and unpublished entities become referenceable. Each plugin is registered under its own selection `group` and only relabels the target-bundles form field ("Content types" / "Media types" / "Vocabularies"). You use one by editing an entity-reference field's settings and choosing the matching **Reference method** (e.g. "Unpublished Default" for nodes): this sets the field config's `settings.handler` to `unpublished` / `unpublished_media` / `unpublished_taxonomy_term`. The module has no settings page (`configure: null`), no permissions, and no config of its own beyond schema aliases that reuse the default selection schema.

---

- Reference a still-unpublished (draft) node from another node's entity-reference field.
- Build relationships between content before either item is published.
- Let editors pick unpublished media items in a media reference field.
- Allow referencing unpublished taxonomy terms in a term reference field.
- Pre-wire a "related articles" field to drafts that will go live later.
- Curate a landing page that references content scheduled for future publication.
- Maintain menus or link fields that point at not-yet-published pages during staging.
- Keep editorial workflows moving when content must be linked before approval.
- Reference unpublished parent/child content in hierarchical structures.
- Choose the "Unpublished Default" reference method on a node reference field.
- Choose the "Unpublished Media" reference method on a media reference field.
- Choose the "Unpublished Taxonomy term" reference method on a term reference field.
- Populate paragraph or block references with draft content during page building.
- Avoid publishing content prematurely just to make it selectable in a reference.
- Migrate content that references items not yet published without breaking references.
- Set the handler as code (`settings.handler: unpublished`) in field configuration for deployment.
- Support decoupled/editorial previews that need to resolve references to drafts.
- Reference unpublished content in Views-driven relationships via the field's handler.
- Keep the standard published-only behavior on other fields by only switching the handler where needed.
- Let a content model link taxonomy terms that are intentionally kept unpublished.
- Provide authors an autocomplete that surfaces drafts, not just live content.
