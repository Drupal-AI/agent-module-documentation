# Configure & use "Modify field values"

VBE has no admin settings page. You add its action to a View and configure it per-run.

## Recommended path — with VBO

1. Create/edit a View (a **Table** display is the most convenient editor UX).
2. Add field → **Views bulk operations** (Global); place it first. (Requires the
   `views_bulk_operations` module.)
3. In the VBO field settings, tick the **Modify field values** action (plugin id
   `views_bulk_edit`).
4. **Preconfiguration** (fixed, set here by the site builder): **Get entity bundles from
   results** (`get_bundles_from_results`, default checked). Checked = query the actual
   selection/result rows for their bundles (accurate). Unchecked = derive bundles from a
   bundle filter on the view, or all bundles of the shown entity types — use this + a bundle
   filter (node type, vocabulary…) if you hit performance issues on large "all results" sets.
5. Run: select rows → choose **Modify field values** → the per-run **configure** step renders
   an edit form (see below) → confirm → VBO batches the edits.

## Core-only path — without VBO

VBE also ships a core Action, `entity:edit_action`, derived for every fieldable entity type
(`entity:edit_action:node`, `:user`, `:media`, `:taxonomy_term`). Config entities for those
four are provided in `config/optional/` (`system.action.<type>_edit_action.yml`). Selecting it
on a core "Bulk update"/Action bulk form stores the selection in the `entity_edit_multiple`
private tempstore and redirects to the confirm form at **`/admin/content/bulk-edit`**
(route `views_bulk_edit.edit_form`, permission `use views bulk edit`), which renders the same
edit form and saves on submit.

## The edit form (both paths)

Built by `BulkEditFormTrait`. One collapsible section per entity-type + bundle in the
selection. For each bundle it renders the **`bulk_edit`** entity form-mode display
(`EntityFormDisplay::collectRenderDisplay($entity, 'bulk_edit')`), so the fields you see are
whatever that form mode exposes (falls back to the default display if `bulk_edit` isn't
defined). Then it adds:

- **Select fields to change** (`_field_selector`) — a checkbox per field. Only checked fields
  are written; unchecked fields are left untouched (their inputs are hidden via `#states`).
  Fields whose widget is not `isDisplayConfigurable('form')` are removed.
- **Change method** per field (`<field>_change_method`), shown only when >1 option applies:
  | Method | When offered | Effect |
  |---|---|---|
  | `replace` | always | Overwrite the field's value |
  | `append` | `string`, `string_long`, `text`, `text_long` | Concatenate onto the existing text value |
  | `new` | field cardinality ≠ 1 (multi-value) | Merge the new value(s) in, de-duplicated |

  Default is the first applicable option.
- **Revision information** — for `RevisionLogInterface` entities whose revision key is
  update-accessible: a "Create new revision" checkbox (default from the bundle's
  `shouldCreateNewRevision()`) and a revision log message. If left blank, VBE writes an
  auto message listing the changed fields.

Edits are applied by `execute()` per entity: it reloads the active revision via
`entity.repository`, applies each selected field with its change method, optionally starts a
new revision, and saves.

## Config / export

Field & preconfiguration settings validate against `config/schema/views_bulk_edit.schema.yml`
(`views_bulk_operations.action_config.views_bulk_edit`), so a View using the VBO action
exports/deploys as normal config. `configure` route: none (`data.json` `configure` = null).
