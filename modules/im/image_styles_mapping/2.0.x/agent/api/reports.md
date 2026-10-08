<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reports & extension points

## Routes (all require permission `access_image_styles_mapping_report`)
| Route | Path | Report |
|---|---|---|
| `image_styles_mapping.report` | `/admin/reports/image_styles_mapping_report` | all available reports (tab: **All**) |
| `image_styles_mapping.report.fields` | `…/fields` | `fieldsReport` (tab: **Fields**) |
| `image_styles_mapping.report.views` | `…/views` | `viewsFieldsReport` (tab: **Views**); route also `_module_dependencies: views` |

Menu link lives under **Reports** (`system.admin_reports`).

## Service: `ImageStylesMappingService`
- **`fieldsReport()`** — `loadMultiple()` of `entity_view_display`; for each `content` field whose formatter `type` ∈ `{image, responsive_image}` emits a row (entity type, bundle machine name, bundle label, view mode link, field) + one column per active plugin.
- **`viewsFieldsReport()`** — `loadMultiple()` of `view`; for each display's `display_options.fields`, matches image fields via `getImageFields()` (regex allows reused handlers like `field_image_1`) and emits a row (view, view-display link, field) + plugin columns.
- View-mode / view-display cells are rendered as links only when `Url::access()` passes for the current user.

## Extending the report columns: the `ImageStylesMapping` plugin type
- **Manager:** `plugin.manager.image_styles_mapping.image_styles_mapping` (`ImageStylesMappingPluginManager`).
- **Attribute:** `Drupal\image_styles_mapping\Attribute\ImageStylesMapping`; base `ImageStylesMappingPluginBase`; interface `ImageStylesMappingPluginInterface`.
- **Discovery dir:** `src/Plugin/ImageStylesMapping/` — shipped plugins `Image` and `ResponsiveImageStyles`.
- Each active plugin contributes `getHeader()` and `getRowData($field_display_settings)` — implement a plugin to add a new "which style" column to both reports.
