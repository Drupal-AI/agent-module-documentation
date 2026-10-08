<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ecoindex` field type, widget, formatters & validation

## Field type `ecoindex` — `src/Plugin/Field/FieldType/EcoIndexItem.php`
`@FieldType(id="ecoindex", default_widget="ecoindex_widget",
default_formatter="ecoindex_score_formatter", constraints={"EcoIndexField"={}})`, extends
`FieldItemBase`. Properties / columns (`propertyDefinitions()` + `schema()`):

| property | type | DB column |
|---|---|---|
| `score` | integer | int `tiny` |
| `grade` | string | varchar(1) |
| `element_count` | integer | int `normal` |
| `request_count` | integer | int `normal` |
| `total_size_kb` | float | float |

`mainPropertyName()` = `score`. Attach it to a content type via *Manage fields* (choose the
**EcoIndex** field type). `hook_field_type_category_info_alter()` in `ecoindex.module` puts the
field in the core fallback ("General") category and attaches the `ecoindex/ecoindex.icon` library
(icon CSS on the field-type selection screen).

### Install update `ecoindex_update_8001()` (`ecoindex.install`)
Retrofits existing `ecoindex` field storages: adds the `element_count`, `request_count` and
`total_size_kb` columns (and the revision-table equivalents when the entity is revisionable) to the
`{entity_type}__{field}` / `{entity_type}_revision__{field}` tables via the DB schema API, guarded
by `fieldExists()`. Run `drush updatedb` after upgrading from an early version that only stored
score + grade.

## Widget `ecoindex_widget` — `src/Plugin/Field/FieldWidget/EcoIndexWidget.php`
`ContainerFactoryPluginInterface`; injects `request_stack` and `current_route_match`.
`formElement()` renders a collapsed `details` group with number inputs for `element_count`,
`request_count`, `total_size_kb` (step 0.01) and `score` (0–100), plus a `grade` select
(''/A–G). When the route has a `node`, the `grade` element gets a description link "Refresh
EcoIndex score" pointing at `Url::fromRoute('ecoindex.preview', ['node' => nid])` (opens in a new
tab). The measurement/round-trip is described in [../workflow/preview.md](../workflow/preview.md).

## Formatters — `src/Plugin/Field/FieldFormatter/`
- `ecoindex_score_formatter` (`EcoIndexScoreFormatter`, the default): renders `#plain_text =>
  $item->score` with the entity's cache tags.
- `ecoindex_grade_formatter` (`EcoIndexGradeFormatter`): renders `#plain_text => $item->grade`.
Both extend `FormatterBase`, target `field_types = {"ecoindex"}`, and use `#plain_text` (output is
escaped). Choose either per view-display on *Manage display*.

## Validation constraint `EcoIndexField`
- Constraint `src/Plugin/Validation/Constraint/EcoIndexFieldConstraint.php` (`@Constraint id=
  "EcoIndexField"`), message `needsValue = 'Minimum EcoIndex %value it required to published.'`.
- Validator `EcoIndexFieldConstraintValidator` (`ContainerInjectionInterface`; injects
  `config.factory` + current request). Logic in `validate()`:
  - Returns early unless the root entity implements `EntityPublishedInterface`.
  - Returns early if the entity is new (`!id()`), if `ecoindex.settings.required_to_publish` is
    off, or if the request `op` is `Preview`.
  - If the entity `isPublished()` and the item `score` is `> 0` and `minimum_score > score`, adds a
    violation with `%value = minimum_score` — this blocks the save/publish.
- Net effect: a low but non-zero EcoIndex score prevents publishing when *Is required to publish*
  is enabled. A score of 0 (unmeasured) is not blocked.
