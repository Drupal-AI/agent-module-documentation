Bundle Reference provides a field type whose stored value is an entity bundle (an entity type ID plus a bundle machine name) rather than a reference to an actual entity.

---

Bundle Reference ships a single field type, `bundle_reference`, with a paired widget and formatter, all in core-only PHP (no dependencies, no routes, no permissions, no config schema). A field value has two columns, `entity_type` and `bundle`, so a single value identifies a bundle such as `node:article` or `taxonomy_term:tags`. The widget presents two cascading `select` elements — first the entity type, then (via AJAX) the bundles of that entity type — and only content entity types are offered. The field settings form lets the site builder tick a whitelist of allowed entity-type/bundle pairs (`referencable_bundles`); when set, both the widget's entity-type list and its bundle list are filtered to that whitelist. The default formatter renders each stored value as a plain `entity_type: bundle` line in an item list. Because the field stores only machine names (not entity IDs), it is useful anywhere content or configuration needs to be parameterised by "which type of thing" instead of "which specific thing".

---

- Add a "Bundle Reference" field to a content type, taxonomy vocabulary, media type, paragraph type, or user, via *Manage fields*.
- Let an editor choose which content type a block, view, or piece of logic should target, by storing e.g. `node:article`.
- Restrict a field so only specific bundles are selectable (e.g. only `node:page` and `node:article`) using the *Referencable bundles* setting.
- Store the target bundle for a custom "list latest N of type X" block whose type is editor-configurable.
- Drive a computed/preprocess routine that behaves differently depending on the referenced bundle.
- Build a mapping entity ("for bundle X, do Y") where X is chosen from a bundle-reference field.
- Configure a paragraph or layout component that renders a chosen bundle's teasers.
- Let editors pick which taxonomy vocabulary a tagging widget should use.
- Parameterise a media gallery by the referenced media type.
- Record which node type a workflow or notification rule applies to, without hard-coding it in code.
- Offer a multi-value bundle-reference field to target several bundles at once (cardinality > 1).
- Filter a Views relationship or contextual logic by an editor-selected bundle.
- Populate a settings/config form fragment where an admin picks an entity type and bundle.
- Store the "source bundle" for an import/sync mapping created by content editors.
- Let a menu or landing-page component reference "all articles" (a bundle) rather than one article.
- Capture the target bundle for a scheduled content-generation or cleanup task.
- Give a distribution/install profile an editable place to say which bundle a feature targets.
- Use the whitelist to expose only editorially relevant bundles and hide system ones.
- Reference a user-entity bundle (role-less "type" grouping) where a site defines multiple user bundles.
- Model "content type of the month" or similar editor-driven type selections.
- Provide analytics or dashboard blocks whose measured bundle is editor-selectable.
- Keep bundle choices as data (exportable field config) rather than code constants.
