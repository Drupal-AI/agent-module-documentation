# The Usage report

There is **no settings page**. The module is zero-config; enabling it exposes the report.

## Where to find it
- On any Paragraphs type (admin/structure/paragraphs_type/{type}) an **Usage** operation/tab
  appears. It links to the route `entity.paragraphs_type.paragraphs_usage`, path
  `…/{paragraphs_type}/{entity_type_id}/usage` (built from the paragraphs_type canonical/edit
  link template + `/usage`).
- With `admin_toolbar_tools` enabled, a **Usage** link is also derived under each paragraph
  type in the admin toolbar (`ParagraphsUsageMenuLinks` deriver).

## Access control
- The route requires the core Paragraphs permission **`administer paragraphs types`**
  (set in `RouteSubscriber::alterRoutes`). No custom permission is added.

## What the report shows
A table with columns **Bundle**, **Machine name**, **Type**, **Field name**. Each row is a
place the paragraph type is referenced; the Bundle cell links to that host bundle's
*Manage fields* overview (`FieldUI::getOverviewRouteInfo`). If nothing references the type,
it prints "This paragraph is not used in any content type."

## How usage is detected
`ParagraphsUsageService` iterates every content-entity type + bundle and every field
definition, matching fields of type `entity_reference_revisions`:
- target-bundle list contains the paragraph type id → counted as a usage;
- `handler_settings.negate == 1` (exclude mode) with the type NOT in the exclude list, or an
  empty target list → also counted (the field can hold any/that bundle).
