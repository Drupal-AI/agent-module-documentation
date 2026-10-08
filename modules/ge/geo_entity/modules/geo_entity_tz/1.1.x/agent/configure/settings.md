# Configure GeoNames time zone lookup

## Settings form

Route `geo_entity_tz.settings_form` → `/admin/config/system/geo_entity_tz`
(permission `administer geo_entity_tz configuration`, `restrict access: true`). Form
`Drupal\geo_entity_tz\Form\SettingsForm`, config `geo_entity_tz.settings`:

| Key | Required | Meaning |
|---|---|---|
| `username` | yes | A GeoNames account username **enabled for the web service** (register + confirm + enable at geonames.org). |
| `token` | no | Token for a GeoNames premium/commercial web-service account. Saved as NULL when blank. |

Set it with drush:

```bash
ddev drush config:set geo_entity_tz.settings username YOUR_GEONAMES_USER -y
```

Without a username the lookup throws `GeonamesException` (code 1) and, for users holding the admin
permission, shows a "Timezone lookup requires Geonames Username" warning on save.

## Wire a tzfield to a geofield

There is no global mapping — each Time Zone field opts in individually. On a `tzfield`'s **field settings**
edit form (`field_config_edit_form`), `geo_entity_tz_form_field_config_edit_form_alter()` adds a **From
location field** select listing the bundle's geofields. Choosing one stores the third-party setting
`geo_entity_tz.geofield = <geofield_name>` on the field config. Only fields with that setting are looked up.

## Behavior on save

`hook_geo_entity_presave` iterates delta-by-delta over the geofield: it looks up the time zone when the
tzfield delta is empty, or when the geofield value changed vs `$geo->original`; otherwise it leaves the
existing value. See [api/service.md](../api/service.md) for the request details.
