# The entity_reference_revisions field

Field type id: **`entity_reference_revisions`**
(`src/Plugin/Field/FieldType/EntityReferenceRevisionsItem.php`, extends core
`EntityReferenceItem`).

Each field item stores two columns beyond a normal entity reference:

| Property | Meaning |
|---|---|
| `target_id` | Referenced entity ID |
| `target_revision_id` | The specific **revision** of the target that this item points to |
| `entity` (computed) | The loaded target entity (specific revision) |

Add it like any field (via Field UI or config). Because it extends the core reference item it
supports the usual `handler` / `handler_settings` (target type, bundles, sort) settings.

**Widget** — `entity_reference_revisions_autocomplete`
(`FieldWidget/EntityReferenceRevisionsAutocompleteWidget.php`): autocomplete entry of the
referenced entity; on save it records the current revision id.

**Formatters** (`src/Plugin/Field/FieldFormatter/`):
- `entity_reference_revisions_entity_view` — renders the referenced revision in a chosen view
  mode.
- `entity_reference_revisions_label` — shows the target label, optionally linked.

Config schema lives in `config/schema/entity_reference_revisions.schema.yml` (+ a Views schema).
Views integration adds an ERR **row**, **style**, and **display** plugin
(`src/Plugin/views/…`) for listing referenced revisions, and a Migrate **destination** plugin
(`Plugin/migrate/destination/EntityReferenceRevisions.php`) for importing them. With the Diff
module enabled, `Plugin/diff/Field/EntityReferenceRevisionsFieldDiffBuilder.php` compares
referenced content across revisions.
