<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST resources, the manager service, and file handling

## Service: `castorcito.manager` (`src/CastorcitoManager.php`)

Central helper used by the widget, formatter and REST resources. Constructor args:
`entity_field.manager`, `entity_type.manager`, `plugin.manager.block`, `file_url_generator`,
`user.permissions`, `current_user`, `database`, `plugin.manager.castorcito_component_field`.
Key methods:

- `castorcitoComponents($ids=NULL)` / `castorcitoComponent($id)` / `castorcitoComponentsOptions()`
  — load component config entities (options exclude `inside_container` ones).
- `getCastorcitoComponents(array $ids)` — assemble component models + per-field settings for
  drupalSettings, recursing into container children. `processCfieldsSettings()` injects the
  entity-autocomplete URL for `link`/`entity_reference`/`webform` cfields.
- `getBlockDefinitions()` — all block plugin definitions (used by the block-list REST resource).
- `entityAutocompleteUrl(...)` — builds a core `system.entity_autocomplete` URL with an HMAC key.
- `generalUrls()` — public/private file bases, CSRF token URL, and the two REST endpoint URLs.
- `getUserPermissions()` — current user's castorcito permissions (for the JS copy/paste buttons).
- `componentUsage($id)` — parameterised `LIKE` scan of `json_field` field tables to see if a
  component id appears in stored content (used to block deletion of in-use components).

## REST resource: image upload

- `castorcito_ajax_upload_image_resource` (`src/Plugin/rest/resource/CastorcitoAjaxUploadImageResource.php`).
  POST `/api/castorcito-ajax-upload-image`, cookie auth, JSON
  (`config/install/rest.resource.castorcito_ajax_upload_image_resource.yml`). Access is gated by
  the per-resource REST permission `restful post castorcito_ajax_upload_image_resource`.
- `post()`: base64-decodes `image`; if it is an SVG it is sanitised with
  `enshrined\svgSanitize\Sanitizer` (remote references removed); intersects requested extensions
  with the toolkit-supported set (+ `svg`); saves the data; validates via `file.validator`
  (name length, size limit, extension; plus dimensions/`is image` for raster); creates the `File`
  entity and returns fid/name/size/uri/thumbnail/width/height. SVG dimensions are read from the
  sanitised file's XML (`getSvgDimensions()`).

## REST resource: block list

- `castorcito_block_list_resource` (`src/Plugin/rest/resource/CastorcitoBlockListResource.php`).
  GET `/api/castorcito-block-list`, cookie auth, gated by `restful get
  castorcito_block_list_resource`. Requires a JSON `provider` query param (array of provider
  machine names); returns the matching blocks' admin labels (from
  `CastorcitoManager::getBlockDefinitions()`), tagged with `block_content_list` cache tag.

## File handling & access

- `CastorcitoFileProcessor` (`src/CastorcitoFileProcessor.php`, a `TrustedCallbackInterface`
  submit handler): on entity save it walks the submitted JSON of every `json`/`json_native`/
  `json_native_binary` field, finds files referenced by `image` cfields (`fid`) and
  `formatted_text` cfields (files with `data-entity-uuid` in the HTML), marks them permanent and
  records `file.usage` under module `castorcito`. `hook_entity_delete` +
  `cleanEntityUsage()` release usage when the host entity is deleted.
- `castorcito_entity_access()` / `castorcito_file_download()` (in `castorcito.module`): for
  **private** files whose usage is owned by `castorcito`, view access is granted only if the
  current user can view the parent entity (temporary files are limited to their owner). This ties
  component file visibility to the host content's access.

## Hooks summary (`castorcito.module`)

`hook_help` (predefined-options docs), `hook_theme` (`castorcito_view_json`,
`castorcito_form_widget`), `hook_form_alter` (widget app injection), `hook_form_FORM_ID_alter`
for the component delete form (blocks deletion when in use), `hook_entity_delete`,
`hook_entity_access`, `hook_file_download`, `hook_preprocess_field`, `hook_preprocess_html`
(loads `castorcito.admin` for toolbar users).
