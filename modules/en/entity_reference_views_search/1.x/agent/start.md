<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Views Search (entity_reference_views_search) — agent index

**A field widget that turns a View into an entity-reference picker, with an AJAX entity preview.**

- **Version:** 1.x  •  **Core:** ^9 || ^10 || ^11  •  **Requires:** field, views  •  **Configure:** `entity_reference_views_search.settings` (`/admin/config/entity-reference-views-search`)
- **Plugins:** FieldWidget `EntityReferenceViewsFormSearch`; Views field `EntityFormViewsSearchSelectField`; JS `js/ervs.js`.
- **Routes:** `entity_reference_views_search.settings` (`administer site configuration`); `entity_reference_views_search.ajax` → `/entity-reference-views-search/ajax` (`access content`).
- **Config:** `allowed_field_types` (default `string, email, entity_reference`).
- **Security — note:** the AJAX endpoint (`Controller/EntityFormViewsSearchAjaxController::ajaxView`, `:82-100`) loads an arbitrary `entity_type`/`entity_id` from the query string and renders its `default` view mode **without an entity `->access('view')` check**, gated only by `access content` (routing.yml). This can disclose renderable entities a user would not normally see. Restrict the widget to non-sensitive entity types.

See [configure/widget.md](configure/widget.md)
