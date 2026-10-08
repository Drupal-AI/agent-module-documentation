# SKOS Concept reference field

Attach this field to any content entity to reference SKOS concepts (like a taxonomy term
reference, but backed by the triple store).

## Field type
`skos_concept_entity_reference` (`SkosConceptEntityReferenceItem`, extends core
`EntityReferenceItem`). Hard-wired `target_type: skos_concept`; the storage-settings form is empty
(you never pick the target type). Item list class `SkosConceptReferenceFieldItemList` (adds a
`ValidReference` constraint and loads concepts in delta order).

Defaults: widget `skos_concept_entity_reference_autocomplete`, formatter
`skos_concept_entity_reference_label`, selection handler `default:skos_concept`.

## Widgets
| Widget id | Class | Notes |
|---|---|---|
| `skos_concept_entity_reference_autocomplete` | `SkosConceptEntityReferenceAutocompleteWidget` | thin subclass of core autocomplete |
| `skos_concept_entity_reference_options_select` | `SkosConceptEntityReferenceOptionsSelectWidget` | multi-value select; extra `sort` setting `id` \| `label` (label sort is transliterated in the current language) |

## Formatter
`skos_concept_entity_reference_label` (`SkosConceptEntityReferenceLabelFormatter`, extends core
`EntityReferenceLabelFormatter`) — renders concept labels; boolean `link` setting to link to the
concept. Labels render through core (escaped).

## Selection handler
`default:skos_concept` (`SkosConceptSelection`, extends core `DefaultSelection`,
`entity_types = {"skos_concept"}`). Settings (schema `entity_reference_selection.default:skos_concept`):

| Setting | Meaning |
|---|---|
| `concept_schemes` | Array of scheme IRIs to limit to (empty = all). Applied as an OR group on `in_scheme` / `top_concept_of`. |
| `concept_subset` | Id of a ConceptSubset plugin to further filter — see [../plugins/concept_subset.md](../plugins/concept_subset.md). |
| `field` | Field context (`field_name`/`entity_type`/`bundle`/`concept_schemes`) stored so subset plugins can key off the field. |

Sorting and auto-create are disabled in the field settings UI. Reference queries built for a field
are tagged `skos_concept_field_selection_plugin` with the field info as metadata.

## Setup
Create via the field UI (Manage fields → "SKOS Concept Reference") or standard field config. The
field type takes no storage settings; the instance's `handler` is forced to `default:skos_concept`,
and you choose the allowed concept schemes / subset in the field settings.
