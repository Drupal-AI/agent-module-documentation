<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring source fields

## Admin settings
- Route: `ckeditor_entity_link_by_field.config_form` → `/admin/config/content/ckeditor_entity_link_by_field`
- Permission: `administer ckeditor_entity_link_by_field`
- Stores config `ckeditor_entity_link_by_field.settings` with a `sources` array; each entry has `entity_type` and `field`.

## How autocomplete resolves the field
`EntityLinkByFieldAutoCompleteController::handleAutocomplete()`:
1. Reads `sources`; picks the first entry whose `entity_type === 'node'` and uses its `field` as `$fieldname`.
2. `Xss::filter()`s the `q` query param.
3. Runs `nodeStorage->getQuery()->condition('type','article')->condition($fieldname,$input,'CONTAINS')->range(0,10)`.
4. Returns JSON `{value,label}`, labelling unpublished nodes with 🚫.

## Security hardening (agent note — do not "fix" silently)
- The query omits `->accessCheck(TRUE)` and does not filter `status`, so unpublished article field values and nids are returned to anyone with `access content` (anonymous by default). The route `ckeditor_entity_link_by_field.autocomplete` is defined with `_permission: 'access content'` in `ckeditor_entity_link_by_field.routing.yml:21`.
- If unpublished content is sensitive, tighten the route permission (e.g. a dedicated permission) and add an access check to the entity query.

## Dialog
- `.dialog` route is gated by `_entity_access: filter_format.use`, so only users allowed to use the text format can open it — this surface is appropriately protected.
