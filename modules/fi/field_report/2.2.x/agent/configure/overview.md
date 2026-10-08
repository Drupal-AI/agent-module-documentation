# Field Report — the report page

There is nothing to configure. Enabling the module (it requires core `field_ui`) exposes one route;
visit it and read the tables.

## Route

- Name: `field_report.fields_report`
- Path: `/admin/reports/fields/field-report`
- Controller: `\Drupal\field_report\Controller\FieldReportController::getEntityBundles`
- Requirement: `_permission: administer field_report`
- `options._admin_route: TRUE` (renders in the admin theme)
- Also surfaced as a menu link and a local task under the Field storage collection
  (`entity.field_storage_config.collection`, i.e. `/admin/reports/fields`).

## What the report shows

`getEntityBundles()` walks every entity type definition from `entity_type.manager` and keeps only
those that declare a `bundle_entity_type` (node, media, taxonomy_term, block_content, comment,
contact_message, shortcut, plus any other bundleable entity, including contrib ones). For each:

1. Prints an `<h1>` group heading. A few entity types get friendlier headings; the rest use the
   entity type's own label:

   | Entity type id | Heading |
   | --- | --- |
   | node | Content Types |
   | media | Media |
   | comment | Comments |
   | contact_message | Contact Forms |
   | taxonomy_term | Taxonomy Terms |
   | block_content | Blocks |
   | shortcut | Shortcut Menus |
   | (any other) | entity type label |

2. For each bundle of that entity type: an `<h3>` bundle label, the bundle description, then a
   table (or the literal message "No Fields are avaliable." when the bundle has no configurable
   fields).

## Table columns

| Column | Source |
| --- | --- |
| Field Label | `FieldConfig::get('label')` |
| Field Type | `FieldConfig::get('field_type')` |
| Field Description | `FieldConfig::get('description')` |
| Also Used In | Other bundles sharing the same field storage, from `entity_field.manager->getFieldMap()`; each rendered as a link to that bundle's edit form (the current bundle is excluded). |
| Options | `Edit` / `Delete` links to the field's config edit/delete form — shown only when the current user passes `FieldConfig::access('update')` / `access('delete')` and the target entity type declares the matching field-edit/field-delete link template. |

## Which fields are listed, and their order

Only `FieldConfigInterface` instances are listed — configurable fields added through Field UI; base
fields are excluded. `entityTypeFields()` sorts them by their weight in the bundle's default
**entity form display** (`entity_display.repository->getFormDisplay()`), so the report mirrors the
field order editors see on the bundle's add/edit form.

## Styling

Tables use the `field_report/field-report` library (`css/field_report.admin.css`), with classes
`fieldReportTable`, `fieldReportTable--h1`, `fieldReportTable--h3`. The library is attached both by
the table render element and by `field_report_page_attachments()`. Note that hook's route-name
guard tests against `field_report.field_report_controller_getEntityBundles`, which is not the real
route name (`field_report.fields_report`), so the small CSS file is effectively attached on every
page rather than only on the report.
