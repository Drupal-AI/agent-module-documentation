<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Fields — per-field consent gating

## Enable

`drush en cookies_addons_fields`. Requires COOKiES (`cookies`) and Cookies Addons
(`cookies_addons`), plus at least one enabled `cookies_service` entity.

## Configure (per field formatter — no settings form)

On any entity type's **Manage display**, open a field's formatter settings (gear icon). The module
adds:

- **Cookies service** (`#type select`) — options are the labels of enabled `cookies_service`
  entities plus `_none` ("None"). Stored as the formatter third-party setting
  `field.formatter.third_party.cookies_addons_fields:cookies_service` (schema type `string`). The
  description links to the COOKiES services collection (`entity.cookies_service.collection`).

The formatter settings summary shows `Cookies service: <id>` when a value is set
(`cookies_addons_fields_field_formatter_settings_summary_alter()`).

## Runtime mechanism

1. `cookies_addons_fields_preprocess_field(&$variables)` reads
   `$variables['element']['#third_party_settings']['cookies_addons_fields']['cookies_service']`.
   Returns early if empty/`_none` or on a POST request. It resolves the service label (falls back to
   the machine name), empties every `$variables['items'][*]['content']`, and sets wrapper attributes:
   class `cookies-addons-fields-placeholder`, `data-cookies-service`, `data-service-name`,
   `data-field-id` = `{entityTypeId}-{entityId}-{field_name}`, `data-view-mode`, `id={field_id}-content`;
   attaches library `cookies_addons_fields/cookies-addons-fields`.
2. `js/cookies-addons-fields.js` (`Drupal.behaviors.cookiesAddonsFields`) — on `cookiesjsrUserConsent`
   accept, `activate()` POSTs `/cookies-addons-fields/get-field/{fieldId}/{service}/{viewMode}`; on
   deny, `fallback()` calls `cookiesOverlay(service)`.
3. `CookiesAddonsFieldsController::getField($field_id, $service, $view_mode)`:
   - `preg_match('/^([a-z_]+)-([0-9]+)-([a-z0-9_]+)$/', $field_id)` → NotFound on mismatch; extracts
     entity type, id, field name.
   - Loads the entity; NotFound unless a `ContentEntityInterface`.
   - `$entity->access('view', $account, TRUE)` → AccessDenied if not allowed.
   - `$entity->hasField($field_name)` → NotFound if absent.
   - `$field->access('view', $account, TRUE)` → AccessDenied if not allowed.
   - Validates `$view_mode` against `displayRepo->getViewModeOptions($entity_type)` → NotFound if not
     an allowed mode.
   - Renders with `getViewBuilder($entity_type)->viewField($field, $view_mode)`, adds cacheable
     dependencies (entity access, field access, entity) "so access decisions don't leak", and returns
     an `AjaxResponse` `ReplaceCommand` on
     `.cookies-addons-fields-placeholder[data-cookies-service][data-field-id]`.

## Route

`cookies_addons_fields.get_field` — path
`/cookies-addons-fields/get-field/{field_id}/{service}/{view_mode}`, `methods: [POST]`, permission
`access content`, with route requirements enforcing the id/service/view_mode patterns. Access is
further constrained inside the controller by the entity + field `view` access checks above.
