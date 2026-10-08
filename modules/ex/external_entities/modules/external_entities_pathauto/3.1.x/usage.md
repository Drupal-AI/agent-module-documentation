# external_entities_pathauto — usage

Pathauto integration for External Entities. Enabling this submodule lets you generate clean URL
aliases for external entity types with the Pathauto module, the same way you would for nodes or other
content entities. Each external entity type gains an "Automatically generate aliases" checkbox, and a
Pathauto pattern for the derived entity type drives the alias.

---

Because external entities have no local save event, aliases are generated when an entity is loaded
(if the type has alias generation enabled and no alias exists yet). The setting is stored as a
third-party setting on the external entity type config; the module also registers a pathauto alias-type
plugin so Pathauto's bulk generate/delete operations work on external entity types. Requires the
Pathauto module.

---

- Give remote records human-readable, SEO-friendly URLs.
- Configure a Pathauto pattern per external entity type.
- Enable or disable alias generation per type via a checkbox.
- Bulk-generate aliases for existing external entities from Pathauto's UI.
- Bulk-delete aliases for an external entity type.
- Build patterns from mapped external fields (and inherited annotation fields).
- Keep alias generation automatic as new remote records appear.
- Combine with the file-field and Views submodules for a fully browsable remote dataset.
