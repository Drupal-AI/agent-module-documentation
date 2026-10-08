# Management, inspection, batch, config import/export, integrity

Three admin pages, all requiring `administer external entity types`.

## Management form — `xnttmanager.management`

`Drupal\xnttmanager\Form\ManagementForm` (`src/Form/ManagementForm.php`, form id
`xnttmanager_management_form`), path `/admin/structure/external-entity-types/manage`. A `<select>` of
external entity types (only fully-required-mapped ones, via
`xnttmanager_get_external_entity_type_list()`) plus three fieldsets, each with its own submit
handler:

- **Mapping inspection** — optional `xntt_id` textfield + *Inspect* button (`submitInspectForm`)
  redirects to `xnttmanager.inspect` (below).
- **Batch processing** — *Batch process* button (`submitBatchForm`) runs Batch API op
  `xnttmanager_bulk_process` to load every entity of the type (a health check). Checkboxes:
  - `xntt_save` — also `->save()` each loaded entity (useful for mass conversion with `xnttmulti`).
  - `xntt_annotate` — create a missing annotation content for each entity (validated: the type must
    be annotatable). See [../api/internals.md](../api/internals.md) for the batch loop.
- **Config (experimental)** — export or import a type's config as YAML.

### Config export — `submitExportForm()`

Collects the raw config `external_entities.external_entity_type.<id>` plus its default
`core.entity_form_display.*` / `core.entity_view_display.*` and transitively-resolved config
dependencies, packs them into a `{id, date, xntt:{definition,form_display,view_display}, configs,
dependencies}` structure, YAML-encodes it and streams it as an attachment
`xnttmanager.<type>.config.yml` (`Response` + `Content-Disposition`).

### Config import — `validateImportForm()` + `submitImportForm()`

`file` upload `xntt_config_file` with an **extension allowlist `yml yaml json`** (both on the element
`#upload_validators` and again in `file_save_upload`). Validation decodes the YAML, requires keys
`id, date, xntt, configs, dependencies`, refuses if the target type id **already exists**, checks all
dependency modules are enabled, rejects unsupported dependency types (only `config`/`module`) and
unknown non-field configs. On submit it **creates** the `external_entity_type`, its field storages +
field configs (matched by regex on the config ids), and the default form/view displays. This is an
admin config operation — treat it like importing site config.

## Field inspector — `xnttmanager.inspect`

`Controller\XnttInspector::inspect($xntt_type, $xntt_id = '')`
(`src/Controller/XnttInspector.php`), path `…/inspect/{xntt_type}/{xntt_id}`. Read-only. `$xntt_type`
is validated against `^[\w\-]+$` and must be an existing, *configurable* external entity type
(else 404 / "unsupported"). Loads one raw record (the given id, else the first) via the type's data
aggregator and renders a table mapping each Drupal field/property → raw source field name → source
data → example value, with a *"No corresponding raw field"* flag for unmapped ones, plus a collapsed
`var_export()` of the raw record. `renderValue()` collapses long (>80 char) or binary values into
`<details>` and marks binary blobs as `(binary data)`. Attaches the `xnttmanager/xnttmanager` CSS.

## Integrity form — `xnttmanager.integrity`

`Drupal\xnttmanager\Form\IntegrityForm` (`src/Form/IntegrityForm.php`, form id
`xnttmanager_field_integrity_form`), path `…/integrity`. Scans every external entity type's field
definitions for two problems: field configs **missing** entirely, and field configs whose
**dependencies** don't reference `external_entities` / the owning
`external_entities.external_entity_type.<id>`. Lists offenders; the *Fix fields* submit re-saves the
recomputable ones (which recomputes dependencies). Missing base/field configs are logged as
"not implemented" and counted as failures.
