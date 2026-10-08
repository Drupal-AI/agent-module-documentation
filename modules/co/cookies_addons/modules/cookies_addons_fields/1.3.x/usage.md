<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons Fields withholds an individual entity field until the visitor consents to a configured COOKiES service, chosen per field in its formatter settings on Manage display, then AJAX-loads the field on consent.

---

A submodule of Cookies Addons. `cookies_addons_fields_field_formatter_third_party_settings_form()` adds a "Cookies service" select (options = enabled `cookies_service` entities plus `_none`) to every field formatter's third-party settings, stored as `field.formatter.third_party.cookies_addons_fields:cookies_service`. `cookies_addons_fields_preprocess_field()` reads that setting; when a service is chosen it empties each field item's content and turns the field wrapper into a `cookies-addons-fields-placeholder` `<div>` carrying `data-cookies-service`, `data-field-id` (`{entity_type}-{entity_id}-{field_name}`), `data-view-mode` and `data-service-name`, attaching the `cookies_addons_fields/cookies-addons-fields` JS library. On consent the behavior POSTs `/cookies-addons-fields/get-field/{field_id}/{service}/{view_mode}`; `CookiesAddonsFieldsController::getField()` validates the id format, loads the entity, checks `view` access on both the entity and the field, validates the view mode against the entity type's view-mode options, renders just that field with `viewField()`, adds cacheability metadata, and AJAX-replaces the placeholder. There is no settings form — configuration is entirely per-formatter.

---

- Gate a single field (map field, external embed, tracking widget) behind consent without gating the whole entity.
- Turn on gating per field by picking a Cookies service in that field's formatter settings on Manage display.
- Apply gating to any entity type/bundle/view mode that has field displays.
- Show a consent placeholder in place of the field until the matching service is accepted.
- AJAX-load only the field content once the service is consented to.
- See the chosen Cookies service summarized in the formatter settings summary on Manage display.
- Reuse any enabled COOKiES `cookies_service` as the gate for a field.
- Rely on server-side entity + field `view` access checks when the field is loaded on consent.
- Restrict the loadable view modes to those actually defined for the entity type.
- Keep a personal-data-processing field off the initial render for GDPR/ePrivacy compliance.
- Combine field-level gating with block/paragraph/view gating from the other submodules.
- Clear `_none`/unset formatters so ungated fields render normally.
