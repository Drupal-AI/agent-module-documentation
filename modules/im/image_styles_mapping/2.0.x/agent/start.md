<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Styles Mapping (image_styles_mapping) — agent index

**Read-only admin report of where image styles / responsive image styles are used, across view-display fields and Views field handlers.**

- **Version:** 2.0.x
- **Core:** ^11.3 || ^12
- **Depends on:** field_ui (views tab additionally requires the `views` module)
- **Routes:** `image_styles_mapping.report` (`/admin/reports/image_styles_mapping_report`), `.report.fields`, `.report.views` — all local tasks.
- **Permission:** `access_image_styles_mapping_report` (single gate on all routes).
- **Service:** `ImageStylesMappingService` — `fieldsReport()` scans `entity_view_display` for image/responsive_image formatters; `viewsFieldsReport()` scans View displays.
- **Plugin type:** `ImageStylesMapping` (manager `plugin.manager.image_styles_mapping.image_styles_mapping`; plugins `Image`, `ResponsiveImageStyles`) — extensible report columns.

**Security:** admin report route, permission-gated; read-only, no writes, no user-supplied SQL (TableSort `sql` key is used only for in-PHP sorting); dynamic report dispatch is whitelisted to hardcoded route defaults.

See [api/reports.md](api/reports.md)
