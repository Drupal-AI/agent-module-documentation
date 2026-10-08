<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — the expirable_content_type bundle

## Install / enable

Standard contrib install. No global settings form and no `configure` route; configuration is done entirely by
creating `expirable_content_type` config entities (bundles of the internal `expirable_content` entity). There is
no `composer.json`, so install via `drupal/expirable_content` from the drupal.org package or drop-in.

## Admin UI & routes

Routes come from the config entity's `AdminHtmlRouteProvider` (`ExpirableContentType`, `Entity/ExpirableContentType.php`):

- `entity.expirable_content_type.collection` — `/admin/structure/expirable_content_types` (list; also menu link
  under Structure and a "List" local task).
- `entity.expirable_content_type.add_form` — `/admin/structure/expirable_content_types/add` (action link).
- `entity.expirable_content_type.edit_form` — `/admin/structure/expirable_content_types/manage/{id}`.
- `entity.expirable_content_type.delete_form` — `.../manage/{id}/delete` (core `EntityDeleteForm`).

All are gated by the config entity `admin_permission` **`administer expirable_content types`** (defined in
`expirable_content.permissions.yml`, `restrict access: true`). Forms are core Form-API (CSRF-protected POST).

## The add/edit form (`Form/ExpirableContentTypeForm`)

`BundleEntityFormBase` subclass with chained AJAX selects:

1. **Enabled** (`status`) — checkbox; controls whether the bundle is treated as expirable.
2. **Entity type** (`entity_type`) — every content entity type (`entityClassImplements(ContentEntityInterface)`);
   disabled after creation.
3. **Entity bundle** (`entity_bundle`) — bundles of the chosen type; disabled after creation.
4. **Last updated field** (`field`) — only fields of type `timestamp`, `changed`, or `created` on that bundle
   (`getDateFieldsForBundle()`); this is the base date for the countdown.
5. **Days before expiration** (`days`) and **Days to notify before expiration** (`warn`) — textfields, required.

`submitForm()` sets the entity id to `"{entity_type}.{entity_bundle}"`; `save()` redirects to the collection with
a status message.

## Config object & schema

Config entity id pattern `expirable_content.type.<entity_type>.<bundle>`; `config_prefix = "type"`.
`config_export` / schema (`config/schema/expirable_content.expirable_content_type.schema.yml`) keys:

| Key | Type | Meaning |
|-----|------|---------|
| `id` | string | `<entity_type>.<bundle>` |
| `status` | boolean | Bundle expiration enabled |
| `field` | string | Base date field machine name (timestamp/created/changed) |
| `days` | integer | Days after the base date until expiration |
| `warn` | integer | Days before expiration for the warning date |
| `entity_type` | string | Target entity type id |
| `entity_bundle` | string | Target bundle |

`ExpirableContentType` exposes getters `field()`, `days()`, `warn()`, `entityType()`, `entityBundle()`.

Adding/enabling a type triggers `hook_entity_base_field_info()` to attach the computed fields to that entity type
and adds the Views handlers; disabling (`status = FALSE`) makes `isExpirableEntity*()` return FALSE so nothing is
computed or tracked for that bundle.
