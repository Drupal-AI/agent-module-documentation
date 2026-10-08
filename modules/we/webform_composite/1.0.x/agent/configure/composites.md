# Manage reusable composites

A composite is a `webform_composite` **config entity** (`src/Entity/WebformComposite.php`).
`config_export` keys: `id`, `label`, `elements` (YAML string of sub-elements), `description`.
All routes require the core `administer webform` permission (`admin_permission` on the entity,
`_permission: 'administer webform'` in `webform_composite.routing.yml`).

## Routes / UI
Base path `/admin/structure/webform/config/composite` (route `entity.webform_composite.list`,
also the module's `configure` link, shown as a "Composites" tab under Webform config).

| Action | Route | Path | Form handler |
|--------|-------|------|--------------|
| List   | `entity.webform_composite.list` | `.../composite` | `WebformCompositeListBuilder` |
| Add    | `entity.webform_composite.add_form` | `.../composite/add` | `WebformCompositeForm` |
| Edit   | `entity.webform_composite.edit_form` | `.../composite/{webform_composite}` | `WebformCompositeForm` |
| Source | `entity.webform_composite.source_form` | `.../composite/{webform_composite}/source` | `WebformCompositeSourceForm` |
| Delete | `entity.webform_composite.delete_form` | `.../composite/{webform_composite}/delete` | `WebformCompositeDeleteForm` |

The list builder shows Label / Machine Name / Description and adds a **Source** row operation.

## Edit form (builder UI) — `WebformCompositeForm`
Fields: `label` (required), `id` (machine name), `description` (`webform_html_editor`), and
`elements` — a `webform_element_composite` builder (Webform's UI for defining sub-elements).
On save, each row is re-keyed and prefixed with `#` via `WebformArrayHelper::addPrefix()` and
stored as YAML in `elements`. Validation rejects duplicate sub-element keys and requires
`#options` on any sub-element whose plugin `hasProperty('options')`. Redirects to the list.

## Source form (raw YAML) — `WebformCompositeSourceForm`
A single `webform_codemirror` (mode `yaml`) field editing `elements` verbatim (from
`getElementsRaw()`). Its `validateForm()` is a no-op — the raw YAML is saved as-is, so malformed
YAML is possible here. Use for bulk/precise edits; the builder UI is safer for normal use.

## How elements are read back
`getElementsDecoded()` (`WebformCompositeInterface`) YAML-decodes `elements`, returns `[]` for
non-array/invalid YAML, and **strips any `#states`** from each sub-element ("causes unexpected
behavior"). This decoded array is what the element plugin renders — see
[../plugins/webform-composite-element.md](../plugins/webform-composite-element.md).

## Cache
`WebformComposite::postSave()` calls
`plugin.manager.webform.element->clearCachedDefinitions()` so a new/edited composite immediately
appears as a placeable element derivative.

Config schema: `config/schema/webform_composite.yml` (id, uuid, status, label, elements, description, langcode).
