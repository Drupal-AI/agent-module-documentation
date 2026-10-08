# Permissions

Defined in `simpleads.permissions.yml`. Each of the three entity types gets the standard six-permission
set; `administer …` is the entity `admin_permission` and is marked `restrict access: true`.

| Permission | Grants |
|---|---|
| `add simpleads entities` | Create ads. Also gates the ad-title autocomplete route `simpleads.autocomplete`. |
| `administer simpleads entities` | Ad admin + all `/admin/config/simpleads/advertisement*` settings, ad list, and the per-ad `stats` tab. |
| `edit simpleads entities` | Edit ads. |
| `delete simpleads entities` | Delete ads. |
| `view published simpleads entities` | View published ads. |
| `view unpublished simpleads entities` | View unpublished ads. |
| `add / administer / edit / delete / view published / view unpublished simpleads_group entities` | Same six for the Group entity. |
| `add / administer / edit / delete / view published / view unpublished simpleads_campaign entities` | Same six for the Campaign entity. |
| `count simpleads clicks` | Required for a click to be recorded (checked in `Model\SimpleAds::click()`). |
| `count simpleads impressions` | Required for an impression to be recorded (`Model\SimpleAds::impression()`). |

Access is enforced by per-type handlers (`Entity/AccessControlHandler/{Advertisement,Campaign,Group}AccessControlHandler`)
which map view/update/delete operations to the permissions above (published vs. unpublished split for `view`).

## Permissions granted automatically at install

`simpleads_install()` grants BOTH the `anonymous` and `authenticated` roles these permissions (and
`simpleads_uninstall()` revokes them):

- `count simpleads clicks`, `count simpleads impressions`
- `restful post simpleads_click`, `restful post simpleads_impression`
- `restful get simpleads_group`, `restful get simpleads_reference`, `restful get simpleads_views`

These are the REST permissions (from the `rest` module, named `restful <method> <resource id>`) that let the
front-end JS fetch ad markup and post tracking beacons without a login. `restful get simpleads_stats` is
NOT granted by default — the stats REST endpoint stays closed until you grant it. See [../api/rest.md](../api/rest.md).

## Set via Drush

```bash
drush role:perm:add anonymous 'count simpleads impressions'
drush role:perm:add content_editor 'add simpleads entities,edit simpleads entities,delete simpleads entities'
```
