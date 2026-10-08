<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revive Adserver Zone field (type + widget + formatter)

All three plugins share the id **`revive_adserver_zone`**. Attach the field to any fieldable
entity to render a Revive zone on that entity.

## Field type — `ReviveItem` (`src/Plugin/Field/FieldType/ReviveItem.php`)

`@FieldType(id = "revive_adserver_zone", default_widget = "revive_adserver_zone",
default_formatter = "revive_adserver_zone")`. Properties / columns:

- `zone_id` — `integer` property, DB column **`int`** (default NULL).
- `invocation_method` — `string` property, `varchar(255)` (default NULL).

`isEmpty()` = both empty. `defaultFieldSettings()` = `['invocation_method_per_entity' => FALSE]`.
`fieldSettingsForm()` adds one checkbox **"Select invocation method per entity"**
(`invocation_method_per_entity`) — when on, editors also pick a delivery method per entity.
Field settings schema: `field.field_settings.revive_adserver_zone`.

## Widget — `ReviveWidget` (`src/Plugin/Field/FieldWidget/ReviveWidget.php`)

`@FieldWidget(id = "revive_adserver_zone", label = "Default")`. Injects config.factory,
current_user, invocation manager. `formElement()`:

- `zone_id` — `number` (or a `select` of `getZonesOptionList()` when zones are synced),
  `#required` follows the field; **`#access` = `current_user->hasPermission('use revive_adserver field')`**.
- `invocation_method` — only added when `invocation_method_per_entity` is on; `select` of the
  method options (optionally narrowed by the widget's `invocation_methods` whitelist), also
  gated by `use revive_adserver field`.

Widget settings (`settingsForm()`, schema `field.widget.settings.revive_adserver_zone`):
`enabled_zones` (multi-select whitelist of selectable zones) and, when per-entity method is on,
`invocation_methods` (multi-select whitelist of methods). `massageFormValues()` drops empty
`zone_id`/`invocation_method` so an unset field stays empty.

## Formatter — `ReviveFormatter` (`src/Plugin/Field/FieldFormatter/ReviveFormatter.php`)

`@FieldFormatter(id = "revive_adserver_zone", field_types = {"revive_adserver_zone"})`.
`defaultSettings()` = `invocation_method` (`async_javascript`), `block_banner` (FALSE),
`block_banner_campaign` (FALSE); schema `field.formatter.settings.revive_adserver_zone`.
`settingsForm()` mirrors the block's method + block-banner checkboxes.

`viewElements()` per item:
1. `$method` = the formatter's `invocation_method` setting, **overridden** by the item's own
   `invocation_method` when `invocation_method_per_entity` is on and the item has one.
2. `loadInvocationMethodFromInput($method)` → `setZoneId($values['zone_id'])`,
   `setBlockBanner(...)`, `setBlockBannerCampaign(...)`, `prepare()`, then `render()`.

`settingsSummary()` shows the (fallback) method and any block-banner options. The rendered markup
is whatever the chosen InvocationMethodService produces — see
[../plugins/invocation-methods.md](../plugins/invocation-methods.md).

## Enable it

```bash
drush en revive_adserver -y
```

Then *Manage fields* → add a **"Revive Adserver Zone"** field; set the zone (and, if enabled, the
method) on the entity form; choose the delivery method on *Manage display*. Grant
**`use revive_adserver field`** to roles that should set the zone id / method on entities.
