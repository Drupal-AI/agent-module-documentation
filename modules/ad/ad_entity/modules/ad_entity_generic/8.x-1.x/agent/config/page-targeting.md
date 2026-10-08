<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global page targeting (JavaScript variable)

The generic type can publish all applicable page targeting as a single global JavaScript variable,
so a tag manager or ad script (e.g. `dataLayer` for Google Tag Manager) can read it.

## Configure

Global settings live on config object **`ad_entity.settings`** under the `generic` key, edited from
the Advertising global settings form (`admin/structure/ad_entity/global-settings`). The fields come
from `GenericType::globalSettingsForm()`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `generic.page_targeting.enabled` | boolean | off | Publish page targeting as a global JS variable. |
| `generic.page_targeting.js_variable` | string | `dataLayer` | Name of the global variable (treated as an array). |

`globalSettingsSubmit()` only persists these when `enabled` is checked, and **sanitizes** the
variable name with `preg_replace('/[^a-zA-Z0-9\_]+/', '', $value)` — so it can only ever be a bare
identifier. Schema for `generic.page_targeting` is registered via
`hook_config_schema_info_alter()` in `ad_entity_generic.module`.

## What gets emitted

`ad_entity_generic_page_attachments()` (skipped on admin routes) builds an inline
`<script id="page-targeting">` in the html head only when `page_targeting.enabled` and a
`js_variable` are set. It:

1. Emits `window.<var> = window.<var> || [];`.
2. Collects targeting from the `AdContextManager` (`ad_entity.context_manager`)
   `getContextDataForPlugin('targeting')` where `apply_on` is empty, into a
   `Drupal\ad_entity\TargetingCollection`; if non-empty it `filter()`s and pushes
   `<var>.push(<targeting-json>);`.
3. Checks the `turnoff` context plugin: pushes `{show_ads:true}` normally, or `{show_ads:false}` if
   any active `turnoff` context applies.

The script string is wrapped in `Drupal\ad_entity\Render\Markup::create()` (an internal
known-safe-string wrapper). The targeting JSON comes from `TargetingCollection::toJson()`, which
uses `json_encode(..., JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_UNESCAPED_UNICODE)` — so
`<`, `>`, `'`, `"` are hex-escaped and cannot break out of the inline `<script>`. The targeting
values themselves are admin-configured (per-slot on the entity form, or via Advertising context),
not request/remote input.

## Relationship to per-slot targeting

Per-slot default targeting (the `targeting` field on a generic Advertising entity, see
[../plugins/generic.md](../plugins/generic.md)) is delivered to the JS view as the container's
`data-ad-entity-targeting` and merged into each `ad_tag.targeting`. The global page-targeting
variable here is a separate, page-wide feed intended for external tag managers.
