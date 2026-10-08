<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoints, access model, settings.php & cron

## No admin config, no permissions

The module has **no settings route** (`configure` = null) and **no `*.permissions.yml`**. Every
option is per-field on Manage form/display. It ships config **schema** only (for the widget/
formatter settings; `config/schema/better_entity_reference.schema.yml`).

## Routes (`better_entity_reference.routing.yml`) and their access

All under `/better-entity-reference/*`; each requires a `_custom_access` callback on
`src/Access/FieldWidgetAccess.php`, then the controller enforces its own CSRF + HMAC.

| Route | Method | Controller | Access callback | Controller-layer check |
|---|---|---|---|---|
| `.browse` | GET | `BrowseController::browse` | `::browse` (target is a real taxonomy type) | CSRF token bound to bundles+root; per-term `access('view')` |
| `.search` | GET | `SearchController::search` | `::search` (target is a content entity type) | CSRF token + hash-bound selection-settings key; selection handler filters |
| `.quick_create` | POST | `QuickCreateController::createEntity` | `::createEntity` (may create the bundle) | type/bundle CSRF token, `createAccess`, flood control, entity validation |
| `.upload` | POST | `UploadController::receive` | `::editableField` | CSRF + field-bound HMAC; field's own validators |
| `.media_upload` | POST | `MediaUploadController::receive` | `::editableField` | CSRF + HMAC; media `createAccess`; source-field validators |
| `.media_remote` | POST | `MediaUploadController::remote` | `::editableField` | CSRF + HMAC; oEmbed source URL validation |
| `.media_browse` | GET | `MediaBrowseController::browse` | `::editableField` | CSRF + HMAC; media view access |
| `.media_form` | GET | `MediaFormController::pane` | `::editableField` | CSRF + HMAC |
| `.file_browse` | GET | `FileBrowseController::browse` | `::editableField` | CSRF + HMAC (signed `mine` claim); per-file `access('view')` |

### Access model (`FieldWidgetAccess` + `SignedRequests`)

`editableField()` is layer 1: it rebuilds a self-representative field stub from the signed
`entity_type`/`bundle`/`field_name`, honors an explicit field lock, and grants when the user can
create the bundle or update an entity of that type (owner-based, user, or admin-permission types
judged directly; fully contextual types like paragraphs are deferred to the HMAC + controller).
`SignedRequests::sign()`/`validate()` is layer 2: a session CSRF token plus a length-prefixed
`Crypt::hmacBase64(...)` over the field context and any extra claims, compared with `hash_equals`,
keyed by `Settings::getHashSalt() . $purpose`. Reference/search/browse pickers stay usable by
anonymous widgets (like core autocomplete) and rely on per-result `access('view')` filtering
rather than a route-level view gate.

## settings.php — staging directory (`src/StagingDirectory.php`)

Chunked uploads are staged in a directory on the destination field's own scheme, then moved into
place. Default name `better_entity_reference_tmp`; override for all fields at once:

```php
$settings['better_entity_reference_staging_directory'] = 'my_uploads_tmp';
```

Nested paths (`uploads/tmp`) are allowed; an empty value, an absolute path, a `.`/`..` segment, a
backslash or a `:` is rejected in favor of the default (`StagingDirectory::name()`), so a typo or
traversal attempt can't redirect uploads. It is intentionally settings.php-only, not a form
setting.

## Cron (`src/Hook/Hooks.php`, `hook_cron`)

`Hooks::cron()` sweeps abandoned per-upload staging directories (only a closed tab leaves one;
finalize/error paths clean up their own) older than **6 hours** (`getRequestTime() - 21600`) across
the `temporary`, `public` and `private` schemes. Changing the staging directory name migrates
nothing — cron only sweeps the currently configured one, so delete leftovers under the old name
yourself.

## Services (`better_entity_reference.services.yml`, all autowired)

`ColorGenerator` (+ `ColorGeneratorInterface`), `OptionMetadata`, `MediaItemBuilder`,
`FileUsageTotals`, `Hook\Hooks`.
