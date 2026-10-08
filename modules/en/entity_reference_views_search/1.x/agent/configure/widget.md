<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_reference_views_search — widget & AJAX

## Global settings
`/admin/config/entity-reference-views-search` (permission `administer site configuration`) → `entity_reference_views_search.settings:allowed_field_types` (comma list; default `string, email, entity_reference`). Only listed field types can use the widget.

## Widget
On a form-display, set a compatible field's widget to *Entity Reference Views Search*. Configure which View + display supplies the candidate rows. The widget embeds an `ervs-container` (data attributes carry the view id/display) with an `.ervs-input` (the stored ID), an `.ervs-results` region, and rows produced by the Views field plugin.

## Views field plugin
Add the `EntityFormViewsSearchSelectField` field to the picker View to render a per-row select control (`js/ervs.js` wires the click).

## AJAX flow — `/entity-reference-views-search/ajax`
Query params: `view_id`, `display_id`, `entity_id`, `entity_type`. The controller loads the entity, sets the input value via an `InvokeCommand`, and injects the entity rendered in `default` view mode via an `HtmlCommand`.

Caution: the controller performs **no** `->access('view')` check on the loaded entity and the route requires only `access content` — a crafted request can render entities the user may not be authorised to view. Keep sensitive entity types out of `allowed_field_types` and out of picker Views.
