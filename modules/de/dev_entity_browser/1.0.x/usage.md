Developer Entity Browser adds one permission-gated admin report that lists every content entity type on the site with its bundles and each bundle's field structure.

---

The module ships a single read-only dashboard at `/admin/structure/dev-entity-browser` (linked from Reports) that enumerates all content entity types via the entity type manager, keeps only `ContentEntityType` definitions (explicitly skipping `block_content` and `webform_submission`), and for each bundle lists the field definitions with their machine name, label, type, description and cardinality. For selection-style field types (`file`, `image`, `entity_reference`, `entity_reference_revisions`, `list_string`, `list_integer`, `list_float`) it also surfaces the field's `allowed_values` and, for reference fields, the `target_bundles` handler setting by loading the matching `FieldConfig`. There is no settings form, no config storage, no plugins and no Drush; the whole feature is a `DevEntityBrowser` service (building a themed render array) invoked by an invokable controller and rendered through a Twig template. It is a developer inspection aid — useful when Field UI is off or for custom entities that have no admin UI — and reports only field/bundle *structure*, not the stored values of any content.

---

- See at a glance every content entity type that exists on a site, including custom ones.
- Get an overview of a content entity's fields without turning on Field UI.
- Inspect fields of custom entities that ship no administrative UI.
- List all bundles for a given content entity type in one place.
- Read each field's machine name and human label side by side.
- Look up a field's storage/field type quickly (e.g. `string`, `entity_reference`, `image`).
- Check a field's cardinality (single, fixed count, or unlimited).
- Read a field's description text as configured.
- Enumerate the `allowed_values` of list fields (`list_string`, `list_integer`, `list_float`).
- See the target bundles a reference field points at (`entity_reference`, `entity_reference_revisions`).
- Review file/image field settings surfaced from their `FieldConfig`.
- Use the on-page table of contents to jump straight to a specific entity type.
- Jump from an entity type down to a specific bundle via anchor links.
- Audit field architecture across a project during onboarding or handover.
- Spot naming inconsistencies in field machine names across bundles.
- Confirm which entity types are content entities versus config entities.
- Give developers a shared, browsable map of the site's data model.
- Verify a new field's configuration landed on the intended bundle.
- Cross-check a field's aggregated field-map bundles against a single bundle's definitions.
- Grant the "View Dev Entity Browser" permission to a developer/reviewer role for read-only structural access.
- Use as a lightweight alternative to Devel when you only need an entity/field overview.
- Document a site's entity model by browsing the generated report.
