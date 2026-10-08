# Core Context — agent index

Developer plumbing: attach ctools-style **context values** to any entity and expose them as
runtime contexts (context providers) at canonical entity routes and in Layout Builder. No admin
UI (`configure` = null), no permissions, no Drush. Requires `ctools`.

- **Store contexts on an entity (config third-party settings / the `context` field) + the
  ctools.context shape + schema** → [configure/store-contexts.md](configure/store-contexts.md)
- **Read contexts back (the `context` entity handler), the context providers, and extending
  them** → [api/context-handlers.md](api/context-handlers.md)

Key facts:
- `hook_entity_type_alter` gives every entity type a `context` handler: `FieldContextHandler`
  (fieldable) or `SettingsContextHandler` (config entities with third-party settings).
- Field type `context` (id `context`, `no_ui`, unlimited cardinality) stores contexts on
  fieldable entities; config entities store them at third-party setting `core_context` /
  `contexts` (schema `core_context.sequence` = sequence of `ctools.context`).
- Each stored context is `{ id/key, type, label, description, value }`; mapped to a
  `\Drupal\Core\Plugin\Context\Context` via `ctools.context_mapper->getContextValues()`.
- Context providers: `core_context` (Generic aggregator of tag `core_context.context_provider`),
  `core_context.canonical_entity` (CanonicalEntity), and with Layout Builder installed
  `core_context.layout_builder` + a section-component render subscriber.
