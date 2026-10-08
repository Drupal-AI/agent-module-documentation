Paragraphs Usage adds a **Usage** tab/operation to every Paragraphs type that lists which entity types, bundles, and fields reference that paragraph type, so you can see where a paragraph is used before editing or deleting it.

---

The module has no settings, no permissions of its own, and no config. It works entirely through entity-type alteration: `hook_entity_type_alter()` adds a `paragraphs-usage` link template to the `paragraphs_type` entity, a `RouteSubscriber` registers `entity.paragraphs_type.paragraphs_usage` at `…/{paragraphs_type}/usage` (guarded by core's `administer paragraphs types` permission), and `hook_entity_operation()` plus a local-task/menu deriver surface it in the UI. The controller (`ParagraphsUsageController::getUsage`) calls the `paragraphs_usage.paragraphs_usage_service`, which scans **all** content-entity types and bundles, inspects each `entity_reference_revisions` field, and reports every field whose `handler_settings.target_bundles` includes the paragraph type (correctly handling the `negate` "exclude these bundles" mode too). Results render as a table linking to each host bundle's *Manage fields* page. If `admin_toolbar_tools` is enabled, a menu-link deriver also nests a **Usage** link under each paragraph type in the admin toolbar. It is a read-only reporting tool: it changes nothing, it just answers "what references this paragraph type?".

---

- See every content type / entity bundle that can hold a given paragraph type before deleting it.
- Audit which fields across the site reference a specific paragraph type.
- Find orphaned paragraph types that no field targets anywhere.
- Check the impact of removing a paragraph type from a Paragraphs library.
- Confirm a new paragraph type was actually added to the intended content type's field.
- Discover paragraph reuse across nodes, taxonomy terms, users, media, and other fieldable entities.
- Navigate straight from a paragraph type to the *Manage fields* page of each referencing bundle.
- Include paragraph types that are referenced via an "exclude/negate" reference field configuration.
- Document a site's paragraph architecture for a content model review.
- Give editors a quick "where used" view without querying the database by hand.
- Verify field configuration changes (target bundle add/remove) took effect.
- Support content-migration planning by mapping paragraph-to-bundle relationships.
- Add a Usage local task tab to the Paragraphs type edit UI.
- Surface paragraph usage inside the Admin Toolbar Extra Tools menu tree.
- Catch fields that reference a paragraph type through an unrestricted (any-bundle) reference handler.
- Review usage before renaming or restructuring a paragraph type's fields.
- Spot-check that a shared paragraph type is used consistently across multiple content types.
- Gate access to the usage report behind the existing "administer paragraphs types" permission.
- Provide site builders a paragraph inventory during a Paragraphs cleanup sprint.
