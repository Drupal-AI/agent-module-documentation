# Configure the IEF widgets

IEF has **no settings page**. You enable it per entity-reference field on the parent
bundle's **Manage form display** tab (`/admin/.../form-display`) by choosing a widget:

- **Inline entity form - Simple** (`inline_entity_form_simple`) — single referenced entity,
  form embedded directly. `field_types`: `entity_reference`, `entity_reference_revisions`.
- **Inline entity form - Complex** (`inline_entity_form_complex`) — multiple entities in a
  drag-sortable table with Add new / Add existing buttons. Same field types.

Both are `FieldWidget` plugins extending `InlineEntityFormBase` (this module does **not**
define a new plugin type — it uses core's `@FieldWidget`).

## Widget settings (the gear icon)

Stored in the form display config; schema in `config/schema/inline_entity_form.schema.yml`.

| Setting | Meaning |
|---|---|
| `form_mode` | Which entity form mode renders the child form (default `default`). |
| `override_labels` + `label_singular` / `label_plural` | Custom button/message labels. |
| `allow_new` | Allow creating brand-new referenced entities. |
| `allow_existing` | Allow attaching existing entities (autocomplete "Add existing"). |
| `match_operator` | Autocomplete match operator for "Add existing" (`CONTAINS` / `STARTS_WITH`). |
| `collapsible` / `collapsed` | Render the inline form inside a details element, optionally collapsed. |
| `revision` | Create a new revision of the child entity on save. |
| `removed_reference` | On reference removal: `keep`, `optional`, or `delete` the entity (Complex). |
| `allow_duplicate` | Complex only — allow duplicating an existing row. |

Simple has the same keys minus `allow_duplicate`. Note `allow_existing`/`match_operator`
require the referenced entity type to have entities to reference.
