# Alter hooks

SimpleAds defines no plugin manager of its own; you extend it through these `hook_*_alter()` hooks, each
invoked from `SimpleAdsModule` (service `simpleads.module`) via `moduleHandler->alter()`. Implement them in
your `MYMODULE.module`.

| Hook | Signature | What you change |
|---|---|---|
| `hook_simpleads_advertisement_types_alter` | `(&$types)` | Ad `type` options. Default `['image','responsive_image','html5']` keyed by machine name → label. Add a type to introduce a new ad rendering (also add a matching `simpleads_<type>` theme/template and any base field). |
| `hook_simpleads_campaign_types_alter` | `(&$types)` | Campaign `type` options. Default `['click','impression','date']`. |
| `hook_simpleads_ui_field_mapping_alter` | `(&$mapping)` | The `type → CSS selectors` map that shows/hides fields on the ad and campaign forms (`advertisement_form`, `campaign_form` keys). |
| `hook_simpleads_graph_reports_alter` | `(&$options)` | The statistics tabs (id → `label`/`library`/`template`): `all_time`, `30day`, `7days`, `today`, `table`. |
| `hook_simpleads_group_properties_alter` | `(&$properties)` | The `loadByProperties()` filter used to select ads for a group (invoked in `Model\SimpleAdsGroups::load()`). Default `['group','status','inactive']`, plus `domain_access` when Domain + Domain Entity are enabled. |

Example — add a "video" ad type:

```php
function mymodule_simpleads_advertisement_types_alter(array &$types) {
  $types['video'] = t('Video');
}
```

Note: the first four are exposed through thin wrapper functions in `simpleads.module`
(`simpleads_advertisement_types()`, `simpleads_campaign_types()`, `simpleads_ui_field_mapping()`,
`simpleads_graph_reports()`) that just call the `simpleads.module` service. `simpleads_advertisement_types`
also backs the ad `type` field's `allowed_values_function`, and `simpleads_campaign_types` backs the campaign
`type` field's.
