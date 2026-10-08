# Licenses & configuration

## Admin UI & permission
- Route `entity.attribution_license.collection` → `/admin/structure/attribution-license`
  (the `configure` route). All license routes require the **`administer attribution_license`**
  permission (the config entity's `admin_permission`).
- Actions on the collection page: **Add license** (custom, via `AttributionLicensesForm`) and
  **Add custom license** (blank entity form `AttributionLicenseForm`). Edit/Delete per license.

## The `attribution_license` config entity
`src/Entity/AttributionLicense.php`, config prefix `attribution.attribution_license.<id>`.
Exported fields (schema `attribution.attribution_license.*`):

| Field | Type | Meaning |
|---|---|---|
| `id` | string | machine id (also directory/config key) |
| `identifier` | string | SPDX identifier, e.g. `CC-BY-4.0` |
| `name` | label | human name |
| `osiCertified` | bool | OSI-approved |
| `deprecated` | bool | SPDX deprecation status |
| `link` | string | URL to the license text |

Nine defaults install from `config/install`: `all_rights_reserved`, `cc0_1_0`, `cc_by_4_0`,
`cc_by_nc_4_0`, `cc_by_nc_nd_4_0`, `cc_by_nc_sa_4_0`, `cc_by_nd_4_0`, `cc_by_sa_4_0`,
`gpl_2_0_or_later`.

## Importing SPDX licenses
`AttributionLicensesForm` (route `entity.attribution_license.custom_add_form`,
`/admin/structure/attribution-license/add-custom`) lists all licenses from the bundled
`composer/spdx-licenses` package (400+). Selected ones are created as config entities; the machine
id is transliterated from the SPDX identifier. Re-importing an existing license shows "already
exists" rather than duplicating.

## Restricting licenses per field
An `attribution` field has a field setting `licenses` (multi-select of license ids;
`AttributionItem::fieldSettingsForm`). If set, the field's widget only offers those licenses;
if empty, all licenses are offered. Stored under `field.field_settings.attribution`.

## Creating a license in code
```php
\Drupal\attribution\Entity\AttributionLicense::create([
  'id' => 'cc_by_4_0',
  'identifier' => 'CC-BY-4.0',
  'name' => 'Creative Commons Attribution 4.0 International',
  'osiCertified' => FALSE,
  'deprecated' => FALSE,
  'link' => 'https://spdx.org/licenses/CC-BY-4.0.html#licenseText',
])->save();
```
