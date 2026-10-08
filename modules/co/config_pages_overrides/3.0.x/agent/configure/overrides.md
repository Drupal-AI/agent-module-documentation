<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure config-page overrides

## Where
On a Config Pages **type**: `/admin/structure/config_pages/types/manage/{config_pages_type}/overrides` (add via `.../overrides-add`). Both routes require `config_pages_type.update` entity access. Mappings are stored in the type entity's `third_party_settings.config_pages_overrides`.

## Mapping fields (per override)
- `field` — the Config Page field to read.
- `column` — which field column supplies the value.
- `delta` — a single delta, or `CARDINALITY_UNLIMITED` (-1) to pull the whole multi-value array.
- `config_name` — target config object (e.g. `system.site`).
- `config_item` — dotted path within it (e.g. `name`, or `page.front`).
- `prefix` / `suffix` — optional wrap for string values.

## Runtime behaviour (`ConfigOverrides::loadOverrides`)
1. For each config page type with overrides, for each mapping whose `config_name` is being loaded:
2. Read the value from the live Config Page via `config_pages.loader` (`getValue`).
3. Apply prefix/suffix (strings), then `castOverrideValue()` to the target schema type (`boolean`→bool, `integer`→int).
4. `NestedArray::setValue($overrides, [config_name, ...config_item parts], $value)`.

## Verify
Edit the Config Page instance, then `drush config:get system.site name` (or your target) to confirm the override is applied. Overrides are dynamic — they are not written to config storage, only layered at read time.
