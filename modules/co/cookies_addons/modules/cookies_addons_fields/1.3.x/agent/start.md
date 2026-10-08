<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Fields (cookies_addons_fields) — agent index

Submodule of **Cookies Addons**. Gates an **individual entity field** behind a COOKiES consent
service via a per-formatter third-party setting. Package COOKiES. Core `^9 || ^10 || ^11`. Depends on
`cookies:cookies` and `cookies_addons:cookies_addons`. License GPL-2.0-or-later. Version 1.3.3.

- **Configuration (per-formatter), route and mechanism** → [fields/gating.md](fields/gating.md)

## What it provides

- `cookies_addons_fields_field_formatter_third_party_settings_form()` — adds a "Cookies service"
  `select` (options: enabled `cookies_service` labels + `_none`) to every field formatter's
  third-party settings.
- `cookies_addons_fields_field_formatter_settings_summary_alter()` — appends "Cookies service: …" to
  the formatter summary when set.
- `cookies_addons_fields_preprocess_field()` — for a field whose third-party
  `cookies_addons_fields:cookies_service` is set (and not `_none`, non-POST), empties each item's
  content and marks the wrapper as a `cookies-addons-fields-placeholder` with `data-cookies-service`,
  `data-field-id` (`{entity_type}-{entity_id}-{field_name}`), `data-view-mode`, `data-service-name`;
  attaches the JS library.
- Controller `CookiesAddonsFieldsController::getField($field_id, $service, $view_mode)`
  (`src/Controller/CookiesAddonsFieldsController.php`) — injects `entity_type.manager`,
  `entity_display.repository`, `renderer`. Parses/validates `field_id`, loads the entity, checks
  entity `view` access and field `view` access (throws `AccessDenied`/`NotFound`), validates the view
  mode, renders the field with `viewField()`, adds cacheable dependencies, returns an `AjaxResponse`
  `ReplaceCommand`.
- Route `cookies_addons_fields.get_field` (POST, `access content`) with `field_id`/`service`/
  `view_mode` regex requirements. Config schema
  `field.formatter.third_party.cookies_addons_fields` (`cookies_service: string`). Library
  `cookies_addons_fields/cookies-addons-fields`.
- **No settings form**, no permissions file, no services, no plugins, no Drush.

Privacy/consent gate, not access control (though the render route does re-check entity/field access).
