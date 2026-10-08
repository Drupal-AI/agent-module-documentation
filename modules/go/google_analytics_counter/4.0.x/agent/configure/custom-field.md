# The counter field (`field_google_analytics_counter`)

The recommended way to display counts on nodes is the module's integer field
`field_google_analytics_counter`. It is added per content type from the **Custom field** form and populated
on cron (see [api/services.md](../api/services.md)).

## Configure-types form — `google_analytics_counter.configure_types_form`

Path `/admin/config/system/google-analytics-counter-configure-types`
(`GoogleAnalyticsCounterConfigureTypesForm`, requires `administer google analytics counter`). It renders:

- **Remove the custom field** checkbox → config `general_settings.gac_type_remove_storage`. When checked,
  submit deletes the field from every bundle and drops the field storage.
- One **checkbox per content type** (`gac_type_{machine_name}`). Checking a type adds the field to it;
  unchecking removes the field from that bundle. The chosen state is stored as
  `general_settings.gac_type_{machine_name}`.

Submit dispatches to `GoogleAnalyticsCounterCustomFieldGenerator` (service
`google_analytics_counter.custom_field_generator`):

| Action | Method |
|---|---|
| Add field to a bundle (+ save `gac_type_*` config) | `gacPreAddField($type, $key, $value)` → `gacAddField($type)` |
| Remove field from a bundle | `gacPreDeleteField($type, $key)` → `gacDeleteField($type)` |
| Drop the shared field storage | `gacDeleteFieldStorage()` |
| Null out all `gac_type_*` keys | `gacChangeConfigToNull()` |

## Field definition

- **Field name:** `field_google_analytics_counter` (`entity_type: node`, `type: integer`, cardinality 1).
- **Storage** is created from `config/optional/field.storage.node.field_google_analytics_counter.yml`
  the first time a bundle is checked (`gacAddField()` loads it via `FileStorage` from
  `modules/contrib/google_analytics_counter/config/optional`). Note the hard-coded `modules/contrib/…`
  path — the storage YAML must be reachable there for the fallback create to work.
- On add, `gacAddField()` also configures the default form display (numeric widget) and the `default` +
  `teaser` view displays (label hidden, numeric formatter).
- The value is written on cron by `GoogleAnalyticsCounterAppManager::gacUpdateStorage()` /
  `updateCounterStorage()` (an `upsert` into `node__field_google_analytics_counter`).

## Node-form behavior (`hook_form_node_form_alter`)

`google_analytics_counter_form_node_form_alter()` makes the field **readonly** on the node edit form (it is
maintained by cron, not by editors) and sets `#access` on it to the current user's `access content`
permission.

## Uninstall

`hook_uninstall` deletes `field_google_analytics_counter` from `node` bundles and its field storage, clears
module state (`GoogleAnalyticsCounterHelper::gacDeleteState()`), and removes queued worker items.

## Displaying elsewhere

You do not need the field to show a count — the block and the `[gac]` filter token call
`GoogleAnalyticsCounterAppManager::gacDisplayCount()` directly for the current page. See
[blocks/counter-block.md](../blocks/counter-block.md). For listings/sorting, the raw
`google_analytics_counter_storage` table is exposed to Views ([views/integration.md](../views/integration.md)),
though using this field is usually simpler.
